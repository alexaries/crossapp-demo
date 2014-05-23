package proto.chat.chat1003 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class itemLinkData extends Message implements IExternalizable {
		private var chatEquipType_:int;
		private var hasChatEquipType_:Boolean = false;
		public function get hasChatEquipType():Boolean {
			return hasChatEquipType_;
		}
		public function set chatEquipType(value:int):void {
			hasChatEquipType_ = true;
			chatEquipType_ = value;
		}
		public function get chatEquipType():int {
			return chatEquipType_;
		}
		private var id_:int;
		private var hasId_:Boolean = false;
		public function get hasId():Boolean {
			return hasId_;
		}
		public function set id(value:int):void {
			hasId_ = true;
			id_ = value;
		}
		public function get id():int {
			return id_;
		}
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
		public function writeExternal(output:IDataOutput):void {
			if (hasChatEquipType) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, chatEquipType);
			}
			if (hasId) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, id);
			}
			if (hasName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, name);
			}
		}
		public function readExternal(input:IDataInput):void {
			var chatEquipTypeCount:uint = 0;
			var idCount:uint = 0;
			var nameCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (chatEquipTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chatEquipTypeCount;
					chatEquipType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (idCount != 0) {
						throw new IOError('Bad data format.');
					}
					++idCount;
					id = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (nameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nameCount;
					name = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
