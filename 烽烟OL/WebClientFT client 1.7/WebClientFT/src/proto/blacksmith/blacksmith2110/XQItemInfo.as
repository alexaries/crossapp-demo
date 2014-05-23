package proto.blacksmith.blacksmith2110 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.ItemsInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class XQItemInfo extends Message implements IExternalizable {
		private var inBody_:int;
		private var hasInBody_:Boolean = false;
		public function get hasInBody():Boolean {
			return hasInBody_;
		}
		public function set inBody(value:int):void {
			hasInBody_ = true;
			inBody_ = value;
		}
		public function get inBody():int {
			return inBody_;
		}
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
		public function writeExternal(output:IDataOutput):void {
			if (hasInBody) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, inBody);
			}
			if (hasItemInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_MESSAGE(output, itemInfo);
			}
		}
		public function readExternal(input:IDataInput):void {
			var inBodyCount:uint = 0;
			var itemInfoCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (inBodyCount != 0) {
						throw new IOError('Bad data format.');
					}
					++inBodyCount;
					inBody = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (itemInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemInfoCount;
					itemInfo = new proto.ItemsInfo;
					ReadUtils.read_TYPE_MESSAGE(input, itemInfo);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
