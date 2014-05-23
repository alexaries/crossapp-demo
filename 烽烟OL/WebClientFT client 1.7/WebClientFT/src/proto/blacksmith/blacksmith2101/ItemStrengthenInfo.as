package proto.blacksmith.blacksmith2101 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.ItemsInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ItemStrengthenInfo extends Message implements IExternalizable {
		private var strengthenSuccRate_:int;
		private var hasStrengthenSuccRate_:Boolean = false;
		public function get hasStrengthenSuccRate():Boolean {
			return hasStrengthenSuccRate_;
		}
		public function set strengthenSuccRate(value:int):void {
			hasStrengthenSuccRate_ = true;
			strengthenSuccRate_ = value;
		}
		public function get strengthenSuccRate():int {
			return strengthenSuccRate_;
		}
		private var itemsInfo_:proto.ItemsInfo;
		public function get hasItemsInfo():Boolean {
			return null != itemsInfo_;
		}
		public function set itemsInfo(value:proto.ItemsInfo):void {
			itemsInfo_ = value;
		}
		public function get itemsInfo():proto.ItemsInfo {
			return itemsInfo_;
		}
		private var itemType_:int;
		private var hasItemType_:Boolean = false;
		public function get hasItemType():Boolean {
			return hasItemType_;
		}
		public function set itemType(value:int):void {
			hasItemType_ = true;
			itemType_ = value;
		}
		public function get itemType():int {
			return itemType_;
		}
		private var strLevel_:int;
		private var hasStrLevel_:Boolean = false;
		public function get hasStrLevel():Boolean {
			return hasStrLevel_;
		}
		public function set strLevel(value:int):void {
			hasStrLevel_ = true;
			strLevel_ = value;
		}
		public function get strLevel():int {
			return strLevel_;
		}
		private var param1Name_:String;
		public function get hasParam1Name():Boolean {
			return null != param1Name_;
		}
		public function set param1Name(value:String):void {
			param1Name_ = value;
		}
		public function get param1Name():String {
			return param1Name_;
		}
		private var param1_:int;
		private var hasParam1_:Boolean = false;
		public function get hasParam1():Boolean {
			return hasParam1_;
		}
		public function set param1(value:int):void {
			hasParam1_ = true;
			param1_ = value;
		}
		public function get param1():int {
			return param1_;
		}
		private var param2Name_:String;
		public function get hasParam2Name():Boolean {
			return null != param2Name_;
		}
		public function set param2Name(value:String):void {
			param2Name_ = value;
		}
		public function get param2Name():String {
			return param2Name_;
		}
		private var param2_:int;
		private var hasParam2_:Boolean = false;
		public function get hasParam2():Boolean {
			return hasParam2_;
		}
		public function set param2(value:int):void {
			hasParam2_ = true;
			param2_ = value;
		}
		public function get param2():int {
			return param2_;
		}
		private var requiredCoin_:String;
		public function get hasRequiredCoin():Boolean {
			return null != requiredCoin_;
		}
		public function set requiredCoin(value:String):void {
			requiredCoin_ = value;
		}
		public function get requiredCoin():String {
			return requiredCoin_;
		}
		private var failDes_:String;
		public function get hasFailDes():Boolean {
			return null != failDes_;
		}
		public function set failDes(value:String):void {
			failDes_ = value;
		}
		public function get failDes():String {
			return failDes_;
		}
		private var inPackType_:int;
		private var hasInPackType_:Boolean = false;
		public function get hasInPackType():Boolean {
			return hasInPackType_;
		}
		public function set inPackType(value:int):void {
			hasInPackType_ = true;
			inPackType_ = value;
		}
		public function get inPackType():int {
			return inPackType_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasStrengthenSuccRate) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, strengthenSuccRate);
			}
			if (hasItemsInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_MESSAGE(output, itemsInfo);
			}
			if (hasItemType) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, itemType);
			}
			if (hasStrLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, strLevel);
			}
			if (hasParam1Name) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_STRING(output, param1Name);
			}
			if (hasParam1) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, param1);
			}
			if (hasParam2Name) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
				WriteUtils.write_TYPE_STRING(output, param2Name);
			}
			if (hasParam2) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, param2);
			}
			if (hasRequiredCoin) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 9);
				WriteUtils.write_TYPE_STRING(output, requiredCoin);
			}
			if (hasFailDes) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 10);
				WriteUtils.write_TYPE_STRING(output, failDes);
			}
			if (hasInPackType) {
				WriteUtils.writeTag(output, WireType.VARINT, 11);
				WriteUtils.write_TYPE_INT32(output, inPackType);
			}
		}
		public function readExternal(input:IDataInput):void {
			var strengthenSuccRateCount:uint = 0;
			var itemsInfoCount:uint = 0;
			var itemTypeCount:uint = 0;
			var strLevelCount:uint = 0;
			var param1NameCount:uint = 0;
			var param1Count:uint = 0;
			var param2NameCount:uint = 0;
			var param2Count:uint = 0;
			var requiredCoinCount:uint = 0;
			var failDesCount:uint = 0;
			var inPackTypeCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (strengthenSuccRateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++strengthenSuccRateCount;
					strengthenSuccRate = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (itemsInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemsInfoCount;
					itemsInfo = new proto.ItemsInfo;
					ReadUtils.read_TYPE_MESSAGE(input, itemsInfo);
					break;
				case 3:
					if (itemTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemTypeCount;
					itemType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (strLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++strLevelCount;
					strLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (param1NameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++param1NameCount;
					param1Name = ReadUtils.read_TYPE_STRING(input);
					break;
				case 6:
					if (param1Count != 0) {
						throw new IOError('Bad data format.');
					}
					++param1Count;
					param1 = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (param2NameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++param2NameCount;
					param2Name = ReadUtils.read_TYPE_STRING(input);
					break;
				case 8:
					if (param2Count != 0) {
						throw new IOError('Bad data format.');
					}
					++param2Count;
					param2 = ReadUtils.read_TYPE_INT32(input);
					break;
				case 9:
					if (requiredCoinCount != 0) {
						throw new IOError('Bad data format.');
					}
					++requiredCoinCount;
					requiredCoin = ReadUtils.read_TYPE_STRING(input);
					break;
				case 10:
					if (failDesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++failDesCount;
					failDes = ReadUtils.read_TYPE_STRING(input);
					break;
				case 11:
					if (inPackTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++inPackTypeCount;
					inPackType = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
