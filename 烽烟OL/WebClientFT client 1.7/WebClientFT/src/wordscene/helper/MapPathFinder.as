package wordscene.helper 
{
	import adobe.utils.CustomActions;
	import util.Logging;
	/**
	 * ...
	 * @author hao
	 */
	public class MapPathFinder 
	{
		private static var _instance:MapPathFinder;
		public static function getInstance():MapPathFinder {
			if (null == _instance) {
				_instance = new MapPathFinder();
			}
			return _instance;
		}
		public function MapPathFinder() 
		{
			_pathes = new Vector.<TripItem>();
			_nodes = new Vector.<TripItem>();
		}
		
		private var _infoXML:XML;
		private var _nodes:Vector.<TripItem>;
		private var _pathes:Vector.<TripItem>;
		
		
		private var _end:int;
		
		public function init(xml:XML):void {
			_infoXML = xml;
			
			//test
			//find(1100, 1400);
		}
		
		public function find(start:int, end:int):Vector.<TripItem> {
			_nodes.length = 0;
			_pathes.length = 0;
			_end = end;
			if (start == end) {
				return _pathes;
			}
			checkStartPoint(start, -1);
			makePath(_pathes, _end);
			Logging.log("find map path res ", getPathStr(_pathes));
			return _pathes;
		}
		
		private function makePath(path:Vector.<TripItem>, id:int):void {
			path.length = 0;
			var node:TripItem = findNodeByNextMapid(id);
			path.unshift(node);
			while (null != node && -1 != node.fatherid) {
				node = findNodeByid(node.fatherid);
				path.unshift(node);
			}
		}
		
		private function findNodeByStartMapid(id:int):TripItem {
			var len:int = _nodes.length;
			for (var i:int = 0; i < len; i++) 
			{
				var curd:TripItem = _nodes[i];
				if (curd.curmapid == id) {
					return curd;
				}
			}
			return null;
		}
		
		private function findNodeByNextMapid(id:int):TripItem {
			var len:int = _nodes.length;
			for (var i:int = 0; i < len; i++) 
			{
				var curd:TripItem = _nodes[i];
				if (curd.nextmapid == id) {
					return curd;
				}
			}
			return null;
		}
		
		private function findNodeByid(id:int):TripItem {
			var len:int = _nodes.length;
			for (var i:int = 0; i < len; i++) 
			{
				var curd:TripItem = _nodes[i];
				if (curd.id == id) {
					return curd;
				}
			}
			return null;
		}
		
		private function findAnyNodeByid(nodes:Vector.<TripItem>, id:int):TripItem {
			var len:int = nodes.length;
			for (var i:int = 0; i < len; i++) 
			{
				var curd:TripItem = nodes[i];
				if (curd.id == id) {
					return curd;
				}
			}
			return null;
		}
		
		private function getPathStr(path:Vector.<TripItem>):String {
			var len:int = path.length;
			var s:String = "";
			for (var i:int = 0; i < len; i++) 
			{
				s += Logging.o2s(path[i]);
				s += "\n";
			}
			s += "\n\n\n\n\n\n\n\n\n";
			return s;
		}
		
		private function checkStartPoint(start:int, fatherid:int):void{
			var trips:XMLList = _infoXML.row.(functionType == 1 && mapid == start);
			var len:int = trips.length();
			var nextnodes:Vector.<TripItem> = new Vector.<TripItem>();
			for (var i:int = 0; i < len; i++) 
			{
				var tripxml:XML = trips[i];
				var tripd:TripItem = new TripItem();
				tripd.fatherid = fatherid;
				tripd.id = tripxml.id;
				
				if (findNodeByid(tripd.id)) {
					continue;
				}
				
				tripd.posx = tripxml.position_x;
				tripd.posy = tripxml.position_y;
				tripd.curmapid = tripxml.mapid;
				tripd.nextmapid = tripxml.nextmap;
				//trace("check start", start, "end", tripd.nextmapid, "id", tripd.id, "fatherid", fatherid);
				_nodes.push(tripd);
				nextnodes.push(tripd);
				if (tripd.nextmapid == _end) {
					return;
				}
			}
			
			var nextlen:int = nextnodes.length;
			for (var j:int = 0; j < nextlen; j++) 
			{
				var nextnode:TripItem = nextnodes[j];
				checkStartPoint(nextnode.nextmapid, nextnode.id);
			}
		}
	}
}