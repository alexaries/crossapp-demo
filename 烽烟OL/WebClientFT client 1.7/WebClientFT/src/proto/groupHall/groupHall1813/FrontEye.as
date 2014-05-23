package proto.groupHall.groupHall1813 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.groupHall.groupHall1813.Role;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class FrontEye extends Message implements IExternalizable {
		private var isOpened_:Boolean;
		private var hasIsOpened_:Boolean = false;
		public function get hasIsOpened():Boolean {
			return hasIsOpened_;
		}
		public function set isOpened(value:Boolean):void {
			hasIsOpened_ = true;
			isOpened_ = value;
		}
		public function get isOpened():Boolean {
			return isOpened_;
		}
		private var effectPercen_:int;
		private var hasEffectPercen_:Boolean = false;
		public function get hasEffectPercen():Boolean {
			return hasEffectPercen_;
		}
		public function set effectPercen(value:int):void {
			hasEffectPercen_ = true;
			effectPercen_ = value;
		}
		public function get effectPercen():int {
			return effectPercen_;
		}
		private var pos_:int;
		private var hasPos_:Boolean = false;
		public function get hasPos():Boolean {
			return hasPos_;
		}
		public function set pos(value:int):void {
			hasPos_ = true;
			pos_ = value;
		}
		public function get pos():int {
			return pos_;
		}
		private var isHaveRole_:Boolean;
		private var hasIsHaveRole_:Boolean = false;
		public function get hasIsHaveRole():Boolean {
			return hasIsHaveRole_;
		}
		public function set isHaveRole(value:Boolean):void {
			hasIsHaveRole_ = true;
			isHaveRole_ = value;
		}
		public function get isHaveRole():Boolean {
			return isHaveRole_;
		}
		private var roleInfo_:proto.groupHall.groupHall1813.Role;
		public function get hasRoleInfo():Boolean {
			return null != roleInfo_;
		}
		public function set roleInfo(value:proto.groupHall.groupHall1813.Role):void {
			roleInfo_ = value;
		}
		public function get roleInfo():proto.groupHall.groupHall1813.Role {
			return roleInfo_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasIsOpened) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_BOOL(output, isOpened);
			}
			if (hasEffectPercen) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, effectPercen);
			}
			if (hasPos) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, pos);
			}
			if (hasIsHaveRole) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_BOOL(output, isHaveRole);
			}
			if (hasRoleInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_MESSAGE(output, roleInfo);
			}
		}
		public function readExternal(input:IDataInput):void {
			var isOpenedCount:uint = 0;
			var effectPercenCount:uint = 0;
			var posCount:uint = 0;
			var isHaveRoleCount:uint = 0;
			var roleInfoCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (isOpenedCount != 0) {
						throw new IOError('Bad data format.');
					}
					++isOpenedCount;
					isOpened = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 2:
					if (effectPercenCount != 0) {
						throw new IOError('Bad data format.');
					}
					++effectPercenCount;
					effectPercen = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (posCount != 0) {
						throw new IOError('Bad data format.');
					}
					++posCount;
					pos = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (isHaveRoleCount != 0) {
						throw new IOError('Bad data format.');
					}
					++isHaveRoleCount;
					isHaveRole = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 5:
					if (roleInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++roleInfoCount;
					roleInfo = new proto.groupHall.groupHall1813.Role;
					ReadUtils.read_TYPE_MESSAGE(input, roleInfo);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
