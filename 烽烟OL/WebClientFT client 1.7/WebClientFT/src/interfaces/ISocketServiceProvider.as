package interfaces
{
	import service.ISocketServer;

	public interface ISocketServiceProvider
	{
		function getSocketService():ISocketServer;
	}
}