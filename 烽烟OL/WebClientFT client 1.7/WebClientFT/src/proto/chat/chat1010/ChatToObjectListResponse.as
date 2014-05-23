package proto.chat.chat1010 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.chat.chat1010.ChatObjectInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ChatToObjectListResponse extends Message implements IExternalizable {
		[ArrayElementType("proto.chat.chat1010.ChatObjectInfo")]
		public var chatObjectInfo:Array = [];
		public function writeExternal(output:IDataOutput):void {
			for (var chatObjectInfoIndex:uint = 0; chatObjectInfoIndex < chatObjectInfo.length; ++chatObjectInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, chatObjectInfo[chatObjectInfoIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					chatObjectInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.chat.chat1010.ChatObjectInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
