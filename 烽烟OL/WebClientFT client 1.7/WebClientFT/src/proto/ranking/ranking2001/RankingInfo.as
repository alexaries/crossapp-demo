package proto.ranking.ranking2001 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class RankingInfo extends Message implements IExternalizable {
		private var id_:int;
		private var hasId_:Boolean = false;
		public function get hasId():Boolean {
			return hasId_;
		}
		public function set id(value:int):void {
			hasId_ = true;
			id_ = value;
		}
		public function get id():int {
			return id_;
		}
		private var param1_:String;
		public function get hasParam1():Boolean {
			return null != param1_;
		}
		public function set param1(value:String):void {
			param1_ = value;
		}
		public function get param1():String {
			return param1_;
		}
		private var param2_:String;
		public function get hasParam2():Boolean {
			return null != param2_;
		}
		public function set param2(value:String):void {
			param2_ = value;
		}
		public function get param2():String {
			return param2_;
		}
		private var param3_:String;
		public function get hasParam3():Boolean {
			return null != param3_;
		}
		public function set param3(value:String):void {
			param3_ = value;
		}
		public function get param3():String {
			return param3_;
		}
		private var param4_:String;
		public function get hasParam4():Boolean {
			return null != param4_;
		}
		public function set param4(value:String):void {
			param4_ = value;
		}
		public function get param4():String {
			return param4_;
		}
		private var param5_:String;
		public function get hasParam5():Boolean {
			return null != param5_;
		}
		public function set param5(value:String):void {
			param5_ = value;
		}
		public function get param5():String {
			return param5_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, id);
			}
			if (hasParam1) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, param1);
			}
			if (hasParam2) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, param2);
			}
			if (hasParam3) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, param3);
			}
			if (hasParam4) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_STRING(output, param4);
			}
			if (hasParam5) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_STRING(output, param5);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var param1Count:uint = 0;
			var param2Count:uint = 0;
			var param3Count:uint = 0;
			var param4Count:uint = 0;
			var param5Count:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (idCount != 0) {
						throw new IOError('Bad data format.');
					}
					++idCount;
					id = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (param1Count != 0) {
						throw new IOError('Bad data format.');
					}
					++param1Count;
					param1 = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (param2Count != 0) {
						throw new IOError('Bad data format.');
					}
					++param2Count;
					param2 = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (param3Count != 0) {
						throw new IOError('Bad data format.');
					}
					++param3Count;
					param3 = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (param4Count != 0) {
						throw new IOError('Bad data format.');
					}
					++param4Count;
					param4 = ReadUtils.read_TYPE_STRING(input);
					break;
				case 6:
					if (param5Count != 0) {
						throw new IOError('Bad data format.');
					}
					++param5Count;
					param5 = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
