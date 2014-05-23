package proto.group.group906 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.group.group906.memberInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class TeamMemberInfo extends Message implements IExternalizable {
		[ArrayElementType("proto.group.group906.memberInfo")]
		public var member:Array = [];
		public var leaderId:int;
		public function writeExternal(output:IDataOutput):void {
			for (var memberIndex:uint = 0; memberIndex < member.length; ++memberIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, member[memberIndex]);
			}
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, leaderId);
		}
		public function readExternal(input:IDataInput):void {
			var leaderIdCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					member.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.group.group906.memberInfo));
					break;
				case 2:
					if (leaderIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++leaderIdCount;
					leaderId = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (leaderIdCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
