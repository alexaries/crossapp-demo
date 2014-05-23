package proto.task.task1409 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.task.task1409.ItemsInfo;
	import proto.task.task1409.ProcessInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class QuestInfo extends Message implements IExternalizable {
		private var id_:int;
		private var hasId_:Boolean = false;
		public function get hasId():Boolean {
			return hasId_;
		}
		public function set id(value:int):void {
			hasId_ = true;
			id_ = value;
		}
		public function get id():int {
			return id_;
		}
		private var name_:String;
		public function get hasName():Boolean {
			return null != name_;
		}
		public function set name(value:String):void {
			name_ = value;
		}
		public function get name():String {
			return name_;
		}
		private var description_:String;
		public function get hasDescription():Boolean {
			return null != description_;
		}
		public function set description(value:String):void {
			description_ = value;
		}
		public function get description():String {
			return description_;
		}
		[ArrayElementType("proto.task.task1409.ProcessInfo")]
		public var processinfolist:Array = [];
		private var ExpBound_:int;
		private var hasExpBound_:Boolean = false;
		public function get hasExpBound():Boolean {
			return hasExpBound_;
		}
		public function set ExpBound(value:int):void {
			hasExpBound_ = true;
			ExpBound_ = value;
		}
		public function get ExpBound():int {
			return ExpBound_;
		}
		private var coinBound_:int;
		private var hasCoinBound_:Boolean = false;
		public function get hasCoinBound():Boolean {
			return hasCoinBound_;
		}
		public function set coinBound(value:int):void {
			hasCoinBound_ = true;
			coinBound_ = value;
		}
		public function get coinBound():int {
			return coinBound_;
		}
		private var couponBound_:int;
		private var hasCouponBound_:Boolean = false;
		public function get hasCouponBound():Boolean {
			return hasCouponBound_;
		}
		public function set couponBound(value:int):void {
			hasCouponBound_ = true;
			couponBound_ = value;
		}
		public function get couponBound():int {
			return couponBound_;
		}
		[ArrayElementType("proto.task.task1409.ItemsInfo")]
		public var requiredItemBound:Array = [];
		[ArrayElementType("proto.task.task1409.ItemsInfo")]
		public var optionalItemBound:Array = [];
		private var gloryBound_:int;
		private var hasGloryBound_:Boolean = false;
		public function get hasGloryBound():Boolean {
			return hasGloryBound_;
		}
		public function set gloryBound(value:int):void {
			hasGloryBound_ = true;
			gloryBound_ = value;
		}
		public function get gloryBound():int {
			return gloryBound_;
		}
		private var providerID_:int;
		private var hasProviderID_:Boolean = false;
		public function get hasProviderID():Boolean {
			return hasProviderID_;
		}
		public function set providerID(value:int):void {
			hasProviderID_ = true;
			providerID_ = value;
		}
		public function get providerID():int {
			return providerID_;
		}
		private var reporterID_:int;
		private var hasReporterID_:Boolean = false;
		public function get hasReporterID():Boolean {
			return hasReporterID_;
		}
		public function set reporterID(value:int):void {
			hasReporterID_ = true;
			reporterID_ = value;
		}
		public function get reporterID():int {
			return reporterID_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, id);
			}
			if (hasName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, name);
			}
			if (hasDescription) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, description);
			}
			for (var processinfolistIndex:uint = 0; processinfolistIndex < processinfolist.length; ++processinfolistIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_MESSAGE(output, processinfolist[processinfolistIndex]);
			}
			if (hasExpBound) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, ExpBound);
			}
			if (hasCoinBound) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, coinBound);
			}
			if (hasCouponBound) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, couponBound);
			}
			for (var requiredItemBoundIndex:uint = 0; requiredItemBoundIndex < requiredItemBound.length; ++requiredItemBoundIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 8);
				WriteUtils.write_TYPE_MESSAGE(output, requiredItemBound[requiredItemBoundIndex]);
			}
			for (var optionalItemBoundIndex:uint = 0; optionalItemBoundIndex < optionalItemBound.length; ++optionalItemBoundIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 9);
				WriteUtils.write_TYPE_MESSAGE(output, optionalItemBound[optionalItemBoundIndex]);
			}
			if (hasGloryBound) {
				WriteUtils.writeTag(output, WireType.VARINT, 10);
				WriteUtils.write_TYPE_INT32(output, gloryBound);
			}
			if (hasProviderID) {
				WriteUtils.writeTag(output, WireType.VARINT, 11);
				WriteUtils.write_TYPE_INT32(output, providerID);
			}
			if (hasReporterID) {
				WriteUtils.writeTag(output, WireType.VARINT, 12);
				WriteUtils.write_TYPE_INT32(output, reporterID);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var nameCount:uint = 0;
			var descriptionCount:uint = 0;
			var ExpBoundCount:uint = 0;
			var coinBoundCount:uint = 0;
			var couponBoundCount:uint = 0;
			var gloryBoundCount:uint = 0;
			var providerIDCount:uint = 0;
			var reporterIDCount:uint = 0;
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
					if (nameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nameCount;
					name = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (descriptionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++descriptionCount;
					description = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					processinfolist.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.task.task1409.ProcessInfo));
					break;
				case 5:
					if (ExpBoundCount != 0) {
						throw new IOError('Bad data format.');
					}
					++ExpBoundCount;
					ExpBound = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (coinBoundCount != 0) {
						throw new IOError('Bad data format.');
					}
					++coinBoundCount;
					coinBound = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (couponBoundCount != 0) {
						throw new IOError('Bad data format.');
					}
					++couponBoundCount;
					couponBound = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					requiredItemBound.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.task.task1409.ItemsInfo));
					break;
				case 9:
					optionalItemBound.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.task.task1409.ItemsInfo));
					break;
				case 10:
					if (gloryBoundCount != 0) {
						throw new IOError('Bad data format.');
					}
					++gloryBoundCount;
					gloryBound = ReadUtils.read_TYPE_INT32(input);
					break;
				case 11:
					if (providerIDCount != 0) {
						throw new IOError('Bad data format.');
					}
					++providerIDCount;
					providerID = ReadUtils.read_TYPE_INT32(input);
					break;
				case 12:
					if (reporterIDCount != 0) {
						throw new IOError('Bad data format.');
					}
					++reporterIDCount;
					reporterID = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
