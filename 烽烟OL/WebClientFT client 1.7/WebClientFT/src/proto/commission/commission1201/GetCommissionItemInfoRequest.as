package proto.commission.commission1201 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GetCommissionItemInfoRequest extends Message implements IExternalizable {
		public var id:int;
		public var itemType:int;
		public var curPage:int;
		private var itemName_:String;
		public function get hasItemName():Boolean {
			return null != itemName_;
		}
		public function set itemName(value:String):void {
			itemName_ = value;
		}
		public function get itemName():String {
			return itemName_;
		}
		private var minLevel_:int;
		private var hasMinLevel_:Boolean = false;
		public function get hasMinLevel():Boolean {
			return hasMinLevel_;
		}
		public function set minLevel(value:int):void {
			hasMinLevel_ = true;
			minLevel_ = value;
		}
		public function get minLevel():int {
			return minLevel_;
		}
		private var maxLevel_:int;
		private var hasMaxLevel_:Boolean = false;
		public function get hasMaxLevel():Boolean {
			return hasMaxLevel_;
		}
		public function set maxLevel(value:int):void {
			hasMaxLevel_ = true;
			maxLevel_ = value;
		}
		public function get maxLevel():int {
			return maxLevel_;
		}
		private var itemQuality_:int;
		private var hasItemQuality_:Boolean = false;
		public function get hasItemQuality():Boolean {
			return hasItemQuality_;
		}
		public function set itemQuality(value:int):void {
			hasItemQuality_ = true;
			itemQuality_ = value;
		}
		public function get itemQuality():int {
			return itemQuality_;
		}
		private var sortType_:int;
		private var hasSortType_:Boolean = false;
		public function get hasSortType():Boolean {
			return hasSortType_;
		}
		public function set sortType(value:int):void {
			hasSortType_ = true;
			sortType_ = value;
		}
		public function get sortType():int {
			return sortType_;
		}
		private var sortName_:int;
		private var hasSortName_:Boolean = false;
		public function get hasSortName():Boolean {
			return hasSortName_;
		}
		public function set sortName(value:int):void {
			hasSortName_ = true;
			sortName_ = value;
		}
		public function get sortName():int {
			return sortName_;
		}
		private var searchFlag_:Boolean;
		private var hasSearchFlag_:Boolean = false;
		public function get hasSearchFlag():Boolean {
			return hasSearchFlag_;
		}
		public function set searchFlag(value:Boolean):void {
			hasSearchFlag_ = true;
			searchFlag_ = value;
		}
		public function get searchFlag():Boolean {
			return searchFlag_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, itemType);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, curPage);
			if (hasItemName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, itemName);
			}
			if (hasMinLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, minLevel);
			}
			if (hasMaxLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, maxLevel);
			}
			if (hasItemQuality) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, itemQuality);
			}
			if (hasSortType) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, sortType);
			}
			if (hasSortName) {
				WriteUtils.writeTag(output, WireType.VARINT, 9);
				WriteUtils.write_TYPE_INT32(output, sortName);
			}
			if (hasSearchFlag) {
				WriteUtils.writeTag(output, WireType.VARINT, 10);
				WriteUtils.write_TYPE_BOOL(output, searchFlag);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var itemTypeCount:uint = 0;
			var curPageCount:uint = 0;
			var itemNameCount:uint = 0;
			var minLevelCount:uint = 0;
			var maxLevelCount:uint = 0;
			var itemQualityCount:uint = 0;
			var sortTypeCount:uint = 0;
			var sortNameCount:uint = 0;
			var searchFlagCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (idCount != 0) {
						throw new IOError('Bad data format.');
					}
					++idCount;
					id = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (itemTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemTypeCount;
					itemType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (curPageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curPageCount;
					curPage = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (itemNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemNameCount;
					itemName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (minLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++minLevelCount;
					minLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (maxLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxLevelCount;
					maxLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (itemQualityCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemQualityCount;
					itemQuality = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (sortTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sortTypeCount;
					sortType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 9:
					if (sortNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sortNameCount;
					sortName = ReadUtils.read_TYPE_INT32(input);
					break;
				case 10:
					if (searchFlagCount != 0) {
						throw new IOError('Bad data format.');
					}
					++searchFlagCount;
					searchFlag = ReadUtils.read_TYPE_BOOL(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (itemTypeCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (curPageCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
