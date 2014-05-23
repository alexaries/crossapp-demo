package proto.tavern.tavern3503 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.tavern.tavern3503.XingYunTavernWoWInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class WoW extends Message implements IExternalizable {
		[ArrayElementType("proto.tavern.tavern3503.XingYunTavernWoWInfo")]
		public var xingYunwowInfo:Array = [];
		private var page_:int;
		private var hasPage_:Boolean = false;
		public function get hasPage():Boolean {
			return hasPage_;
		}
		public function set page(value:int):void {
			hasPage_ = true;
			page_ = value;
		}
		public function get page():int {
			return page_;
		}
		private var zong_:int;
		private var hasZong_:Boolean = false;
		public function get hasZong():Boolean {
			return hasZong_;
		}
		public function set zong(value:int):void {
			hasZong_ = true;
			zong_ = value;
		}
		public function get zong():int {
			return zong_;
		}
		public function writeExternal(output:IDataOutput):void {
			for (var xingYunwowInfoIndex:uint = 0; xingYunwowInfoIndex < xingYunwowInfo.length; ++xingYunwowInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, xingYunwowInfo[xingYunwowInfoIndex]);
			}
			if (hasPage) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, page);
			}
			if (hasZong) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, zong);
			}
		}
		public function readExternal(input:IDataInput):void {
			var pageCount:uint = 0;
			var zongCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					xingYunwowInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.tavern.tavern3503.XingYunTavernWoWInfo));
					break;
				case 2:
					if (pageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++pageCount;
					page = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (zongCount != 0) {
						throw new IOError('Bad data format.');
					}
					++zongCount;
					zong = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
