package proto.scene.scene221 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.scene.PlayerPropertyInfo;
	import proto.scene.scene221.OtherRoleItemInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ResponseInfoData extends Message implements IExternalizable {
		public var otherRoleInfo:proto.scene.PlayerPropertyInfo;
		[ArrayElementType("proto.scene.scene221.OtherRoleItemInfo")]
		public var otherRoleItem:Array = [];
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
			WriteUtils.write_TYPE_MESSAGE(output, otherRoleInfo);
			for (var otherRoleItemIndex:uint = 0; otherRoleItemIndex < otherRoleItem.length; ++otherRoleItemIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_MESSAGE(output, otherRoleItem[otherRoleItemIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var otherRoleInfoCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (otherRoleInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++otherRoleInfoCount;
					otherRoleInfo = new proto.scene.PlayerPropertyInfo;
					ReadUtils.read_TYPE_MESSAGE(input, otherRoleInfo);
					break;
				case 2:
					otherRoleItem.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.scene.scene221.OtherRoleItemInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (otherRoleInfoCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
