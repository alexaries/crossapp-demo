package proto.friends.friends302 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.friends.friends302.Friend;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class Friends extends Message implements IExternalizable {
		[ArrayElementType("proto.friends.friends302.Friend")]
		public var friends:Array = [];
		public function writeExternal(output:IDataOutput):void {
			for (var friendsIndex:uint = 0; friendsIndex < friends.length; ++friendsIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, friends[friendsIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					friends.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.friends.friends302.Friend));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
