package proto.mail.mail505 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class MailInfo extends Message implements IExternalizable {
		private var mailIdResponse_:int;
		private var hasMailIdResponse_:Boolean = false;
		public function get hasMailIdResponse():Boolean {
			return hasMailIdResponse_;
		}
		public function set mailIdResponse(value:int):void {
			hasMailIdResponse_ = true;
			mailIdResponse_ = value;
		}
		public function get mailIdResponse():int {
			return mailIdResponse_;
		}
		private var mailFrom_:String;
		public function get hasMailFrom():Boolean {
			return null != mailFrom_;
		}
		public function set mailFrom(value:String):void {
			mailFrom_ = value;
		}
		public function get mailFrom():String {
			return mailFrom_;
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
		private var mailContent_:String;
		public function get hasMailContent():Boolean {
			return null != mailContent_;
		}
		public function set mailContent(value:String):void {
			mailContent_ = value;
		}
		public function get mailContent():String {
			return mailContent_;
		}
		private var mailType_:int;
		private var hasMailType_:Boolean = false;
		public function get hasMailType():Boolean {
			return hasMailType_;
		}
		public function set mailType(value:int):void {
			hasMailType_ = true;
			mailType_ = value;
		}
		public function get mailType():int {
			return mailType_;
		}
		private var mailDate_:String;
		public function get hasMailDate():Boolean {
			return null != mailDate_;
		}
		public function set mailDate(value:String):void {
			mailDate_ = value;
		}
		public function get mailDate():String {
			return mailDate_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasMailIdResponse) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, mailIdResponse);
			}
			if (hasMailFrom) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, mailFrom);
			}
			if (hasMailTitle) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, mailTitle);
			}
			if (hasMailContent) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, mailContent);
			}
			if (hasMailType) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, mailType);
			}
			if (hasMailDate) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_STRING(output, mailDate);
			}
		}
		public function readExternal(input:IDataInput):void {
			var mailIdResponseCount:uint = 0;
			var mailFromCount:uint = 0;
			var mailTitleCount:uint = 0;
			var mailContentCount:uint = 0;
			var mailTypeCount:uint = 0;
			var mailDateCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (mailIdResponseCount != 0) {
						throw new IOError('Bad data format.');
					}
					++mailIdResponseCount;
					mailIdResponse = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (mailFromCount != 0) {
						throw new IOError('Bad data format.');
					}
					++mailFromCount;
					mailFrom = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (mailTitleCount != 0) {
						throw new IOError('Bad data format.');
					}
					++mailTitleCount;
					mailTitle = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (mailContentCount != 0) {
						throw new IOError('Bad data format.');
					}
					++mailContentCount;
					mailContent = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (mailTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++mailTypeCount;
					mailType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (mailDateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++mailDateCount;
					mailDate = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
