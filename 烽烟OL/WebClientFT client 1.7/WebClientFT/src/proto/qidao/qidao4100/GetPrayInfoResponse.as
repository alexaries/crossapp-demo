package proto.qidao.qidao4100 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GetPrayInfoResponse extends Message implements IExternalizable {
		private var result_:Boolean;
		private var hasResult_:Boolean = false;
		public function get hasResult():Boolean {
			return hasResult_;
		}
		public function set result(value:Boolean):void {
			hasResult_ = true;
			result_ = value;
		}
		public function get result():Boolean {
			return result_;
		}
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
		private var prayDes_:String;
		public function get hasPrayDes():Boolean {
			return null != prayDes_;
		}
		public function set prayDes(value:String):void {
			prayDes_ = value;
		}
		public function get prayDes():String {
			return prayDes_;
		}
		private var needDiamond_:int;
		private var hasNeedDiamond_:Boolean = false;
		public function get hasNeedDiamond():Boolean {
			return hasNeedDiamond_;
		}
		public function set needDiamond(value:int):void {
			hasNeedDiamond_ = true;
			needDiamond_ = value;
		}
		public function get needDiamond():int {
			return needDiamond_;
		}
		private var remainTimes_:int;
		private var hasRemainTimes_:Boolean = false;
		public function get hasRemainTimes():Boolean {
			return hasRemainTimes_;
		}
		public function set remainTimes(value:int):void {
			hasRemainTimes_ = true;
			remainTimes_ = value;
		}
		public function get remainTimes():int {
			return remainTimes_;
		}
		[ArrayElementType("String")]
		public var otherPrayMsg:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasResult) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_BOOL(output, result);
			}
			if (hasMessage) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, message);
			}
			if (hasPrayDes) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, prayDes);
			}
			if (hasNeedDiamond) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, needDiamond);
			}
			if (hasRemainTimes) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, remainTimes);
			}
			for (var otherPrayMsgIndex:uint = 0; otherPrayMsgIndex < otherPrayMsg.length; ++otherPrayMsgIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_STRING(output, otherPrayMsg[otherPrayMsgIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var resultCount:uint = 0;
			var messageCount:uint = 0;
			var prayDesCount:uint = 0;
			var needDiamondCount:uint = 0;
			var remainTimesCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (resultCount != 0) {
						throw new IOError('Bad data format.');
					}
					++resultCount;
					result = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 2:
					if (messageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++messageCount;
					message = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (prayDesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++prayDesCount;
					prayDes = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (needDiamondCount != 0) {
						throw new IOError('Bad data format.');
					}
					++needDiamondCount;
					needDiamond = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (remainTimesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++remainTimesCount;
					remainTimes = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					otherPrayMsg.push(ReadUtils.read_TYPE_STRING(input));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
