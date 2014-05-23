package proto.pratice.getRestRoomInfo {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class Info extends Message implements IExternalizable {
		private var image_:String;
		public function get hasImage():Boolean {
			return null != image_;
		}
		public function set image(value:String):void {
			image_ = value;
		}
		public function get image():String {
			return image_;
		}
		private var dialogContent_:String;
		public function get hasDialogContent():Boolean {
			return null != dialogContent_;
		}
		public function set dialogContent(value:String):void {
			dialogContent_ = value;
		}
		public function get dialogContent():String {
			return dialogContent_;
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
			if (hasImage) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, image);
			}
			if (hasDialogContent) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, dialogContent);
			}
			if (hasId) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, id);
			}
			if (hasName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, name);
			}
		}
		public function readExternal(input:IDataInput):void {
			var imageCount:uint = 0;
			var dialogContentCount:uint = 0;
			var idCount:uint = 0;
			var nameCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (imageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++imageCount;
					image = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (dialogContentCount != 0) {
						throw new IOError('Bad data format.');
					}
					++dialogContentCount;
					dialogContent = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (idCount != 0) {
						throw new IOError('Bad data format.');
					}
					++idCount;
					id = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
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
