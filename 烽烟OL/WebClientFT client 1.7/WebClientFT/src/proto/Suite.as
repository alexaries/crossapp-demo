package proto {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.SuiteEffec;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class Suite extends Message implements IExternalizable {
		private var suitename_:String;
		public function get hasSuitename():Boolean {
			return null != suitename_;
		}
		public function set suitename(value:String):void {
			suitename_ = value;
		}
		public function get suitename():String {
			return suitename_;
		}
		private var nowcnt_:int;
		private var hasNowcnt_:Boolean = false;
		public function get hasNowcnt():Boolean {
			return hasNowcnt_;
		}
		public function set nowcnt(value:int):void {
			hasNowcnt_ = true;
			nowcnt_ = value;
		}
		public function get nowcnt():int {
			return nowcnt_;
		}
		private var maxcnt_:int;
		private var hasMaxcnt_:Boolean = false;
		public function get hasMaxcnt():Boolean {
			return hasMaxcnt_;
		}
		public function set maxcnt(value:int):void {
			hasMaxcnt_ = true;
			maxcnt_ = value;
		}
		public function get maxcnt():int {
			return maxcnt_;
		}
		[ArrayElementType("proto.SuiteEffec")]
		public var suiteeffct:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasSuitename) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, suitename);
			}
			if (hasNowcnt) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, nowcnt);
			}
			if (hasMaxcnt) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, maxcnt);
			}
			for (var suiteeffctIndex:uint = 0; suiteeffctIndex < suiteeffct.length; ++suiteeffctIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_MESSAGE(output, suiteeffct[suiteeffctIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var suitenameCount:uint = 0;
			var nowcntCount:uint = 0;
			var maxcntCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (suitenameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++suitenameCount;
					suitename = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (nowcntCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nowcntCount;
					nowcnt = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (maxcntCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxcntCount;
					maxcnt = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					suiteeffct.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.SuiteEffec));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
