package wordscene.helper {
	import flash.geom.Point;

	/**
	 * @author CYPL
	 * @date 2009-11-19   
	 * 100*100 优化性能 1/5的障碍比例，平均寻路14ms
	 */
	public class FindPathPlus {
		//////////////////地图数组////////////////////
		private var _mapArray : Array;
		////////////////////宽高//////////////////////
		private var _w : uint;
		private var _h : uint;

		///////////////////开数组/////////////////////
		private var _openList : Array;
		///////////////////闭数组/////////////////////
		private var _closeList : Array;

		
		
		/////////////////记录点数组////////////////////
		private var _positionList : Array;
		////////////////最终路径数组///////////////////
		private var _finalList : Array;

		private var _tempPosition : int;

		private var _startPosition : int;
		private var _endPosition : int;

		
		
		///////////////从开数组中的取点的位置////////////
		private var _openShiftIndex : int;
		///////////////往开数组中的存点的位置////////////
		private var _openPushIndex : int;
		//
		private var _isReverse : Boolean;

		
		
		public function FindPathPlus(map : Array) : void {
			_mapArray = map;
			_w = _mapArray[0].length;

			_h = _mapArray.length;
			
		}

		//-------------------------------------------------------------
		//-------------------------------------------------------------
		public function getPath4X(startPoint : Point,endPoint : Point,isReverse : Boolean = true) : * {
			//trace("/////////////getPath4X//////////////");
			//trace(startPoint,endPoint);

			
			if (startPoint.equals(endPoint)) {
				return undefined;
			}
			if(checkIsOut(startPoint) || checkIsOut(endPoint)) {
				return undefined;
			}
			////////////////////////////////////////////
			_isReverse = isReverse;
			var tempX : uint;
			var tempY : uint;
			var a : Boolean;
			var b : Boolean;
			var c : Boolean;
			var d : Boolean;
			//////////////////////////////////////////

			_openShiftIndex = _openPushIndex = 0;
			_w = _mapArray[0].length;

			_h = _mapArray.length;
			_openList = [];
			_closeList = [];
			_positionList = [];
			_finalList = [];
			_startPosition = startPoint.y * _w + startPoint.x;
			_endPosition = endPoint.y * _w + endPoint.x;
			_openList.push(_startPosition);
			while (undefined != _openList[_openShiftIndex]) {

				_closeList[_tempPosition = _openList[_openShiftIndex++]] = 1;

				tempX = _tempPosition % _w;
				tempY = _tempPosition / _w;

				a = xTest(tempX + 1, tempY, _tempPosition, 1);

				b = xTest(tempX, tempY + 1, _tempPosition, _w);

				d = xTest(tempX, tempY - 1, _tempPosition, -_w);

				c = xTest(tempX - 1, tempY, _tempPosition, -1);


				if (_finalList.length) {
					return _finalList;
				}
			}
			//trace("遍历结束");
			return null;
		}

		//isReverse 是否将结果路径反转
		public function getPath8X(startPoint : Point,endPoint : Point,isReverse : Boolean = true) : Array {
			//trace("//////////////getPath8X///////////////");

			if (startPoint.equals(endPoint)) {
				return undefined;
			}
			if(checkIsOut(startPoint) || checkIsOut(endPoint)) {
				return undefined;
			}
			
			
			
			////////////////////////////////////////////

			
			
			
			
			_isReverse = isReverse;
			var tempX : uint;
			var tempY : uint;
			var a : Boolean;
			var b : Boolean;
			var c : Boolean;
			var d : Boolean;
			//////////////////////////////////////////

			_openShiftIndex = _openPushIndex = 0;
			_openList = [];
			_closeList = [];
			_positionList = [];
			_finalList = [];
			_startPosition = startPoint.y * _w + startPoint.x;
			_endPosition = endPoint.y * _w + endPoint.x;
			_openList.push(_startPosition);
			while (undefined != _openList[_openShiftIndex]) {

				_closeList[_tempPosition = _openList[_openShiftIndex++]] = 1;

				tempX = _tempPosition % _w;
				tempY = _tempPosition / _w;

				a = xTest(tempX + 1, tempY, _tempPosition, 1);

				b = xTest(tempX, tempY + 1, _tempPosition, _w);

				d = xTest(tempX, tempY - 1, _tempPosition, -_w);

				c = xTest(tempX - 1, tempY, _tempPosition, -1);


				a && b && xTest(tempX + 1, tempY + 1, _tempPosition, _w + 1);


				d && a && xTest(tempX + 1, tempY - 1, _tempPosition, -_w + 1);


				b && c && xTest(tempX - 1, tempY + 1, _tempPosition, _w - 1);


				c && d && xTest(tempX - 1, tempY - 1, _tempPosition, -_w - 1);

				if (_finalList.length) {
					return _finalList;
				}
			}
			//trace("遍历结束");
			return null;
		}

		/////////////////////////////////////遍历检测执行的方法//////////////////////////////////////////
		private function xTest(newX : uint,newY : uint,oldPosition : int,offsetP : int) : Boolean {
			if (newX < _w && newY < _h) {
				oldPosition += offsetP;
				if (0 == _mapArray[newY][newX]) {
					// 有障碍
					//_closeList[oldPosition] =1;
					return !(_closeList[oldPosition] = 1);
				} else {
					if (oldPosition == _endPosition) {
						//trace("////////////FindPath Success!//////////////");
						_positionList[_endPosition] = _tempPosition;
						var node : uint = _endPosition;
						_finalList.push(node);

						while (node != _startPosition) {
							node = _positionList[node];
							_finalList.push(node);
						}
						//trace(_finalList.length,"个");
						_isReverse && _finalList.reverse();
						return true;
					}
					
					if (_closeList[oldPosition]) {
						return false;
					}
					_openPushIndex++;
					_openList[_openPushIndex] = oldPosition;
					_positionList[oldPosition] = _tempPosition;
					_closeList[oldPosition] = 1;
					return true;
				}
			}
			return false;
		}

		private function checkIsOut(point : Point) : Boolean {
			switch(true) {
				case point.x < 0:
				case point.y < 0:
				case point.x > _w - 1:
				case point.y > _h - 1:
					return true;
			}
			return false;
		}
		public function clear():void {
			_mapArray = [];
			_openList = [];
			_closeList = [];
			_positionList = [];
			_finalList = [];
		}
		
		public function get w():uint 
		{
			return _w;
		}
		
	}
}