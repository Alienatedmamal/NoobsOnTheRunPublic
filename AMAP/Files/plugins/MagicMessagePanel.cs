using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using Oxide.Core.Configuration;
using Oxide.Core.Libraries.Covalence;
using Oxide.Core.Plugins;
using UnityEngine;
using Random = UnityEngine.Random;

namespace Oxide.Plugins
{
    [Info("Magic Message Panel", "MJSU", "1.2.1")]
    [Description("Displays messages in magic panel")]
    public class MagicMessagePanel : RustPlugin
    {
        #region Class Fields
        [PluginReference] private readonly Plugin MagicPanel, PlaceholderAPI;

        private DynamicConfigFile _newConfig;
        private PluginConfig _pluginConfig; //Plugin Config

        private enum UpdateEnum { All = 1, Panel = 2, Image = 3, Text = 4 }
        private enum State {In, NotIn}
        
        private readonly Hash<ulong, int> _playerIndex = new Hash<ulong, int>();
        private readonly Hash<ulong, string> _playerLastMessage = new Hash<ulong, string>();
        
        private Action<IPlayer, StringBuilder, bool> _replacer;
        #endregion

        #region Setup & Loading
        protected override void LoadDefaultConfig()
        {
            PrintWarning("Loading Default Config");
        }

        protected override void LoadConfig()
        {
            string path = $"{Manager.ConfigPath}/MagicPanel/{Name}.json";
            _newConfig = new DynamicConfigFile(path);
            if (!_newConfig.Exists())
            {
                LoadDefaultConfig();
                _newConfig.Save();
            }
            try
            {
                _newConfig.Load();
            }
            catch (Exception ex)
            {
                RaiseError("Failed to load config file (is the config file corrupt?) (" + ex.Message + ")");
                return;
            }
            
            _newConfig.Settings.DefaultValueHandling = DefaultValueHandling.Populate;
            _pluginConfig = AdditionalConfig(_newConfig.ReadObject<PluginConfig>());
            _newConfig.WriteObject(_pluginConfig);
        }

        private PluginConfig AdditionalConfig(PluginConfig config)
        {
            config.Panels = config.Panels ?? new Hash<string, PanelData>
            {
                [$"{Name}_1"] = new PanelData
                {
                    Panel = new Panel
                    {
                        Text = new PanelText
                        {
                            Enabled = true,
                            Color = "#FFFFFFFF",
                            Order = 1,
                            Width = 1f,
                            FontSize = 14,
                            Padding = new TypePadding(0.05f, 0.05f, 0.1f, 0.00f),
                            TextAnchor = TextAnchor.MiddleCenter,
                            Text = ""
                        }
                    },
                    PermMessages = new List<MessageGroupData>
                    {
                        new MessageGroupData
                        {
                            Enabled = true,
                            GroupOrPerm = "default",
                            State = State.In,
                            Messages = new List<string>
                            {
                               "You must be in the default group to see this message"
                            }
                        },
                        new MessageGroupData
                        {
                            Enabled = true,
                            GroupOrPerm = "VIP",
                            State = State.NotIn,
                            Messages = new List<string>
                            {
                                "Messages here for players not in VIP group or perm"
                            }
                        }
                    },
                    PanelSettings = new PanelRegistration
                    {
                        BackgroundColor = "#FFF2DF08",
                        Dock = "bottom",
                        Order = 0,
                        Width = 0.2954f
                    },
                    UpdateRate = 15f,
                    Enabled = true
                }
            };
            
            return config;
        }

