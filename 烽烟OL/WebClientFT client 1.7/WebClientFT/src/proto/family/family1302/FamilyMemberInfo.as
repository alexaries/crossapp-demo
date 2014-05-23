package proto.family.family1302 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.family.family1302.FamilyMemberBasicInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class FamilyMemberInfo extends Message implements IExternalizable {
		private var pageCount_:int;
		private var hasPageCount_:Boolean = false;
		public function get hasPageCount():Boolean {
			return hasPageCount_;
		}
		public function set pageCount(value:int):void {
			hasPageCount_ = true;
			pageCount_ = value;
		}
		public function get pageCount():int {
			return pageCount_;
		}
		[ArrayElementType("proto.family.family1302.FamilyMemberBasicInfo")]
		public var familyMemberBasicInfo:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasPageCount) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, pageCount);
			}
			for (var familyMemberBasicInfoIndex:uint = 0; familyMemberBasicInfoIndex < familyMemberBasicInfo.length; ++familyMemberBasicInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_MESSAGE(output, familyMemberBasicInfo[familyMemberBasicInfoIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var pageCountCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (pageCountCount != 0) {
						throw new IOError('Bad data format.');
					}
					++pageCountCount;
					pageCount = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					familyMemberBasicInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.family.family1302.FamilyMemberBasicInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
