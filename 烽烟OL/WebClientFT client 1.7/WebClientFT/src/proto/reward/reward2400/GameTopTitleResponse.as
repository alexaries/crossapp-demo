package proto.reward.reward2400 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.reward.reward2400.AnouInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GameTopTitleResponse extends Message implements IExternalizable {
		private var message_:String;
		public function get hasMessage():Boolean {
			return null != message_;
		}
		public function set message(value:String):void {
			message_ = value;
		}
		public function get message():String {
			return message_;
		}
		[ArrayElementType("proto.reward.reward2400.AnouInfo")]
		public var anouInfo:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasMessage) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, message);
			}
			for (var anouInfoIndex:uint = 0; anouInfoIndex < anouInfo.length; ++anouInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_MESSAGE(output, anouInfo[anouInfoIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var messageCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (messageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++messageCount;
					message = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					anouInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.reward.reward2400.AnouInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
