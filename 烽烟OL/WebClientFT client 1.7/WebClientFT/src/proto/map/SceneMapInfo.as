package proto.map {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class SceneMapInfo extends Message implements IExternalizable {
		public var id:int;
		public var color:int;
		public var tax:int;
		public var income:int;
		public var sceneName:String;
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
			WriteUtils.write_TYPE_INT32(output, color);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, tax);
			WriteUtils.writeTag(output, WireType.VARINT, 4);
			WriteUtils.write_TYPE_INT32(output, income);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
			WriteUtils.write_TYPE_STRING(output, sceneName);
			if (hasUnionName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_STRING(output, unionName);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var colorCount:uint = 0;
			var taxCount:uint = 0;
			var incomeCount:uint = 0;
			var sceneNameCount:uint = 0;
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
					if (colorCount != 0) {
						throw new IOError('Bad data format.');
					}
					++colorCount;
					color = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (taxCount != 0) {
						throw new IOError('Bad data format.');
					}
					++taxCount;
					tax = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (incomeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++incomeCount;
					income = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (sceneNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sceneNameCount;
					sceneName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 6:
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
			if (colorCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (taxCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (incomeCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (sceneNameCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
