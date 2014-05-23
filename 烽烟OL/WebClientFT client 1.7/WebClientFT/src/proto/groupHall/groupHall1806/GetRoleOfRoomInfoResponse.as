package proto.groupHall.groupHall1806 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.groupHall.groupHall1806.RoleOfRoomInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GetRoleOfRoomInfoResponse extends Message implements IExternalizable {
		[ArrayElementType("proto.groupHall.groupHall1806.RoleOfRoomInfo")]
		public var roleOfRoomInfo:Array = [];
		public function writeExternal(output:IDataOutput):void {
			for (var roleOfRoomInfoIndex:uint = 0; roleOfRoomInfoIndex < roleOfRoomInfo.length; ++roleOfRoomInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, roleOfRoomInfo[roleOfRoomInfoIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					roleOfRoomInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.groupHall.groupHall1806.RoleOfRoomInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