        private void OnServerInitialized()
        {
            //*****BEGIN TEMPORARY REMOVE AFTER 02/03/2021
            bool changed = false;
            foreach (PanelData panel in _pluginConfig.Panels.Values)
            {
                if (panel.ShouldSerializeMessages())
                {
                    panel.PermMessages = new List<MessageGroupData>
                    {
                        new MessageGroupData
                        {
                            Messages =  panel.Messages,
                            Enabled = true,
                            GroupOrPerm = "default",
                            State = State.In
                        }
                    };

                    changed = true;
                }
            }
            
            if (changed)
            {
                _newConfig.WriteObject(_pluginConfig);
            }
            //*****END TEMPORARY REMOVE AFTER 02/03/2021
            
            MagicPanelRegisterPanels();
            
            foreach (IGrouping<float, KeyValuePair<string, PanelData>> panelUpdates in _pluginConfig.Panels.Where(p => p.Value.Enabled).GroupBy(p => p.Value.UpdateRate))
            {
                timer.Every(panelUpdates.Key, () =>
                {
                    foreach (KeyValuePair<string, PanelData> data in panelUpdates)
                    {
                        MagicPanel?.Call("UpdatePanel", data.Key, (int)UpdateEnum.Text);
                    }
                });
            }
        }

        private void MagicPanelRegisterPanels()
        {
            if (MagicPanel == null)
            {
                PrintError("Missing plugin dependency MagicPanel: https://umod.org/plugins/magic-panel");
                return;
            }
        
            foreach (KeyValuePair<string, PanelData> panel in _pluginConfig.Panels)
            {
                if (!panel.Value.Enabled)
                {
                    continue;
                }
                
                MagicPanel?.Call("RegisterPlayerPanel", this, panel.Key, JsonConvert.SerializeObject(panel.Value.PanelSettings), nameof(GetPanel));
            }
        }
        #endregion

        #region MagicPanel Hook
        private List<string> GetPlayerMessages(BasePlayer player, string panelName)
        {
            PanelData panel = _pluginConfig.Panels[panelName];
            List<string> messages = new List<string>();

            foreach (MessageGroupData data in panel.PermMessages)
            {
                if (data.State == State.In ? InPermOrGroup(player, data.GroupOrPerm) : !InPermOrGroup(player, data.GroupOrPerm))
                {
                    messages.AddRange(data.Messages);
                }
            }

            return messages;
        }

        private bool InPermOrGroup(BasePlayer player, string permGroup)
        {
            return permission.UserHasPermission(player.UserIDString, permGroup) || permission.UserHasGroup(player.UserIDString, permGroup);
        }
        
        private Hash<string, object> GetPanel(BasePlayer player, string panelName)
        {
            PanelData panelData = _pluginConfig.Panels[panelName];
            Panel panel = panelData.Panel;
            PanelText text = panel.Text;
            if (text != null)
            {
                List<string> playerMessages = GetPlayerMessages(player, panelName);
                if (playerMessages.Count == 0)
                {
                    text.Text = string.Empty;
                }
                else if (playerMessages.Count == 1)
                {
                    text.Text = playerMessages[0];
                }
                else if (panelData.RandomOrder)
                {
                    string previous = _playerLastMessage[player.userID];
                    text.Text = playerMessages.Where(m => previous != m)
                        .Skip(Random.Range(0, playerMessages.Count - 1))
                        .FirstOrDefault();
                    _playerLastMessage[player.userID] = text.Text;
                }
                else
                {
                    int index = _playerIndex[player.userID];
                    index = (index + 1) % playerMessages.Count;
                    text.Text = playerMessages[index];
                    _playerIndex[player.userID] = index;
                }

                text.Text = ParseText(text.Text);
            }

            return panel.ToHash();
        }
        #endregion
        
        #region PlaceholderAPI
        private string ParseText(string text)
        {
            Action<IPlayer, StringBuilder, bool> replacer = GetReplacer();
            if (replacer == null)
            {
                return text;
            }
            
            StringBuilder sb = new StringBuilder(text);

            replacer.Invoke(null, sb, false);

            return sb.ToString();
        }
        
        private void OnPluginUnloaded(Plugin plugin)
        {
            if (plugin?.Name == "PlaceholderAPI")
            {
                _replacer = null;
            }
        }

        private Action<IPlayer, StringBuilder, bool> GetReplacer()
        {
            if (!IsPlaceholderApiLoaded())
            {
                return _replacer;
            }
            
            return _replacer ?? (_replacer = PlaceholderAPI.Call<Action<IPlayer, StringBuilder, bool>>("GetProcessPlaceholders", 1));
        }

