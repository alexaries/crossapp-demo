package proto.chat.chat1006 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ModifyChatSettingRequest extends Message implements IExternalizable {
		public var id:int;
		public var systemCK:Boolean;
		public var showCK:Boolean;
		public var commonCK:Boolean;
		public var groupCK:Boolean;
		public var corpsCK:Boolean;
		public var selfCK:Boolean;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_BOOL(output, systemCK);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_BOOL(output, showCK);
			WriteUtils.writeTag(output, WireType.VARINT, 4);
			WriteUtils.write_TYPE_BOOL(output, commonCK);
			WriteUtils.writeTag(output, WireType.VARINT, 5);
			WriteUtils.write_TYPE_BOOL(output, groupCK);
			WriteUtils.writeTag(output, WireType.VARINT, 6);
			WriteUtils.write_TYPE_BOOL(output, corpsCK);
			WriteUtils.writeTag(output, WireType.VARINT, 7);
			WriteUtils.write_TYPE_BOOL(output, selfCK);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var systemCKCount:uint = 0;
			var showCKCount:uint = 0;
			var commonCKCount:uint = 0;
			var groupCKCount:uint = 0;
			var corpsCKCount:uint = 0;
			var selfCKCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (idCount != 0) {
						throw new IOError('Bad data format.');
					}
					++idCount;
					id = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (systemCKCount != 0) {
						throw new IOError('Bad data format.');
					}
					++systemCKCount;
					systemCK = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 3:
					if (showCKCount != 0) {
						throw new IOError('Bad data format.');
					}
					++showCKCount;
					showCK = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 4:
					if (commonCKCount != 0) {
						throw new IOError('Bad data format.');
					}
					++commonCKCount;
					commonCK = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 5:
					if (groupCKCount != 0) {
						throw new IOError('Bad data format.');
					}
					++groupCKCount;
					groupCK = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 6:
					if (corpsCKCount != 0) {
						throw new IOError('Bad data format.');
					}
					++corpsCKCount;
					corpsCK = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 7:
					if (selfCKCount != 0) {
						throw new IOError('Bad data format.');
					}
					++selfCKCount;
					selfCK = ReadUtils.read_TYPE_BOOL(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (systemCKCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (showCKCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (commonCKCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (groupCKCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (corpsCKCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (selfCKCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
