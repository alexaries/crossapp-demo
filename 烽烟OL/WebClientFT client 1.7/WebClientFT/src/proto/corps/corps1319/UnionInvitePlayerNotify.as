package proto.corps.corps1319 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class UnionInvitePlayerNotify extends Message implements IExternalizable {
		public var playerid:int;
		public var unionid:int;
		public var playername:String;
		public var unionname:String;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, playerid);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, unionid);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
			WriteUtils.write_TYPE_STRING(output, playername);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
			WriteUtils.write_TYPE_STRING(output, unionname);
		}
		public function readExternal(input:IDataInput):void {
			var playeridCount:uint = 0;
			var unionidCount:uint = 0;
			var playernameCount:uint = 0;
			var unionnameCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (playeridCount != 0) {
						throw new IOError('Bad data format.');
					}
					++playeridCount;
					playerid = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (unionidCount != 0) {
						throw new IOError('Bad data format.');
					}
					++unionidCount;
					unionid = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (playernameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++playernameCount;
					playername = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (unionnameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++unionnameCount;
					unionname = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (playeridCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (unionidCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (playernameCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (unionnameCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
