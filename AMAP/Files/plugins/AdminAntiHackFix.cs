namespace Oxide.Plugins
{
    [Info("Admin AntiHack Fix", "Solarix", "1.0.0"), Description("Fix for admin staff getting kicked for AntiHack violation(s).")]
    public class AdminAntiHackFix : RustPlugin
    {
        private object OnPlayerViolation(BasePlayer player, AntiHackType type, float amount)
        {
            if ((type == AntiHackType.FlyHack || type == AntiHackType.InsideTerrain) && (player.IsAdmin || player.IsDeveloper)) return false;
            return null;
        }
    }
}