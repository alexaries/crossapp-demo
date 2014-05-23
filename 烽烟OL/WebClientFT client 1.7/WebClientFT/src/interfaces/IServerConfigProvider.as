package interfaces
{
	import model.ServerConfig;

	public interface IServerConfigProvider
	{
		function getServerConfig():ServerConfig;
	}
}