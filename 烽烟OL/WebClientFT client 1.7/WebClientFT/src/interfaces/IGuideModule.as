package interfaces
{
	/**
	 * 新手引导模块接口 
	 */	
	import mx.core.IVisualElement;

	public interface IGuideModule extends IContextProvider, ISocketServiceProvider, IServerConfigProvider, IPopUpShowProvider, IPopUpTaskShowProvider, IProgressBarProvider, IVisualElement
	{
		
	}
}