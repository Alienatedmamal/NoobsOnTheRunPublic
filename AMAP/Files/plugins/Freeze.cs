﻿using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using Oxide.Core.Libraries.Covalence;
using Oxide.Core.Plugins;
#if RUST
using UnityEngine;
#endif

namespace Oxide.Plugins
{
    [Info("Freeze", "Wulf", "3.0.3")]
    [Description("Prevents players from moving, and optionally prevents chat, commands, and damage")]
    internal class Freeze : CovalencePlugin
    {
        #region Configuration

        private Configuration config;

        private class Configuration
        {
            [JsonProperty("Block chat while frozen")]
            public bool BlockChat = true;

            [JsonProperty("Block commands while frozen")]
            public bool BlockCommands = true;

            [JsonProperty("Block damage while frozen")]
            public bool BlockDamage = true;

            [JsonProperty("Block movement while frozen")]
            public bool BlockMovement = true;
#if RUST
            [JsonProperty("Enable frozen effect")]
            public bool EnableEffect = true;
#endif
            [JsonProperty("Notify target when frozen")]
            public bool NotifyTarget = true;

            public string ToJson() => JsonConvert.SerializeObject(this);

            public Dictionary<string, object> ToDictionary() => JsonConvert.DeserializeObject<Dictionary<string, object>>(ToJson());
        }

        protected override void LoadDefaultConfig() => config = new Configuration();

        protected override void LoadConfig()
        {
            base.LoadConfig();
            try
            {
                config = Config.ReadObject<Configuration>();
                if (config == null)
                {
                    throw new JsonException();
                }

                if (!config.ToDictionary().Keys.SequenceEqual(Config.ToDictionary(x => x.Key, x => x.Value).Keys))
                {
                    LogWarning("Configuration appears to be outdated; updating and saving");
                    SaveConfig();
                }
            }
            catch
            {
                LogWarning($"Configuration file {Name}.json is invalid; using defaults");
                LoadDefaultConfig();
            }
        }

        protected override void SaveConfig()
        {
            LogWarning($"Configuration changes saved to {Name}.json");
            Config.WriteObject(config, true);
        }

        #endregion Configuration

        #region Localization

        protected override void LoadDefaultMessages()
        {
            lang.RegisterMessages(new Dictionary<string, string>
            {
                ["CommandFreeze"] = "freeze",
                ["CommandFreezeAll"] = "freezeall",
                ["CommandUnfreeze"] = "unfreeze",
                ["CommandUnfreezeAll"] = "unfreezeall",
                ["NoPlayersFound"] = "No players found with '{0}'",
                ["NoPlayersToFreeze"] = "No players to freeze",
                ["NoPlayersToUnfreeze"] = "No players to unfreeze",
                ["NotAllowed"] = "You are not allowed to use the '{0}' command",
                ["PlayerFrozen"] = "{0} has been frozen",
                ["PlayerIsProtected"] = "{0} is protected and cannot be frozen",
                ["PlayerIsFrozen"] = "{0} is already frozen",
                ["PlayerNotFrozen"] = "{0} is not frozen",
                ["PlayerUnfrozen"] = "{0} has been unfrozen",
                ["PlayersFound"] = "Multiple players were found, please specify: {0}",
                ["PlayersFrozen"] = "All players have been frozen",
                ["PlayersUnfrozen"] = "All players have been unfrozen",
                ["UsageFreeze"] = "Usage: {0} <player name or id>",
                ["YouCanNotBeFrozen"] = "You can not be frozen",
                ["YouAreFrozen"] = "You are frozen",
                ["YouWereUnfrozen"] = "You were unfrozen"
            }, this);
        }

        #endregion Localization

        #region Initialization

        private readonly Dictionary<string, Timer> timers = new Dictionary<string, Timer>();

        private const string permFrozen = "freeze.frozen";
        private const string permProtect = "freeze.protect";
        private const string permUse = "freeze.use";

        [PluginReference]
        private Plugin BetterChat;

