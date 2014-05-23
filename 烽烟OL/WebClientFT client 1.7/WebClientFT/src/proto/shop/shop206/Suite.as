package proto.shop.shop206 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class Suite extends Message implements IExternalizable {
		private var suitItemName_:String;
		public function get hasSuitItemName():Boolean {
			return null != suitItemName_;
		}
		public function set suitItemName(value:String):void {
			suitItemName_ = value;
		}
		public function get suitItemName():String {
			return suitItemName_;
		}
		private var hasSiutitem_:int;
		private var hasHasSiutitem_:Boolean = false;
		public function get hasHasSiutitem():Boolean {
			return hasHasSiutitem_;
		}
		public function set hasSiutitem(value:int):void {
			hasHasSiutitem_ = true;
			hasSiutitem_ = value;
		}
		public function get hasSiutitem():int {
			return hasSiutitem_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasSuitItemName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, suitItemName);
			}
			if (hasHasSiutitem) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, hasSiutitem);
			}
		}
		public function readExternal(input:IDataInput):void {
			var suitItemNameCount:uint = 0;
			var hasSiutitemCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (suitItemNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++suitItemNameCount;
					suitItemName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (hasSiutitemCount != 0) {
						throw new IOError('Bad data format.');
					}
					++hasSiutitemCount;
					hasSiutitem = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
