package proto.login.login101 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class userInfo extends Message implements IExternalizable {
		private var userId_:int;
		private var hasUserId_:Boolean = false;
		public function get hasUserId():Boolean {
			return hasUserId_;
		}
		public function set userId(value:int):void {
			hasUserId_ = true;
			userId_ = value;
		}
		public function get userId():int {
			return userId_;
		}
		private var hasRole_:Boolean;
		private var hasHasRole_:Boolean = false;
		public function get hasHasRole():Boolean {
			return hasHasRole_;
		}
		public function set hasRole(value:Boolean):void {
			hasHasRole_ = true;
			hasRole_ = value;
		}
		public function get hasRole():Boolean {
			return hasRole_;
		}
		private var defaultId_:int;
		private var hasDefaultId_:Boolean = false;
		public function get hasDefaultId():Boolean {
			return hasDefaultId_;
		}
		public function set defaultId(value:int):void {
			hasDefaultId_ = true;
			defaultId_ = value;
		}
		public function get defaultId():int {
			return defaultId_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasUserId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, userId);
			}
			if (hasHasRole) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_BOOL(output, hasRole);
			}
			if (hasDefaultId) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, defaultId);
			}
		}
		public function readExternal(input:IDataInput):void {
			var userIdCount:uint = 0;
			var hasRoleCount:uint = 0;
			var defaultIdCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (userIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++userIdCount;
					userId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (hasRoleCount != 0) {
						throw new IOError('Bad data format.');
					}
					++hasRoleCount;
					hasRole = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 3:
					if (defaultIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++defaultIdCount;
					defaultId = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
