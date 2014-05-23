package proto.copyScene.copyScene1503 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class instanceTeamResponse extends Message implements IExternalizable {
		public var leaderid:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, leaderid);
		}
		public function readExternal(input:IDataInput):void {
			var leaderidCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (leaderidCount != 0) {
						throw new IOError('Bad data format.');
					}
					++leaderidCount;
					leaderid = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (leaderidCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
