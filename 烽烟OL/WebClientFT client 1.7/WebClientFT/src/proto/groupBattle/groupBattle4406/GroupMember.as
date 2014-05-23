package proto.groupBattle.groupBattle4406 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GroupMember extends Message implements IExternalizable {
		private var memberId_:int;
		private var hasMemberId_:Boolean = false;
		public function get hasMemberId():Boolean {
			return hasMemberId_;
		}
		public function set memberId(value:int):void {
			hasMemberId_ = true;
			memberId_ = value;
		}
		public function get memberId():int {
			return memberId_;
		}
		private var memberName_:String;
		public function get hasMemberName():Boolean {
			return null != memberName_;
		}
		public function set memberName(value:String):void {
			memberName_ = value;
		}
		public function get memberName():String {
			return memberName_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasMemberId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, memberId);
			}
			if (hasMemberName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, memberName);
			}
		}
		public function readExternal(input:IDataInput):void {
			var memberIdCount:uint = 0;
			var memberNameCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (memberIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++memberIdCount;
					memberId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (memberNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++memberNameCount;
					memberName = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
