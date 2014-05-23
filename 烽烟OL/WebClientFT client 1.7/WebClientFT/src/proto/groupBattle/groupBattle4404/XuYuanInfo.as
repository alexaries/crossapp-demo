package proto.groupBattle.groupBattle4404 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.groupBattle.groupBattle4404.UsedInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class XuYuanInfo extends Message implements IExternalizable {
		private var xyValue_:int;
		private var hasXyValue_:Boolean = false;
		public function get hasXyValue():Boolean {
			return hasXyValue_;
		}
		public function set xyValue(value:int):void {
			hasXyValue_ = true;
			xyValue_ = value;
		}
		public function get xyValue():int {
			return xyValue_;
		}
		[ArrayElementType("proto.groupBattle.groupBattle4404.UsedInfo")]
		public var usedInfo:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasXyValue) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, xyValue);
			}
			for (var usedInfoIndex:uint = 0; usedInfoIndex < usedInfo.length; ++usedInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_MESSAGE(output, usedInfo[usedInfoIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var xyValueCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (xyValueCount != 0) {
						throw new IOError('Bad data format.');
					}
					++xyValueCount;
					xyValue = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					usedInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.groupBattle.groupBattle4404.UsedInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
