package proto.guaji.guaji3203 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.guaji.guaji3203.DayListTaskInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class DayTaskInfo extends Message implements IExternalizable {
		private var isSucFlag_:Boolean;
		private var hasIsSucFlag_:Boolean = false;
		public function get hasIsSucFlag():Boolean {
			return hasIsSucFlag_;
		}
		public function set isSucFlag(value:Boolean):void {
			hasIsSucFlag_ = true;
			isSucFlag_ = value;
		}
		public function get isSucFlag():Boolean {
			return isSucFlag_;
		}
		[ArrayElementType("proto.guaji.guaji3203.DayListTaskInfo")]
		public var dayListTaskInfo:Array = [];
		private var isOpenFlag_:Boolean;
		private var hasIsOpenFlag_:Boolean = false;
		public function get hasIsOpenFlag():Boolean {
			return hasIsOpenFlag_;
		}
		public function set isOpenFlag(value:Boolean):void {
			hasIsOpenFlag_ = true;
			isOpenFlag_ = value;
		}
		public function get isOpenFlag():Boolean {
			return isOpenFlag_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasIsSucFlag) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_BOOL(output, isSucFlag);
			}
			for (var dayListTaskInfoIndex:uint = 0; dayListTaskInfoIndex < dayListTaskInfo.length; ++dayListTaskInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_MESSAGE(output, dayListTaskInfo[dayListTaskInfoIndex]);
			}
			if (hasIsOpenFlag) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_BOOL(output, isOpenFlag);
			}
		}
		public function readExternal(input:IDataInput):void {
			var isSucFlagCount:uint = 0;
			var isOpenFlagCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (isSucFlagCount != 0) {
						throw new IOError('Bad data format.');
					}
					++isSucFlagCount;
					isSucFlag = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 2:
					dayListTaskInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.guaji.guaji3203.DayListTaskInfo));
					break;
				case 3:
					if (isOpenFlagCount != 0) {
						throw new IOError('Bad data format.');
					}
					++isOpenFlagCount;
					isOpenFlag = ReadUtils.read_TYPE_BOOL(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
