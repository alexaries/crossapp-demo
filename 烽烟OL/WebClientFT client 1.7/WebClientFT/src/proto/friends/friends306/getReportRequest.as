package proto.friends.friends306 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class getReportRequest extends Message implements IExternalizable {
		public var cid:int;
		public var tocid:int;
		private var context_:String;
		public function get hasContext():Boolean {
			return null != context_;
		}
		public function set context(value:String):void {
			context_ = value;
		}
		public function get context():String {
			return context_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, cid);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, tocid);
			if (hasContext) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, context);
			}
		}
		public function readExternal(input:IDataInput):void {
			var cidCount:uint = 0;
			var tocidCount:uint = 0;
			var contextCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (cidCount != 0) {
						throw new IOError('Bad data format.');
					}
					++cidCount;
					cid = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (tocidCount != 0) {
						throw new IOError('Bad data format.');
					}
					++tocidCount;
					tocid = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (contextCount != 0) {
						throw new IOError('Bad data format.');
					}
					++contextCount;
					context = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (cidCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (tocidCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
