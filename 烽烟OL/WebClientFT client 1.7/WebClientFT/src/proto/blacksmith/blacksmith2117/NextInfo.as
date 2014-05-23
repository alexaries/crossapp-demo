package proto.blacksmith.blacksmith2117 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class NextInfo extends Message implements IExternalizable {
		private var itemId_:int;
		private var hasItemId_:Boolean = false;
		public function get hasItemId():Boolean {
			return hasItemId_;
		}
		public function set itemId(value:int):void {
			hasItemId_ = true;
			itemId_ = value;
		}
		public function get itemId():int {
			return itemId_;
		}
		private var strEff_:String;
		public function get hasStrEff():Boolean {
			return null != strEff_;
		}
		public function set strEff(value:String):void {
			strEff_ = value;
		}
		public function get strEff():String {
			return strEff_;
		}
		private var effValue_:String;
		public function get hasEffValue():Boolean {
			return null != effValue_;
		}
		public function set effValue(value:String):void {
			effValue_ = value;
		}
		public function get effValue():String {
			return effValue_;
		}
		private var reqCoin_:int;
		private var hasReqCoin_:Boolean = false;
		public function get hasReqCoin():Boolean {
			return hasReqCoin_;
		}
		public function set reqCoin(value:int):void {
			hasReqCoin_ = true;
			reqCoin_ = value;
		}
		public function get reqCoin():int {
			return reqCoin_;
		}
		private var mubanid_:int;
		private var hasMubanid_:Boolean = false;
		public function get hasMubanid():Boolean {
			return hasMubanid_;
		}
		public function set mubanid(value:int):void {
			hasMubanid_ = true;
			mubanid_ = value;
		}
		public function get mubanid():int {
			return mubanid_;
		}
		private var qhlevel_:int;
		private var hasQhlevel_:Boolean = false;
		public function get hasQhlevel():Boolean {
			return hasQhlevel_;
		}
		public function set qhlevel(value:int):void {
			hasQhlevel_ = true;
			qhlevel_ = value;
		}
		public function get qhlevel():int {
			return qhlevel_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasItemId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, itemId);
			}
			if (hasStrEff) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, strEff);
			}
			if (hasEffValue) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, effValue);
			}
			if (hasReqCoin) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, reqCoin);
			}
			if (hasMubanid) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, mubanid);
			}
			if (hasQhlevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, qhlevel);
			}
		}
		public function readExternal(input:IDataInput):void {
			var itemIdCount:uint = 0;
			var strEffCount:uint = 0;
			var effValueCount:uint = 0;
			var reqCoinCount:uint = 0;
			var mubanidCount:uint = 0;
			var qhlevelCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (itemIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemIdCount;
					itemId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (strEffCount != 0) {
						throw new IOError('Bad data format.');
					}
					++strEffCount;
					strEff = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (effValueCount != 0) {
						throw new IOError('Bad data format.');
					}
					++effValueCount;
					effValue = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (reqCoinCount != 0) {
						throw new IOError('Bad data format.');
					}
					++reqCoinCount;
					reqCoin = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (mubanidCount != 0) {
						throw new IOError('Bad data format.');
					}
					++mubanidCount;
					mubanid = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (qhlevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++qhlevelCount;
					qhlevel = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
