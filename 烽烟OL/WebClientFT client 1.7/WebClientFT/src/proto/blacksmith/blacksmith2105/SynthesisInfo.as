package proto.blacksmith.blacksmith2105 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.blacksmith.blacksmith2105.ItemsInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class SynthesisInfo extends Message implements IExternalizable {
		private var itemInfo1_:proto.blacksmith.blacksmith2105.ItemsInfo;
		public function get hasItemInfo1():Boolean {
			return null != itemInfo1_;
		}
		public function set itemInfo1(value:proto.blacksmith.blacksmith2105.ItemsInfo):void {
			itemInfo1_ = value;
		}
		public function get itemInfo1():proto.blacksmith.blacksmith2105.ItemsInfo {
			return itemInfo1_;
		}
		private var itemInfo2_:proto.blacksmith.blacksmith2105.ItemsInfo;
		public function get hasItemInfo2():Boolean {
			return null != itemInfo2_;
		}
		public function set itemInfo2(value:proto.blacksmith.blacksmith2105.ItemsInfo):void {
			itemInfo2_ = value;
		}
		public function get itemInfo2():proto.blacksmith.blacksmith2105.ItemsInfo {
			return itemInfo2_;
		}
		private var targetItemInfo_:proto.blacksmith.blacksmith2105.ItemsInfo;
		public function get hasTargetItemInfo():Boolean {
			return null != targetItemInfo_;
		}
		public function set targetItemInfo(value:proto.blacksmith.blacksmith2105.ItemsInfo):void {
			targetItemInfo_ = value;
		}
		public function get targetItemInfo():proto.blacksmith.blacksmith2105.ItemsInfo {
			return targetItemInfo_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasItemInfo1) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, itemInfo1);
			}
			if (hasItemInfo2) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_MESSAGE(output, itemInfo2);
			}
			if (hasTargetItemInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, targetItemInfo);
			}
		}
		public function readExternal(input:IDataInput):void {
			var itemInfo1Count:uint = 0;
			var itemInfo2Count:uint = 0;
			var targetItemInfoCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (itemInfo1Count != 0) {
						throw new IOError('Bad data format.');
					}
					++itemInfo1Count;
					itemInfo1 = new proto.blacksmith.blacksmith2105.ItemsInfo;
					ReadUtils.read_TYPE_MESSAGE(input, itemInfo1);
					break;
				case 2:
					if (itemInfo2Count != 0) {
						throw new IOError('Bad data format.');
					}
					++itemInfo2Count;
					itemInfo2 = new proto.blacksmith.blacksmith2105.ItemsInfo;
					ReadUtils.read_TYPE_MESSAGE(input, itemInfo2);
					break;
				case 3:
					if (targetItemInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++targetItemInfoCount;
					targetItemInfo = new proto.blacksmith.blacksmith2105.ItemsInfo;
					ReadUtils.read_TYPE_MESSAGE(input, targetItemInfo);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
