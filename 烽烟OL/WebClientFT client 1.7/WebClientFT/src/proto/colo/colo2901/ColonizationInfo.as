package proto.colo.colo2901 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ColonizationInfo extends Message implements IExternalizable {
		private var coloId_:int;
		private var hasColoId_:Boolean = false;
		public function get hasColoId():Boolean {
			return hasColoId_;
		}
		public function set coloId(value:int):void {
			hasColoId_ = true;
			coloId_ = value;
		}
		public function get coloId():int {
			return coloId_;
		}
		private var coloName_:String;
		public function get hasColoName():Boolean {
			return null != coloName_;
		}
		public function set coloName(value:String):void {
			coloName_ = value;
		}
		public function get coloName():String {
			return coloName_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasColoId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, coloId);
			}
			if (hasColoName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, coloName);
			}
		}
		public function readExternal(input:IDataInput):void {
			var coloIdCount:uint = 0;
			var coloNameCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (coloIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++coloIdCount;
					coloId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (coloNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++coloNameCount;
					coloName = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