        private void Init()
        {
            AddLocalizedCommand(nameof(CommandFreeze));
            AddLocalizedCommand(nameof(CommandFreezeAll));
            AddLocalizedCommand(nameof(CommandUnfreeze));
            AddLocalizedCommand(nameof(CommandUnfreezeAll));

            permission.RegisterPermission(permFrozen, this);
            permission.RegisterPermission(permProtect, this);
            permission.RegisterPermission(permUse, this);

            if (!config.BlockChat || BetterChat != null && BetterChat.IsLoaded)
            {
                Unsubscribe(nameof(OnUserChat));
            }
            if (!config.BlockCommands)
            {
                Unsubscribe(nameof(OnUserCommand));
            }
            if (!config.BlockDamage)
            {
#if RUST
                Unsubscribe(nameof(OnEntityTakeDamage));
#endif
            }
#if RUST
            if (!config.EnableEffect)
            {
                Unsubscribe(nameof(OnPlayerMetabolize));
                Unsubscribe(nameof(OnUserPermissionRevoked));
            }
#endif
        }

        #endregion Initialization

        #region Freeze Command

        private void CommandFreeze(IPlayer player, string command, string[] args)
        {
            if (!player.HasPermission(permUse))
            {
                Message(player, "NotAllowed", command);
                return;
            }

            if (args.Length < 1)
            {
                Message(player, "UsageFreeze", command);
                return;
            }

            IPlayer target = FindPlayer(args[0], player);
            if (target == null)
            {
                return;
            }

            if (target.Id == player.Id)
            {
                Message(player, "YouCanNotBeFrozen");
                return;
            }

            if (target.HasPermission(permProtect))
            {
                Message(player, "PlayerIsProtected", target.Name.Sanitize());
            }
            else if (target.HasPermission(permFrozen))
            {
                Message(player, "PlayerIsFrozen", target.Name.Sanitize());
            }
            else
            {
                FreezePlayer(target);

                if (config.NotifyTarget)
                {
                    Message(target, "YouAreFrozen");
                }
                Message(player, "PlayerFrozen", target.Name.Sanitize());
            }
        }

        #endregion Freeze Command

        #region Freeze All Command

        private void CommandFreezeAll(IPlayer player, string command, string[] args)
        {
            if (!player.HasPermission(permUse))
            {
                Message(player, "NotAllowed", command);
                return;
            }

            foreach (IPlayer target in players.Connected)
            {
                if (!target.HasPermission(permProtect) && !target.HasPermission(permFrozen))
                {
                    if (target.Id != player.Id)
                    {
                        FreezePlayer(target);

                        if (config.NotifyTarget)
                        {
                            Message(target, "YouAreFrozen");
                        }
                    }
                }
            }

            Message(player, players.Connected.Any() ? "PlayersFrozen" : "NoPlayersToFreeze");
        }

        #endregion Freeze All Command

        #region Unfreeze Command

        private void CommandUnfreeze(IPlayer player, string command, string[] args)
        {
            if (!player.HasPermission(permUse))
            {
                Message(player, "NotAllowed", command);
                return;
            }

            if (args.Length < 1)
            {
                Message(player, "UsageFreeze", command);
                return;
            }

            IPlayer target = FindPlayer(args[0], player);
            if (target == null)
            {
                return;
            }

            if (target.HasPermission(permFrozen))
            {
                UnfreezePlayer(target);

                Message(target, "YouWereUnfrozen", target.Id);
                Message(player, "PlayerUnfrozen", target.Name.Sanitize());
            }
            else
            {
                Message(player, "PlayerNotFrozen", target.Name.Sanitize());
            }
        }

        #endregion Unfreeze Command

        #region Unfreeze All Command

        private void CommandUnfreezeAll(IPlayer player, string command, string[] args)
        {
            if (!player.HasPermission(permUse))
            {
                Message(player, "NotAllowed", command);
                return;
            }

            foreach (IPlayer target in players.Connected)
            {
                if (target.HasPermission(permFrozen))
                {
                    UnfreezePlayer(target);

                    if (target.IsConnected)
                    {
                        Message(target, "YouWereUnfrozen");
                    }
                }
            }

            Message(player, players.Connected.Any() ? "PlayersUnfrozen" : "NoPlayersToUnfreeze");
        }

        #endregion Unfreeze All Command

        #region Freeze Handling

        private void FreezePlayer(IPlayer player)
        {
            player.GrantPermission(permFrozen);

            if (config.BlockMovement)
            {
                GenericPosition pos = player.Position();
                timers[player.Id] = timer.Every(0.1f, () =>
                {
                    if (!player.IsConnected)
                    {
                        timers[player.Id].Destroy();
                        return;
                    }

                    if (!player.HasPermission(permFrozen))
                    {
                        UnfreezePlayer(player);
                    }
                    else
                    {
                        player.Teleport(pos.X, pos.Y, pos.Z);
                    }
                });
            }
        }

