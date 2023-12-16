using Newtonsoft.Json;
using Oxide.Core;
using Oxide.Core.Configuration;
using Oxide.Core.Libraries;
using Oxide.Core.Libraries.Covalence;
using Oxide.Plugins;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using UnityEngine;

namespace Oxide.Plugins
{
    [Info("Welcomer", "Dana", "2.1.0")]
    [Description("Welcomes players and announces when they join or leave.")]
    public class Welcomer : RustPlugin
    {
        #region Fields

        private const string permissionBypass = "welcomer.bypass";

        private static Configuration config;

        private Data data;
        private DynamicConfigFile dataFile;

        private const string apiUrl = "http://ip-api.com/json/";

        private List<ulong> playersToWelcome { get; set; } = new List<ulong>();

        #endregion

        #region Configuration
        
        private class Configuration
        {
            [JsonProperty(PropertyName = "Chat Avatar")]
            public ulong ChatAvatar { get; set; }

            [JsonProperty(PropertyName = "Show Player Avatar")]
            public bool ShowPlayerAvatar { get; set; }

            [JsonProperty(PropertyName = "Enable Chat Welcome Message")]
            public bool EnableChatWelcomeMessage { get; set; }

            [JsonProperty(PropertyName = "Enable Console Welcome Message")]
            public bool EnableConsoleWelcomeMessage { get; set; }

            [JsonProperty(PropertyName = "Enable Join Message")]
            public bool EnableJoinMessage { get; set; }

            [JsonProperty(PropertyName = "Enable Newcomer Join Message")]
            public bool EnableNewcomerJoinMessage { get; set; }

            [JsonProperty(PropertyName = "Enable Leave Message")]
            public bool EnableLeaveMessage { get; set; }

            [JsonProperty(PropertyName = "Enable Rage Quit Message")]
            public bool EnableRageQuitMessage { get; set; }

            [JsonProperty(PropertyName = "Clear Data On Wipe")]
            public bool ClearDataOnWipe { get; set; }

            [JsonProperty(PropertyName = "Log To Console")]
            public bool LogToConsole { get; set; }
        }

        private Configuration GetDefaultConfig()
        {
            return new Configuration
            {
                ChatAvatar = 0,
                ShowPlayerAvatar = false,
                EnableChatWelcomeMessage = true,
                EnableConsoleWelcomeMessage = true,
                EnableJoinMessage = true,
                EnableNewcomerJoinMessage = true,
                EnableLeaveMessage = true,
                EnableRageQuitMessage = false,
                ClearDataOnWipe = true,
                LogToConsole = true,
            };
        }

        protected override void LoadConfig()
        {
            base.LoadConfig();
            config = Config.ReadObject<Configuration>();

            SaveConfig();
        }

        protected override void LoadDefaultConfig()
        {
            config = GetDefaultConfig();
        }

        protected override void SaveConfig()
        {
            Config.WriteObject(config, true);
        }

        #endregion

        #region Data

        private class Data
        {
            [JsonProperty(PropertyName = "Players Data")]
            public Dictionary<ulong, PlayerData> Players { get; set; } = new Dictionary<ulong, PlayerData>();
        }

        private class PlayerData
        {
            [JsonProperty("Country")]
            public string Country { get; set; }
        }
        
        private void CreatePlayerData(ulong playerId, string country)
        {
            data.Players[playerId] = new PlayerData
            {
                Country = country,
            };

            SaveData();
        }
        
        private PlayerData GetPlayerData(ulong playerId)
        {
            PlayerData playerData;
            return data.Players.TryGetValue(playerId, out playerData) ? playerData : null;
        }

        private void LoadData()
        {
            dataFile = Interface.Oxide.DataFileSystem.GetFile(Name);
            data = dataFile.ReadObject<Data>();

            if (data == null)
                data = new Data();
        }

        private void SaveData()
        {
            dataFile.WriteObject(data);
        }

        private void ClearData()
        {
            data = new Data();
            SaveData();
        }

        #endregion

