package proto.corps.corps1310 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ManagermentInfo extends Message implements IExternalizable {
		private var roleName_:String;
		public function get hasRoleName():Boolean {
			return null != roleName_;
		}
		public function set roleName(value:String):void {
			roleName_ = value;
		}
		public function get roleName():String {
			return roleName_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasRoleName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, roleName);
			}
		}
		public function readExternal(input:IDataInput):void {
			var roleNameCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (roleNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++roleNameCount;
					roleName = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
