package interfaces
{
	import service.IWebService;

	public interface IWebServiceProvider
	{
		function getWebService():IWebService;
	}
}