        #region Hooks

        #region Initialization and Quitting Hooks

        private void Init()
        {
            permission.RegisterPermission(permissionBypass, this);
            LoadData();
        }

        private void Unload()
        {
            config = null;
            SaveData();
        }

        #endregion

        #region Server Hooks

        private void OnServerSave()
        {
            SaveData();
        }

        private void OnNewSave(string fileName)
        {
            if (config.ClearDataOnWipe)
                ClearData();
        }

        #endregion

        #region Player Hooks

        private void OnPlayerConnected(BasePlayer player)
        {
            if (config.EnableChatWelcomeMessage || config.EnableConsoleWelcomeMessage)
                playersToWelcome.Add(player.userID);
            
            if (HasPermission(player, permissionBypass))
                return;
            
            string ipAddress = ProcessAddress(player);

            TryExtractCountry(player, apiUrl, ipAddress,
                requestCallback: country =>
                {
                    if (!data.Players.ContainsKey(player.userID) && config.EnableNewcomerJoinMessage)
                    {
                        SendMessageToAll(player, GetMessage(MessageKey.JoinNewcomer, player.UserIDString, player.displayName, country));
                        CreatePlayerData(player.userID, country);

                        if (config.LogToConsole)
                            Puts(StripRichText(GetMessage(MessageKey.JoinNewcomer, player.UserIDString, player.displayName, country)));
                    }
                    else
                    {
                        if (config.EnableJoinMessage)
                            SendMessageToAll(player, GetMessage(MessageKey.Join, player.UserIDString, player.displayName, country));

                        if (config.LogToConsole)
                            Puts(StripRichText(GetMessage(MessageKey.JoinNewcomer, player.UserIDString, player.displayName, country)));
                    }
                }
            );
        }

        private void OnPlayerSleepEnded(BasePlayer player)
        {
            if (!playersToWelcome.Contains(player.userID))
                return;

            int activePlayers = BasePlayer.activePlayerList.Count;
            int sleepingPlayers = BasePlayer.sleepingPlayerList.Count;
            int queuedPlayers = ServerMgr.Instance.connectionQueue.queue.Count;
            int joiningPlayers = ServerMgr.Instance.connectionQueue.joining.Count;

            if (config.EnableChatWelcomeMessage)
                SendChatMessage(player, GetMessage(MessageKey.WelcomeChat, player.UserIDString, activePlayers, joiningPlayers, sleepingPlayers, queuedPlayers));

            if (config.EnableConsoleWelcomeMessage)
                SendConsoleMessage(player, GetMessage(MessageKey.WelcomeConsole, player.UserIDString, activePlayers, joiningPlayers, sleepingPlayers, queuedPlayers));

            playersToWelcome.Remove(player.userID);
        }

        private void OnPlayerDisconnected(BasePlayer player, string reason)
        {
            if (HasPermission(player, permissionBypass))
                return;

            if (config.EnableLeaveMessage)
                SendMessageToAll(player, GetMessage(MessageKey.Leave, player.UserIDString, player.displayName, reason));

            if (config.EnableRageQuitMessage && player.IsDead())
                SendMessageToAll(player, GetMessage(MessageKey.LeaveRageQuit, player.UserIDString, player.displayName));
        }

        #endregion

        #endregion

        #region Functions
        
        private void TryExtractCountry(BasePlayer player, string url, string ipAddress, Action<string> requestCallback)
        {
            string country = "Unknown";

            PlayerData playerData = GetPlayerData(player.userID);
            if (playerData != null && playerData.Country != null && playerData.Country != "Unknown")
            {
                country = playerData.Country;
                requestCallback(country);
                return;
            }

            webrequest.Enqueue(url + ipAddress, null, (statusCode, response) =>
            {
                if (statusCode != 200 || string.IsNullOrWhiteSpace(response))
                {
                    PrintError($"Request to {apiUrl} for {player.userID} was unsuccessful. Status code: {statusCode}");
                    requestCallback(country);
                    return;
                }

                try
                {
                    country = JsonConvert.DeserializeObject<PlayerData>(response).Country;
                }
                catch (Exception exception)
                {
                    PrintError($"Error parsing country from {apiUrl}\n{exception.Message}");
                    requestCallback(country);
                    return;
                }

                requestCallback(country);

            }, this, RequestMethod.GET);
        }

