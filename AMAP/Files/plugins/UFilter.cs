using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using Newtonsoft.Json;
using Oxide.Core;
using Oxide.Core.Libraries.Covalence;
using Oxide.Core.Plugins;

namespace Oxide.Plugins
{
    [Info("UFilter", "Wulf/lukespragg", "5.1.2")]
    [Description("Prevents advertising and/or profanity and optionally punishes player")]
    public class UFilter : CovalencePlugin
    {
        #region Configuration

        private Configuration config;

        public class Configuration
        {
            [JsonProperty("Check for advertising (true/false)")]
            public bool CheckForAdvertising = true;

            [JsonProperty("Check for profanity (true/false)")]
            public bool CheckForProfanity = true;

            [JsonProperty("Check player chat (true/false)")]
            public bool CheckChat = true;

            [JsonProperty("Check player names (true/false)")]
            public bool CheckNames = true;

            [JsonProperty("Log advertising (true/false)")]
            public bool LogAdvertising = false;

            [JsonProperty("Log profanity (true/false)")]
            public bool LogProfanity = false;

            [JsonProperty("Log to console (true/false)")]
            public bool LogToConsole = false;

            [JsonProperty("Log to file (true/false)")]
            public bool LogToFile = false;

            [JsonProperty("Warn player in chat (true/false)")]
            public bool WarnInChat = true;

            [JsonProperty("Action for advertising")]
            public string ActionForAdvertising = "block";

            [JsonProperty("Action for profanity")]
            public string ActionForProfanity = "censor";

            [JsonProperty("Word or symbol to use for censoring")]
            public string CensorText = "*";

            [JsonProperty("Allowed advertisements")]
            public List<string> AllowedAds = new List<string>();

            [JsonProperty("Allowed profanity")]
            public List<string> AllowedProfanity = new List<string>();
        }

        protected override void LoadConfig()
        {
            base.LoadConfig();
            try
            {
                config = Config.ReadObject<Configuration>();
                if (config == null)
                {
                    LoadDefaultConfig();
                }
            }
            catch
            {
                LoadDefaultConfig();
            }
            SaveConfig();
        }

        protected override void LoadDefaultConfig()
        {
            string configPath = $"{Interface.Oxide.ConfigDirectory}{Path.DirectorySeparatorChar}{Name}.json";
            LogWarning($"Could not load a valid configuration file, creating a new configuration file at {configPath}");
            config = new Configuration();
        }

        protected override void SaveConfig() => Config.WriteObject(config);

        #endregion Configuration

        #region Localization

        private new void LoadDefaultMessages()
        {
            lang.RegisterMessages(new Dictionary<string, string>
            {
                ["CommandUsage"] = "Usage:\n{0} <add/remove> <word or phrase>\n{0} <list> shows profanity list",
                ["NoAdvertising"] = "Advertising is not allowed on this server",
                ["NoData"] = "The profanity list is empty",
                ["NoProfanity"] = "Profanity is not allowed on this server",
                ["NotAllowed"] = "You are not allowed to use the '{0}' command",
                ["WordAdded"] = "Word '{0}' was added to the profanity list",
                ["WordListed"] = "Word '{0}' is already in the profanity list",
                ["WordNotListed"] = "Word '{0}' is not in the profanity list",
                ["WordRemoved"] = "Word '{0}' was removed from the profanity list",
            }, this);
        }

        #endregion Localization

        #region Initialization

        [PluginReference]
        private readonly Plugin BetterChat, Slap;

        private const string permAdmin = "ufilter.admin";
        private const string permBypass = "ufilter.bypass";

        private static readonly Regex ipRegex = new Regex(@"(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}(:\d{2,5})?)");
        private static readonly Regex domainRegex = new Regex(@"(\w{2,}\.\w{2,3}\.\w{2,3}|\w{2,}\.\w{2,3}(:\d{2,5})?)$");

        #region Blocked Words

        private StoredData storedData;

        private class StoredData
        {
            public readonly HashSet<string> Profanities = new HashSet<string>();
        }

        #endregion Blocked Words

        private void OnServerInitialized()
        {
            storedData = Interface.Oxide.DataFileSystem.ReadObject<StoredData>(Name);

            permission.RegisterPermission(permAdmin, this);
            permission.RegisterPermission(permBypass, this);

            if (BetterChat != null && BetterChat.IsLoaded)
            {
#if RUST
                Unsubscribe(nameof(OnPlayerChat));
#else
                Unsubscribe(nameof(OnUserChat));
#endif
            }

            if (!config.CheckNames)
            {
                Unsubscribe(nameof(OnUserRespawned));
                Unsubscribe(nameof(OnUserSpawned));
            }
        }

