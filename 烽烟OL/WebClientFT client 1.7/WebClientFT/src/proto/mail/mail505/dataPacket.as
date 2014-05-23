package proto.mail.mail505 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.mail.mail505.MailInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class dataPacket extends Message implements IExternalizable {
		private var mailinfo_:proto.mail.mail505.MailInfo;
		public function get hasMailinfo():Boolean {
			return null != mailinfo_;
		}
		public function set mailinfo(value:proto.mail.mail505.MailInfo):void {
			mailinfo_ = value;
		}
		public function get mailinfo():proto.mail.mail505.MailInfo {
			return mailinfo_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasMailinfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, mailinfo);
			}
		}
		public function readExternal(input:IDataInput):void {
			var mailinfoCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (mailinfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++mailinfoCount;
					mailinfo = new proto.mail.mail505.MailInfo;
					ReadUtils.read_TYPE_MESSAGE(input, mailinfo);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
