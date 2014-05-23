package resource
{
	/**
	 * list the resource path 
	 * @author Linus
	 * 
	 */	
	public final class ResourceList
	{
		/**
		 * 应用级预加载资源列表 
		 */		
		public var preloadCommonResource:Array = [
			// list preload common resource
			// {id:"name", url:"path/file.ext"}
			{id:"server_config",url:"config/ServerConfig.xml"},
			{id:"guide_config", url:"config/guide.xml" },
			{id:"map_config", url:"config/map_info.xml" },
			{id:"fb_config", url:"config/fuben_info.xml" },
			{id:"zhanyi_config", url:"config/zhanyi.xml" },
			{id:"asset_config", url:"config/asset.xml"},
			{id:"rewardDes_config", url:"config/RewardDes.xml"},
			{id:"territory_config", url:"config/TerritoryConfig.xml"},
			{id:"levupEff_config", url:"config/LevelUpEffectConfig.xml"},
			{id:"res_config", url:"res/res.xml"},
			{id:"entitys_config", url:"config/entity.xml" },
			{id:"trip_config", url:"config/door.xml"},
		];
		
		/**
		 * constructor 
		 * 
		 */		
		public function ResourceList()
		{
		}
	}
}