        private void UnfreezePlayer(IPlayer player)
        {
            player.RevokePermission(permFrozen);

            if (timers.ContainsKey(player.Id))
            {
                timers[player.Id].Destroy();
            }
        }

        private object OnUserCommand(IPlayer player)
        {
            if (player.HasPermission(permFrozen))
            {
                return true;
            }

            return null;
        }

        private void OnUserConnected(IPlayer player)
        {
            if (player.HasPermission(permFrozen))
            {
                FreezePlayer(player);

                Log(GetLang("PlayerFrozen", null, player.Name.Sanitize()));
            }
        }

        private object OnUserChat(IPlayer player)
        {
            if (player.HasPermission(permFrozen))
            {
                return true;
            }

            return null;
        }

        private object OnBetterChat(Dictionary<string, object> data)
        {
            if ((data["Player"] as IPlayer).HasPermission(permFrozen))
            {
                data["CancelOption"] = 1;
                return data;
            }

            return null;
        }

        private void OnServerInitialized()
        {
            foreach (IPlayer player in players.Connected)
            {
                if (player.HasPermission(permFrozen))
                {
                    FreezePlayer(player);

                    Log(GetLang("PlayerFrozen", null, player.Name.Sanitize()));
                }
            }
        }

#if RUST

        private void OnPlayerMetabolize(PlayerMetabolism metabolism, BasePlayer basePlayer)
        {
            if (permission.UserHasPermission(basePlayer.UserIDString, permFrozen))
            {
                metabolism.temperature.SetValue(-50f);
                metabolism.SendChangesToClient();

                Vector3 breathPosition = basePlayer.eyes.position + Quaternion.Euler(basePlayer.serverInput.current.aimAngles) * new Vector3(0, 0, 0.2f);
                Effect.server.Run("assets/bundled/prefabs/fx/player/frosty_breath.prefab", breathPosition);
            }
        }

        private void OnEntityTakeDamage(BasePlayer basePlayer, HitInfo hitInfo)
        {
            if (permission.UserHasPermission(basePlayer.UserIDString, permFrozen) && hitInfo != null
                || hitInfo?.InitiatorPlayer != null && permission.UserHasPermission(hitInfo.InitiatorPlayer.UserIDString, permFrozen))
            {
                hitInfo.damageTypes = new global::Rust.DamageTypeList();
                hitInfo.HitMaterial = 0;
                hitInfo.PointStart = Vector3.zero;
            }
        }

        private void OnUserPermissionRevoked(string playerId, string perm)
        {
            IPlayer player = players.FindPlayerById(playerId);
            BasePlayer basePlayer = player?.Object as BasePlayer;
            if (basePlayer != null)
            {
                basePlayer.metabolism.temperature.Reset();
                basePlayer.metabolism.SendChangesToClient();
            }
        }

#endif

        #endregion Freeze Handling

        #region Helpers

        private IPlayer FindPlayer(string playerNameOrId, IPlayer player)
        {
            IPlayer[] foundPlayers = players.FindPlayers(playerNameOrId).ToArray();
            if (foundPlayers.Length > 1)
            {
                Message(player, "PlayersFound", string.Join(", ", foundPlayers.Select(p => p.Name).Take(10).ToArray()).Truncate(60));
                return null;
            }

            IPlayer target = foundPlayers.Length == 1 ? foundPlayers[0] : null;
            if (target == null)
            {
                Message(player, "NoPlayersFound", playerNameOrId);
                return null;
            }

            return target;
        }

        private void AddLocalizedCommand(string command)
        {
            foreach (string language in lang.GetLanguages(this))
            {
                Dictionary<string, string> messages = lang.GetMessages(language, this);
                foreach (KeyValuePair<string, string> message in messages)
                {
                    if (message.Key.Equals(command))
                    {
                        if (!string.IsNullOrEmpty(message.Value))
                        {
                            AddCovalenceCommand(message.Value, command);
                        }
                    }
                }
            }
        }

        private string GetLang(string langKey, string playerId = null, params object[] args)
        {
            return string.Format(lang.GetMessage(langKey, this, playerId), args);
        }

        private void Message(IPlayer player, string textOrLang, params object[] args)
        {
            if (player.IsConnected)
            {
                string message = GetLang(textOrLang, player.Id, args);
                player.Reply(message != textOrLang ? message : textOrLang);
            }
        }

        #endregion Helpers
    }
}
