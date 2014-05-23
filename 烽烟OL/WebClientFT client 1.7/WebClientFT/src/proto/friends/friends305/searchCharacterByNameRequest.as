package proto.friends.friends305 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class searchCharacterByNameRequest extends Message implements IExternalizable {
		public var id:int;
		public var nickName:String;
		private var ziduan_:int;
		private var hasZiduan_:Boolean = false;
		public function get hasZiduan():Boolean {
			return hasZiduan_;
		}
		public function set ziduan(value:int):void {
			hasZiduan_ = true;
			ziduan_ = value;
		}
		public function get ziduan():int {
			return ziduan_;
		}
		private var guize_:int;
		private var hasGuize_:Boolean = false;
		public function get hasGuize():Boolean {
			return hasGuize_;
		}
		public function set guize(value:int):void {
			hasGuize_ = true;
			guize_ = value;
		}
		public function get guize():int {
			return guize_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
			WriteUtils.write_TYPE_STRING(output, nickName);
			if (hasZiduan) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, ziduan);
			}
			if (hasGuize) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, guize);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var nickNameCount:uint = 0;
			var ziduanCount:uint = 0;
			var guizeCount:uint = 0;
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
					if (nickNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nickNameCount;
					nickName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (ziduanCount != 0) {
						throw new IOError('Bad data format.');
					}
					++ziduanCount;
					ziduan = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (guizeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++guizeCount;
					guize = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (nickNameCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
