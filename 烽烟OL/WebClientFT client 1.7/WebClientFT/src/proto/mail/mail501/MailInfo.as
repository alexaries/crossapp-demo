package proto.mail.mail501 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class MailInfo extends Message implements IExternalizable {
		private var mailId_:int;
		private var hasMailId_:Boolean = false;
		public function get hasMailId():Boolean {
			return hasMailId_;
		}
		public function set mailId(value:int):void {
			hasMailId_ = true;
			mailId_ = value;
		}
		public function get mailId():int {
			return mailId_;
		}
		private var mailState_:int;
		private var hasMailState_:Boolean = false;
		public function get hasMailState():Boolean {
			return hasMailState_;
		}
		public function set mailState(value:int):void {
			hasMailState_ = true;
			mailState_ = value;
		}
		public function get mailState():int {
			return mailState_;
		}
		private var mailFromType_:int;
		private var hasMailFromType_:Boolean = false;
		public function get hasMailFromType():Boolean {
			return hasMailFromType_;
		}
		public function set mailFromType(value:int):void {
			hasMailFromType_ = true;
			mailFromType_ = value;
		}
		public function get mailFromType():int {
			return mailFromType_;
		}
		private var mailTitle_:String;
		public function get hasMailTitle():Boolean {
			return null != mailTitle_;
		}
		public function set mailTitle(value:String):void {
			mailTitle_ = value;
		}
		public function get mailTitle():String {
			return mailTitle_;
		}
		private var mialSendTime_:String;
		public function get hasMialSendTime():Boolean {
			return null != mialSendTime_;
		}
		public function set mialSendTime(value:String):void {
			mialSendTime_ = value;
		}
		public function get mialSendTime():String {
			return mialSendTime_;
		}
		private var outline_:String;
		public function get hasOutline():Boolean {
			return null != outline_;
		}
		public function set outline(value:String):void {
			outline_ = value;
		}
		public function get outline():String {
			return outline_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasMailId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, mailId);
			}
			if (hasMailState) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, mailState);
			}
			if (hasMailFromType) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, mailFromType);
			}
			if (hasMailTitle) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, mailTitle);
			}
			if (hasMialSendTime) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_STRING(output, mialSendTime);
			}
			if (hasOutline) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_STRING(output, outline);
			}
		}
		public function readExternal(input:IDataInput):void {
			var mailIdCount:uint = 0;
			var mailStateCount:uint = 0;
			var mailFromTypeCount:uint = 0;
			var mailTitleCount:uint = 0;
			var mialSendTimeCount:uint = 0;
			var outlineCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (mailIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++mailIdCount;
					mailId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (mailStateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++mailStateCount;
					mailState = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (mailFromTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++mailFromTypeCount;
					mailFromType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (mailTitleCount != 0) {
						throw new IOError('Bad data format.');
					}
					++mailTitleCount;
					mailTitle = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (mialSendTimeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++mialSendTimeCount;
					mialSendTime = ReadUtils.read_TYPE_STRING(input);
					break;
				case 6:
					if (outlineCount != 0) {
						throw new IOError('Bad data format.');
					}
					++outlineCount;
					outline = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
