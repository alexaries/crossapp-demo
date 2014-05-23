package interfaces
{
	import mx.core.IVisualElement;
	
	import sceneModule.view.popupWin.IPopUpShow;

	/**
	 * SceneModule 模块接口 
	 * @author Yaolx
	 * 
	 */	
	public interface ISceneModule extends IContextProvider, ISocketServiceProvider, IServerConfigProvider, IPopUpShowProvider, IProgressBarProvider, IVisualElement
	{
		
	}
}