        private void SaveData() => Interface.Oxide.DataFileSystem.WriteObject(Name, storedData);

        #endregion Initialization

        #region Filter Matching

        private string[] Advertisements(string text)
        {
            IEnumerable<string> ips = ipRegex.Matches(text).OfType<Match>().Select(m => m.Value);
            IEnumerable<string> domains = domainRegex.Matches(text.ToLower()).OfType<Match>().Select(m => m.Value.ToLower());
            return ips.Concat(domains).Where(a => !config.AllowedAds.Contains(a)).ToArray();
        }

        private string[] Profanities(string text)
        {
            return Regex.Split(text, @"\W").Where(w => storedData.Profanities.Contains(w.ToLower()) && !config.AllowedProfanity.Contains(w.ToLower())).ToArray();
        }

        #endregion Filter Matching

        #region Text Processing

        private string ProcessText(string text, IPlayer player)
        {
            if (player.HasPermission(permBypass))
            {
                return text;
            }

            string[] profanities = Profanities(text);
            string[] advertisements = Advertisements(text);

            if (config.CheckForProfanity && profanities.Length > 0)
            {
                if (config.WarnInChat)
                {
                    Message(player, "NoProfanity", player.Id);
                }

                if (config.LogProfanity)
                {
                    foreach (string profanity in profanities)
                    {
                        Log($"{player.Name} ({player.Id}) {DateTime.Now}: {profanity}", "profanity");
                    }
                }

                return TakeAction(player, text, profanities, config.ActionForProfanity, GetLang("NoProfanity", player.Id));
            }

            if (config.CheckForAdvertising && advertisements.Length > 0)
            {
                if (config.WarnInChat)
                {
                    Message(player, "NoAdvertising", player.Id);
                }

                if (config.LogAdvertising)
                {
                    foreach (string advertisement in advertisements)
                    {
                        Log($"{player.Name} ({player.Id}) {DateTime.Now}: {advertisement}", "ads");
                    }
                }

                return TakeAction(player, text, advertisements, config.ActionForAdvertising, GetLang("NoAdvertising", player.Id));
            }

            return text;
        }

        #endregion Text Processing

        #region Action Processing

        private string TakeAction(IPlayer player, string text, string[] list, string action, string reason)
        {
            if (string.IsNullOrEmpty(action))
            {
                return string.Empty;
            }

            switch (action.ToLower().Trim())
            {
                case "ban":
                    player.Ban(reason);
                    return string.Empty;

                case "censor":
                    foreach (string word in list)
                    {
                        text = text.Replace(word, config.CensorText.Length == 1 ? new string(config.CensorText[0], word.Length) : config.CensorText);
                    }
                    return text;

                case "kick":
                    player.Kick(reason);
                    return string.Empty;

                case "kill":
                    player.Kill();
                    return string.Empty;

                case "slap":
                    if (Slap != null && Slap.IsLoaded)
                    {
                        Slap.Call("SlapPlayer", player);
                    }
                    else
                    {
                        LogWarning("Slap plugin is not installed; slap action will not work");
                    }
                    return string.Empty;

                default:
                    return string.Empty;
            }
        }

        #endregion Action Processing

        #region Chat Handling

