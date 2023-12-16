using System.Linq;

namespace Oxide.Plugins
{
    [Info("Bodies to Bags", "Ryan", "2.0.0")]
    [Description("Modifies the time it takes for bodies to become bags")]
    public class BodiesToBags : RustPlugin
    {
        #region Configuration

        private bool ConfigChanged = false;
        private int _despawnTime;

        protected override void LoadDefaultConfig() => PrintWarning("Generating default configuration file...");

        private void InitConfig()
        {
            _despawnTime = GetConfig(5, "Settings", "Despawn time of bodies (seconds)");

            if (ConfigChanged)
            {
                PrintWarning("Updated configuration file with new/changed values.");
                SaveConfig();
            }
        }

        private T GetConfig<T>(T defaultVal, params string[] path)
        {
            var data = Config.Get(path);
            if (data != null)
            {
                return Config.ConvertValue<T>(data);
            }

            Config.Set(path.Concat(new object[] { defaultVal }).ToArray());
            ConfigChanged = true;
            return defaultVal;
        }

        #endregion

        private void Init()
        {
            InitConfig();
        }

        // Use the OnEntitySpawned hook with relevant overload vs OnPlayerCorpseSpawned as it doesn't work for Scientist NPCs
        private void OnEntitySpawned(LootableCorpse corpse)
        {
            corpse.ResetRemovalTime(_despawnTime);
        }

        private void OnLootEntityEnd(BasePlayer player, PlayerCorpse corpse)
        {
            // Next tick is required here due to the ordering of this hook call in "LootableCorpse"
            // It resets the removal time of the corpse based on the "corpsedespawn" convar, which impacts the animal corpse despawns as collateral
            NextTick(() =>
            {
                corpse.ResetRemovalTime(_despawnTime);
            });
        }
    }
}
