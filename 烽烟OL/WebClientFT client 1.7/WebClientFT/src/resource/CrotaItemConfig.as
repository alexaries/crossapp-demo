package resource
{
	import sceneModule.model.vo.packageVo.PackageItem;

	/**
	 * CrotaII 物品配置文件 
	 * @author DreamY
	 * 
	 */	
	public class CrotaItemConfig
	{
		private var itemXML:XML;
		private static var _instance:CrotaItemConfig;
		public function CrotaItemConfig()
		{
		}
		
		public static function getInstance():CrotaItemConfig{
			if(null == _instance){
				_instance = new CrotaItemConfig();
			}
			
			return _instance;
		}
		
		public function set _itemXML(xml:XML):void{
			itemXML = xml;
		}
		public function get _itemXML():XML{
			return itemXML;
		}
		
		public static function getItemInfoByTempleteId(tID:int):PackageItem{
			for each(var item:XML in CrotaItemConfig._instance._itemXML.row){
				if(item.id == tID){
					var itemInfo:PackageItem = new PackageItem();
					itemInfo.attackType = item.attackType;
					itemInfo.baseAttack = item.baseAttack;
					itemInfo.baseDefense = item.baseDefense;
					itemInfo.baseDex = item.baseDex;
					itemInfo.baseDurability = item.baseDurability;
					itemInfo.baseMagicAttack = item.baseMagicAttack;
					itemInfo.baseMagicDefense = item.baseMagicDefense;
					itemInfo.basePhysicalAttack = item.basePhysicalAttack;
					itemInfo.basePhysicalDefense = item.basePhysicalDefense;
					itemInfo.baseSpeed = item.baseSpeed;
					itemInfo.baseStr = item.baseStr;
					itemInfo.baseVit = item.baseVit;
					itemInfo.baseWis = item.baseWis;
					itemInfo.bindType = item.bindType;
					itemInfo.bodyType = item.bodyType;
					itemInfo.buyingRateCoin = item.buyingRateCoin;
					itemInfo.canInjection = item.canInjection;
					itemInfo.description = item.description;
					itemInfo.icon = item.icon;
					itemInfo.type = item.type;
					itemInfo.levelRequire = item.levelRequire;
					itemInfo.name = item.name;
					itemInfo.professionRequire = item.professionRequire;
					itemInfo.itemPage = item.itemPage;
					itemInfo.maxStack = item.maxstack;
					itemInfo.nowQuality = item.baseQuality;
					itemInfo.baseHpAdditional = item.baseHpAdditional;
					itemInfo.baseHitAdditional = item.baseHitAdditional;
					itemInfo.baseCritAdditional = item.baseCritAdditional;
					itemInfo.baseDodgeAdditional = item.baseDodgeAdditional;
					itemInfo.baseSpeedAdditional = item.baseSpeedAdditional;
					itemInfo.weaponType = item.weaponType;
					itemInfo.baseBlock = item.baseBlockAdditional;
					
					return itemInfo;
				}
			}
			return null;
		}
	}
}