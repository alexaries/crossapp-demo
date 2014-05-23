package proto.groupBattle.groupBattle4404 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class UsedInfo extends Message implements IExternalizable {
		private var name_:String;
		public function get hasName():Boolean {
			return null != name_;
		}
		public function set name(value:String):void {
			name_ = value;
		}
		public function get name():String {
			return name_;
		}
		private var type_:int;
		private var hasType_:Boolean = false;
		public function get hasType():Boolean {
			return hasType_;
		}
		public function set type(value:int):void {
			hasType_ = true;
			type_ = value;
		}
		public function get type():int {
			return type_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, name);
			}
			if (hasType) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, type);
			}
		}
		public function readExternal(input:IDataInput):void {
			var nameCount:uint = 0;
			var typeCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (nameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nameCount;
					name = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (typeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++typeCount;
					type = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