        private string HandleChat(IPlayer player, string message)
        {
            if (player == null || string.IsNullOrEmpty(message))
            {
                return null;
            }

            string processed = ProcessText(message, player);
            if (processed == string.Empty)
            {
                return processed;
            }

            if (!string.Equals(message, processed))
            {
                if (BetterChat != null && BetterChat.IsLoaded)
                {
                    return processed;
                }

                // Rust colors: Admin/moderator = #aaff55, Developer = #ffaa55, Player = #55aaff
                string prefix = covalence.FormatText($"[{(player.IsAdmin ? "#aaff55" : "#55aaff")}]{player.Name}[/#]");
                return $"{prefix}: {processed}";
            }

            return null;
        }

        private object OnBetterChat(Dictionary<string, object> data)
        {
            string processed = HandleChat(data["Player"] as IPlayer, data["Message"] as string);

            if (!Equals(data["Message"] as string, processed) && !string.IsNullOrEmpty(processed))
            {
                data["Message"] = processed;
                return data;
            }

            if (processed == string.Empty)
            {
                data["CancelOption"] = 2;
                return data;
            }

            return null;
        }

#if RUST
        private object OnPlayerChat(BasePlayer basePlayer, string message, ConVar.Chat.ChatChannel channel)
        {
            string processed = HandleChat(basePlayer.IPlayer, message);

            if (!string.IsNullOrEmpty(processed))
            {
                Broadcast(basePlayer.IPlayer, processed, (int)channel);
                return true;
            }

            if (processed == string.Empty)
            {
                return true;
            }

            return null;
        }
#else
        private object OnUserChat(IPlayer player, string message)
        {
            if (BetterChat == null || !BetterChat.IsLoaded)
            {
                string processed = HandleChat(player, message);

                if (!string.IsNullOrEmpty(processed))
                {
                    Broadcast(player, processed);
                    return true;
                }

                if (processed == string.Empty)
                {
                    return true;
                }
            }

            return null;
        }
#endif

        #endregion Chat Handling

        #region Name Handling

        private void ProcessName(IPlayer player)
        {
            string processed = ProcessText(player.Name, player);

            if (player.Name != processed)
            {
                player.Rename(processed);
            }
            else if (string.IsNullOrEmpty(processed))
            {
                player.Rename("Unnamed" + new System.Random()); // TODO: Config option
            }
        }

        private void OnUserRespawned(IPlayer player) => ProcessName(player);

        private void OnUserSpawned(IPlayer player) => ProcessName(player);

        #endregion Name Handling

        #region API

        private string[] GetProfanities() => storedData?.Profanities.ToArray();
        private string[] GetAllowedProfanity() => config?.AllowedProfanity.ToArray();

        private bool AddProfanity(string profanity)
        {
            if (storedData == null || storedData.Profanities.Contains(profanity))
            {
                return false;
            }

            storedData.Profanities.Add(profanity);
            Interface.CallHook("OnProfanityAdded", profanity);
            return true;
        }

        private bool RemoveProfanity(string profanity)
        {
            if (storedData == null || storedData.Profanities.Contains(profanity))
            {
                return false;
            }

            storedData.Profanities.Remove(profanity);
            Interface.CallHook("OnProfanityRemoved", profanity);
            return true;
        }

        #endregion API

        #region Commands

        [Command("ufilter")] // TODO: Localization
        private void FilterCommand(IPlayer player, string command, string[] args)
        {
            if (!player.HasPermission(permAdmin))
            {
                Message(player, "NotAllowed", command);
                return;
            }

            if (args.Length < 1 || args.Length < 2 && args[0].ToLower() != "list")
            {
                Message(player, "CommandUsage", command);
                return;
            }

            string argList = string.Join(" ", args.Skip(1).ToArray());
            switch (args[0].ToLower())
            {
                case "+":
                case "add":
                    if (!AddProfanity(argList))
                    {
                        Message(player, "WordListed", argList);
                        break;
                    }

                    Message(player, "WordAdded", argList);
                    break;

                case "-":
                case "del":
                case "delete":
                case "remove":
                    if (!RemoveProfanity(argList))
                    {
                        Message(player, "WordNotListed", argList);
                        break;
                    }

                    Message(player, "WordRemoved", argList);
                    break;

                case "list":
                    string message = string.Join(", ", storedData.Profanities);
                    Message(player, string.IsNullOrEmpty(message) ? "NoData" : message);
                    break;

                default:
                    Message(player, "CommandUsage", command);
                    break;
            }
        }

        #endregion Commands

        #region Helpers

        private void AddLocalizedCommand(string key, string command)
        {
            foreach (string language in lang.GetLanguages(this))
            {
                Dictionary<string, string> messages = lang.GetMessages(language, this);
                foreach (KeyValuePair<string, string> message in messages.Where(m => m.Key.Equals(key)))
                {
                    if (!string.IsNullOrEmpty(message.Value))
                    {
                        AddCovalenceCommand(message.Value, command);
                    }
                }
            }
        }

        private void Broadcast(IPlayer sender, string text, int channel = 0)
        {
#if RUST
            foreach (IPlayer target in players.Connected)
            {
                target.Command("chat.add", channel, sender.Id, text);
            }
#else
            server.Broadcast(text);
#endif
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

        private void Log(string text, string filename)
        {
            if (config.LogToConsole)
            {
                Puts(text);
            }

            if (config.LogToFile)
            {
                LogToFile(filename, $"[{DateTime.Now}] {text}", this);
            }
        }

        #endregion Helpers
    }
}