        private bool IsPlaceholderApiLoaded() => PlaceholderAPI != null && PlaceholderAPI.IsLoaded;
        #endregion

        #region Classes
        private class PluginConfig
        {
            [JsonProperty(PropertyName = "Message Panels")]
            public Hash<string, PanelData> Panels { get; set; }
        }

        private class PanelData
        {
            [JsonProperty(PropertyName = "Panel Settings")]
            public PanelRegistration PanelSettings { get; set; }
            
            [JsonProperty(PropertyName = "Panel Layout")]
            public Panel Panel { get; set; }
            
            [JsonProperty(PropertyName = "Messages to all players")]
            public List<string> Messages { get; set; }

            [JsonProperty(PropertyName = "Perm or Group messages")]
            public List<MessageGroupData> PermMessages = new List<MessageGroupData>();

            [JsonProperty(PropertyName = "Random Message Display Order")]
            public bool RandomOrder { get; set; }
            
            [JsonProperty(PropertyName = "Update Rate (Seconds)")]
            public float UpdateRate { get; set; }
            
            [DefaultValue(true)]
            [JsonProperty(PropertyName = "Enabled")]
            public bool Enabled { get; set; }
            
            public bool ShouldSerializeMessages()
            {
                return Messages != null && Messages.Count > 0;
            }
        }

        private class MessageGroupData
        {
            [JsonProperty(PropertyName = "Messages")]
            public List<string> Messages { get; set; }
            
            [JsonProperty(PropertyName = "Group or Permission")]
            public string GroupOrPerm { get; set; }
            
            [JsonConverter(typeof(StringEnumConverter))]
            [JsonProperty(PropertyName = "Player Group or Permission State (In, NotIn)")]
            public State State { get; set; }
            
            [JsonProperty(PropertyName = "Enabled")]
            public bool Enabled { get; set; }
        }

        private class PanelRegistration
        {
            public string Dock { get; set; }
            public float Width { get; set; }
            public int Order { get; set; }
            public string BackgroundColor { get; set; }
        }

        private class Panel
        {
            public PanelText Text { get; set; }
            
            public Hash<string, object> ToHash()
            {
                return new Hash<string, object>
                {
                    [nameof(Text)] = Text.ToHash()
                };
            }
        }

        private abstract class PanelType
        {
            public bool Enabled { get; set; }
            public string Color { get; set; }
            public int Order { get; set; }
            public float Width { get; set; }
            public TypePadding Padding { get; set; }
            
            public virtual Hash<string, object> ToHash()
            {
                return new Hash<string, object>
                {
                    [nameof(Enabled)] = Enabled,
                    [nameof(Color)] = Color,
                    [nameof(Order)] = Order,
                    [nameof(Width)] = Width,
                    [nameof(Padding)] = Padding.ToHash(),
                };
            }
        }

        private class PanelText : PanelType
        {
            public string Text { get; set; }
            public int FontSize { get; set; }

            [JsonConverter(typeof(StringEnumConverter))]
            public TextAnchor TextAnchor { get; set; }
            
            public override Hash<string, object> ToHash()
            {
                Hash<string, object> hash = base.ToHash();
                hash[nameof(Text)] = Text;
                hash[nameof(FontSize)] = FontSize;
                hash[nameof(TextAnchor)] = TextAnchor;
                return hash;
            }
        }

        private class TypePadding
        {
            public float Left { get; set; }
            public float Right { get; set; }
            public float Top { get; set; }
            public float Bottom { get; set; }

            public TypePadding(float left, float right, float top, float bottom)
            {
                Left = left;
                Right = right;
                Top = top;
                Bottom = bottom;
            }
            
            public Hash<string, object> ToHash()
            {
                return new Hash<string, object>
                {
                    [nameof(Left)] = Left,
                    [nameof(Right)] = Right,
                    [nameof(Top)] = Top,
                    [nameof(Bottom)] = Bottom
                };
            }
        }
        #endregion
    }
}
