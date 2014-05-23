package proto.scene.scene204 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.ItemsInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class PackageInfo extends Message implements IExternalizable {
		private var itemInfo_:proto.ItemsInfo;
		public function get hasItemInfo():Boolean {
			return null != itemInfo_;
		}
		public function set itemInfo(value:proto.ItemsInfo):void {
			itemInfo_ = value;
		}
		public function get itemInfo():proto.ItemsInfo {
			return itemInfo_;
		}
		private var position_:int;
		private var hasPosition_:Boolean = false;
		public function get hasPosition():Boolean {
			return hasPosition_;
		}
		public function set position(value:int):void {
			hasPosition_ = true;
			position_ = value;
		}
		public function get position():int {
			return position_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasItemInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, itemInfo);
			}
			if (hasPosition) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, position);
			}
		}
		public function readExternal(input:IDataInput):void {
			var itemInfoCount:uint = 0;
			var positionCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (itemInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemInfoCount;
					itemInfo = new proto.ItemsInfo;
					ReadUtils.read_TYPE_MESSAGE(input, itemInfo);
					break;
				case 2:
					if (positionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++positionCount;
					position = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
