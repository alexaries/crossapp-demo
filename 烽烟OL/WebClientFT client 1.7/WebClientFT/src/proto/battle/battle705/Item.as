package proto.battle.battle705 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class Item extends Message implements IExternalizable {
		private var itemTemplateId_:int;
		private var hasItemTemplateId_:Boolean = false;
		public function get hasItemTemplateId():Boolean {
			return hasItemTemplateId_;
		}
		public function set itemTemplateId(value:int):void {
			hasItemTemplateId_ = true;
			itemTemplateId_ = value;
		}
		public function get itemTemplateId():int {
			return itemTemplateId_;
		}
		[ArrayElementType("int")]
		public var extraAttributeList:Array = [];
		[ArrayElementType("int")]
		public var selfAttributeList:Array = [];
		private var qualityLevel_:int;
		private var hasQualityLevel_:Boolean = false;
		public function get hasQualityLevel():Boolean {
			return hasQualityLevel_;
		}
		public function set qualityLevel(value:int):void {
			hasQualityLevel_ = true;
			qualityLevel_ = value;
		}
		public function get qualityLevel():int {
			return qualityLevel_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasItemTemplateId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, itemTemplateId);
			}
			for (var extraAttributeListIndex:uint = 0; extraAttributeListIndex < extraAttributeList.length; ++extraAttributeListIndex) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, extraAttributeList[extraAttributeListIndex]);
			}
			for (var selfAttributeListIndex:uint = 0; selfAttributeListIndex < selfAttributeList.length; ++selfAttributeListIndex) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, selfAttributeList[selfAttributeListIndex]);
			}
			if (hasQualityLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, qualityLevel);
			}
		}
		public function readExternal(input:IDataInput):void {
			var itemTemplateIdCount:uint = 0;
			var qualityLevelCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (itemTemplateIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemTemplateIdCount;
					itemTemplateId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (tag.wireType == WireType.LENGTH_DELIMITED) {
						ReadUtils.readPackedRepeated(input, ReadUtils.read_TYPE_INT32, extraAttributeList);
					break;
					}
					extraAttributeList.push(ReadUtils.read_TYPE_INT32(input));
					break;
				case 3:
					if (tag.wireType == WireType.LENGTH_DELIMITED) {
						ReadUtils.readPackedRepeated(input, ReadUtils.read_TYPE_INT32, selfAttributeList);
					break;
					}
					selfAttributeList.push(ReadUtils.read_TYPE_INT32(input));
					break;
				case 4:
					if (qualityLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++qualityLevelCount;
					qualityLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
