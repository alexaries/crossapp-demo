package resource
{
	import flash.utils.Dictionary;
	
	import util.AppVersion;

	/**
	 * 模块列表 
	 * @author Linus
	 * 
	 */	
	public final class ModuleList
	{
		/**
		 * 登录模块id 
		 */		
		public const LOGON_MODULE:String = "logonModule";
		
		/**
		 * 注册模块id 
		 */		
		public const REGIST_MODULE:String = "registModule";
		
		/**
		 * 创建角色模块id 
		 */		
		public const CREATE_ROLE_MODULE:String = "createRoleModule";
		/**
		 * sceneModule id 
		 */		
		public const SCENE_MODULE:String = "sceneModule";
		/**
		 * 新手引导模块
		 */
		public const GUIDE_MODULE:String = "guideModule";
		
		/**
		 * 模块列表 
		 */		
		private var _list:Array = [
			{id:LOGON_MODULE, url:"logonModule/LogonModule"+AppVersion.appVersionStr+".swf"},
			{id:REGIST_MODULE, url:"registModule/RegistModule"+AppVersion.appVersionStr+".swf"},
			{id:CREATE_ROLE_MODULE, url:"createRoleModule/CreateRoleModule"+AppVersion.appVersionStr+".swf"},
			{id:SCENE_MODULE, url:"sceneModule/SceneModule"+AppVersion.appVersionStr+".swf"},
			{id:GUIDE_MODULE,url:"guideModule/GuideModule"+AppVersion.appVersionStr+".swf"}
		];
		
		/**
		 * 模块映射
		 */		
		private var _dic:Dictionary;
		
		
		/**
		 * constructor 
		 * 
		 */		
		public function ModuleList()
		{
			_dic = new Dictionary;
			for each(var obj:Object in _list)
			{
				_dic[obj.id] = obj.url;
			}
		}
		
		/**
		 * 获得模块地址 
		 * @param id
		 * @return 模块url
		 * 
		 */		
		public function getModuleUrl(id:String):String
		{
			return _dic[id];
		}
	}
}