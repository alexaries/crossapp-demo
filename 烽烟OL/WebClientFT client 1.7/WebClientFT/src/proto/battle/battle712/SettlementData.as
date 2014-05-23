package proto.battle.battle712 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.ItemsInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class SettlementData extends Message implements IExternalizable {
		[ArrayElementType("proto.ItemsInfo")]
		public var itemsBonus:Array = [];
		private var sceneName_:String;
		public function get hasSceneName():Boolean {
			return null != sceneName_;
		}
		public function set sceneName(value:String):void {
			sceneName_ = value;
		}
		public function get sceneName():String {
			return sceneName_;
		}
		private var sucNum_:int;
		private var hasSucNum_:Boolean = false;
		public function get hasSucNum():Boolean {
			return hasSucNum_;
		}
		public function set sucNum(value:int):void {
			hasSucNum_ = true;
			sucNum_ = value;
		}
		public function get sucNum():int {
			return sucNum_;
		}
		private var goldNum_:int;
		private var hasGoldNum_:Boolean = false;
		public function get hasGoldNum():Boolean {
			return hasGoldNum_;
		}
		public function set goldNum(value:int):void {
			hasGoldNum_ = true;
			goldNum_ = value;
		}
		public function get goldNum():int {
			return goldNum_;
		}
		public function writeExternal(output:IDataOutput):void {
			for (var itemsBonusIndex:uint = 0; itemsBonusIndex < itemsBonus.length; ++itemsBonusIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, itemsBonus[itemsBonusIndex]);
			}
			if (hasSceneName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, sceneName);
			}
			if (hasSucNum) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, sucNum);
			}
			if (hasGoldNum) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, goldNum);
			}
		}
		public function readExternal(input:IDataInput):void {
			var sceneNameCount:uint = 0;
			var sucNumCount:uint = 0;
			var goldNumCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					itemsBonus.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.ItemsInfo));
					break;
				case 2:
					if (sceneNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sceneNameCount;
					sceneName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (sucNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sucNumCount;
					sucNum = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (goldNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++goldNumCount;
					goldNum = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
