package proto.corps.corps1310 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.corps.corps1310.ManagermentInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class EmblemInfo extends Message implements IExternalizable {
		private var corpsFounder_:String;
		public function get hasCorpsFounder():Boolean {
			return null != corpsFounder_;
		}
		public function set corpsFounder(value:String):void {
			corpsFounder_ = value;
		}
		public function get corpsFounder():String {
			return corpsFounder_;
		}
		private var corpsId_:int;
		private var hasCorpsId_:Boolean = false;
		public function get hasCorpsId():Boolean {
			return hasCorpsId_;
		}
		public function set corpsId(value:int):void {
			hasCorpsId_ = true;
			corpsId_ = value;
		}
		public function get corpsId():int {
			return corpsId_;
		}
		private var corpsImg_:int;
		private var hasCorpsImg_:Boolean = false;
		public function get hasCorpsImg():Boolean {
			return hasCorpsImg_;
		}
		public function set corpsImg(value:int):void {
			hasCorpsImg_ = true;
			corpsImg_ = value;
		}
		public function get corpsImg():int {
			return corpsImg_;
		}
		private var createData_:String;
		public function get hasCreateData():Boolean {
			return null != createData_;
		}
		public function set createData(value:String):void {
			createData_ = value;
		}
		public function get createData():String {
			return createData_;
		}
		private var corpsLevel_:int;
		private var hasCorpsLevel_:Boolean = false;
		public function get hasCorpsLevel():Boolean {
			return hasCorpsLevel_;
		}
		public function set corpsLevel(value:int):void {
			hasCorpsLevel_ = true;
			corpsLevel_ = value;
		}
		public function get corpsLevel():int {
			return corpsLevel_;
		}
		private var emblemLevel_:int;
		private var hasEmblemLevel_:Boolean = false;
		public function get hasEmblemLevel():Boolean {
			return hasEmblemLevel_;
		}
		public function set emblemLevel(value:int):void {
			hasEmblemLevel_ = true;
			emblemLevel_ = value;
		}
		public function get emblemLevel():int {
			return emblemLevel_;
		}
		private var corpsChief_:String;
		public function get hasCorpsChief():Boolean {
			return null != corpsChief_;
		}
		public function set corpsChief(value:String):void {
			corpsChief_ = value;
		}
		public function get corpsChief():String {
			return corpsChief_;
		}
		private var curProgress_:int;
		private var hasCurProgress_:Boolean = false;
		public function get hasCurProgress():Boolean {
			return hasCurProgress_;
		}
		public function set curProgress(value:int):void {
			hasCurProgress_ = true;
			curProgress_ = value;
		}
		public function get curProgress():int {
			return curProgress_;
		}
		private var maxPorgress_:int;
		private var hasMaxPorgress_:Boolean = false;
		public function get hasMaxPorgress():Boolean {
			return hasMaxPorgress_;
		}
		public function set maxPorgress(value:int):void {
			hasMaxPorgress_ = true;
			maxPorgress_ = value;
		}
		public function get maxPorgress():int {
			return maxPorgress_;
		}
		[ArrayElementType("proto.corps.corps1310.ManagermentInfo")]
		public var veteranList:Array = [];
		[ArrayElementType("proto.corps.corps1310.ManagermentInfo")]
		public var staffInfo:Array = [];
		[ArrayElementType("proto.corps.corps1310.ManagermentInfo")]
		public var orderInfo:Array = [];
		private var bugleTxt_:String;
		public function get hasBugleTxt():Boolean {
			return null != bugleTxt_;
		}
		public function set bugleTxt(value:String):void {
			bugleTxt_ = value;
		}
		public function get bugleTxt():String {
			return bugleTxt_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasCorpsFounder) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, corpsFounder);
			}
			if (hasCorpsId) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, corpsId);
			}
			if (hasCorpsImg) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, corpsImg);
			}
			if (hasCreateData) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, createData);
			}
			if (hasCorpsLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, corpsLevel);
			}
			if (hasEmblemLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, emblemLevel);
			}
			if (hasCorpsChief) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
				WriteUtils.write_TYPE_STRING(output, corpsChief);
			}
			if (hasCurProgress) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, curProgress);
			}
			if (hasMaxPorgress) {
				WriteUtils.writeTag(output, WireType.VARINT, 9);
				WriteUtils.write_TYPE_INT32(output, maxPorgress);
			}
			for (var veteranListIndex:uint = 0; veteranListIndex < veteranList.length; ++veteranListIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 10);
				WriteUtils.write_TYPE_MESSAGE(output, veteranList[veteranListIndex]);
			}
			for (var staffInfoIndex:uint = 0; staffInfoIndex < staffInfo.length; ++staffInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 11);
				WriteUtils.write_TYPE_MESSAGE(output, staffInfo[staffInfoIndex]);
			}
			for (var orderInfoIndex:uint = 0; orderInfoIndex < orderInfo.length; ++orderInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 12);
				WriteUtils.write_TYPE_MESSAGE(output, orderInfo[orderInfoIndex]);
			}
			if (hasBugleTxt) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 13);
				WriteUtils.write_TYPE_STRING(output, bugleTxt);
			}
		}
		public function readExternal(input:IDataInput):void {
			var corpsFounderCount:uint = 0;
			var corpsIdCount:uint = 0;
			var corpsImgCount:uint = 0;
			var createDataCount:uint = 0;
			var corpsLevelCount:uint = 0;
			var emblemLevelCount:uint = 0;
			var corpsChiefCount:uint = 0;
			var curProgressCount:uint = 0;
			var maxPorgressCount:uint = 0;
			var bugleTxtCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (corpsFounderCount != 0) {
						throw new IOError('Bad data format.');
					}
					++corpsFounderCount;
					corpsFounder = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (corpsIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++corpsIdCount;
					corpsId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (corpsImgCount != 0) {
						throw new IOError('Bad data format.');
					}
					++corpsImgCount;
					corpsImg = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (createDataCount != 0) {
						throw new IOError('Bad data format.');
					}
					++createDataCount;
					createData = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (corpsLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++corpsLevelCount;
					corpsLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (emblemLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++emblemLevelCount;
					emblemLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (corpsChiefCount != 0) {
						throw new IOError('Bad data format.');
					}
					++corpsChiefCount;
					corpsChief = ReadUtils.read_TYPE_STRING(input);
					break;
				case 8:
					if (curProgressCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curProgressCount;
					curProgress = ReadUtils.read_TYPE_INT32(input);
					break;
				case 9:
					if (maxPorgressCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxPorgressCount;
					maxPorgress = ReadUtils.read_TYPE_INT32(input);
					break;
				case 10:
					veteranList.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.corps.corps1310.ManagermentInfo));
					break;
				case 11:
					staffInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.corps.corps1310.ManagermentInfo));
					break;
				case 12:
					orderInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.corps.corps1310.ManagermentInfo));
					break;
				case 13:
					if (bugleTxtCount != 0) {
						throw new IOError('Bad data format.');
					}
					++bugleTxtCount;
					bugleTxt = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
