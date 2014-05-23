package proto.scene {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class SceneEntity extends Message implements IExternalizable {
		public var id:int;
		public var profession:int;
		public var figure:int;
		public var posx:int;
		public var poxy:int;
		public var name:String;
		private var unionName_:String;
		public function get hasUnionName():Boolean {
			return null != unionName_;
		}
		public function set unionName(value:String):void {
			unionName_ = value;
		}
		public function get unionName():String {
			return unionName_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, profession);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, figure);
			WriteUtils.writeTag(output, WireType.VARINT, 4);
			WriteUtils.write_TYPE_INT32(output, posx);
			WriteUtils.writeTag(output, WireType.VARINT, 5);
			WriteUtils.write_TYPE_INT32(output, poxy);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
			WriteUtils.write_TYPE_STRING(output, name);
			if (hasUnionName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
				WriteUtils.write_TYPE_STRING(output, unionName);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var professionCount:uint = 0;
			var figureCount:uint = 0;
			var posxCount:uint = 0;
			var poxyCount:uint = 0;
			var nameCount:uint = 0;
			var unionNameCount:uint = 0;
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
					if (professionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++professionCount;
					profession = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (figureCount != 0) {
						throw new IOError('Bad data format.');
					}
					++figureCount;
					figure = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (posxCount != 0) {
						throw new IOError('Bad data format.');
					}
					++posxCount;
					posx = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (poxyCount != 0) {
						throw new IOError('Bad data format.');
					}
					++poxyCount;
					poxy = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (nameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nameCount;
					name = ReadUtils.read_TYPE_STRING(input);
					break;
				case 7:
					if (unionNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++unionNameCount;
					unionName = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (professionCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (figureCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (posxCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (poxyCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (nameCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
