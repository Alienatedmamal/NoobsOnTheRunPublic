namespace Oxide.Plugins
{
    [Info("ServerPop", "Mabel", "1.0.0"), Description("Show server pop in chat with /pop command.")]
	class ServerPop : CovalencePlugin
	{
		[Command("pop")]
        void OnPlayerCommand(BasePlayer player, string command, string[] args)
        {
            if (command == "pop")
            {
                player.ChatMessage("There is currently\n " + BasePlayer.activePlayerList.Count + "<color=green> player(s) online</color>\n " + BasePlayer.sleepingPlayerList.Count + "<color=yellow> player(s) sleeping</color>\n " + ServerMgr.Instance.connectionQueue.Joining + " <color=orange>player(s) joining</color>\n " + ServerMgr.Instance.connectionQueue.Queued + " <color=red>player(s) queued</color> ");
			}
			return;
        }
    }
}	
	
