package proto.scene.scene203 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.scene.scene203.PackageInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class responseData extends Message implements IExternalizable {
		[ArrayElementType("proto.scene.scene203.PackageInfo")]
		public var packageItemInfo:Array = [];
		public function writeExternal(output:IDataOutput):void {
			for (var packageItemInfoIndex:uint = 0; packageItemInfoIndex < packageItemInfo.length; ++packageItemInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, packageItemInfo[packageItemInfoIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					packageItemInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.scene.scene203.PackageInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