        private string ProcessAddress(BasePlayer player)
        {
            string[] ipAddress = player.net?.connection?.ipaddress?.Split(':');

            if (ipAddress == null || ipAddress.Length == 0)
                return null;

            string result = ipAddress[0];
            return result;
        }

        #endregion

        #region Helper Functions

        private bool HasPermission(BasePlayer player, string permissionName)
        {
            return permission.UserHasPermission(player.UserIDString, permissionName);
        }

        private void SendConsoleMessage(BasePlayer player, string message)
        {
            player.ConsoleMessage(message);
        }

        private void SendChatMessage(BasePlayer player, string message)
        {
            Player.Message(player, message, config.ChatAvatar);
        }

        private void SendMessageToAll(BasePlayer player, string message)
        {
            Server.Broadcast(message, config.ShowPlayerAvatar ? player.userID : config.ChatAvatar);
        }

        private string StripRichText(string message)
        {
            if (message == null)
                message = string.Empty;

            string[] stringReplacements = new string[]
            {
                "<b>", "</b>",
                "<i>", "</i>",
                "</size>",
                "</color>"
            };

            Regex[] regexReplacements = new Regex[]
            {
                new Regex(@"<color=.+?>"),
                new Regex(@"<size=.+?>"),
            };

            foreach (var replacement in stringReplacements)
                message = message.Replace(replacement, string.Empty);

            foreach (var replacement in regexReplacements)
                message = replacement.Replace(message, string.Empty);

            return Formatter.ToPlaintext(message);
        }

        #endregion

        #region Commands

        private static class Command
        {
            public const string Clear = "welcomer.clear";
            public const string Test = "welcomer.test";
        }

        [ConsoleCommand(Command.Clear)]
        private void cmdClear(ConsoleSystem.Arg conArgs)
        {
            if (conArgs.IsClientside)
                return;

            ClearData();
            Puts("Players data cleared");
        }

        [ChatCommand(Command.Test)]
        private void cmdTest(BasePlayer player, string cmd, string[] args)
        {
            if (player == null || !player.IsAdmin)
                return;

            SendChatMessage(player, GetMessage(MessageKey.Test, player.UserIDString));
        }

        #endregion

        #region Localization

        private class MessageKey
        {
            public const string WelcomeChat = "Welcome.Chat";
            public const string WelcomeConsole = "Welcome.Console";
            public const string Join = "Join";
            public const string JoinNewcomer = "Join.Newcomer ";
            public const string Leave = "Leave";
            public const string LeaveRageQuit = "Leave.RageQuit";
            public const string Test = "Test";
        }

        protected override void LoadDefaultMessages()
        {
            lang.RegisterMessages(new Dictionary<string, string>
            {
                [MessageKey.WelcomeChat] = "There are currently {0} active players, {1} joining, {2} sleepers, and {3} in the queue",
                [MessageKey.WelcomeConsole] = "There are currently {0} active players, {1} joining, {2} sleepers, and {3} in the queue",

                [MessageKey.Join] = "{0} joined from {1}",
                [MessageKey.JoinNewcomer] = "{0} joined for the very first time from {1}",

                [MessageKey.Leave] = "{0} left the server for the reason {1}",
                [MessageKey.LeaveRageQuit] = "{0} rage quitted",

                [MessageKey.Test] = "Test message",
            }, this, "en");
        }

        private string GetMessage(string messageKey, string playerId = null, params object[] args)
        {
            try
            {
                return string.Format(lang.GetMessage(messageKey, this, playerId), args);
            }
            catch (Exception exception)
            {
                PrintError(exception.ToString());
                throw;
            }
        }

        #endregion
    }
}