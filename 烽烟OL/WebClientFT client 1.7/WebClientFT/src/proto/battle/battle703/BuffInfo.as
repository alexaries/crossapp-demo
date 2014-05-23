package proto.battle.battle703 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class BuffInfo extends Message implements IExternalizable {
		private var buffId_:int;
		private var hasBuffId_:Boolean = false;
		public function get hasBuffId():Boolean {
			return hasBuffId_;
		}
		public function set buffId(value:int):void {
			hasBuffId_ = true;
			buffId_ = value;
		}
		public function get buffId():int {
			return buffId_;
		}
		private var buffLayerCount_:int;
		private var hasBuffLayerCount_:Boolean = false;
		public function get hasBuffLayerCount():Boolean {
			return hasBuffLayerCount_;
		}
		public function set buffLayerCount(value:int):void {
			hasBuffLayerCount_ = true;
			buffLayerCount_ = value;
		}
		public function get buffLayerCount():int {
			return buffLayerCount_;
		}
		private var buffRemainRoundCount_:int;
		private var hasBuffRemainRoundCount_:Boolean = false;
		public function get hasBuffRemainRoundCount():Boolean {
			return hasBuffRemainRoundCount_;
		}
		public function set buffRemainRoundCount(value:int):void {
			hasBuffRemainRoundCount_ = true;
			buffRemainRoundCount_ = value;
		}
		public function get buffRemainRoundCount():int {
			return buffRemainRoundCount_;
		}
		private var buffEffectId_:int;
		private var hasBuffEffectId_:Boolean = false;
		public function get hasBuffEffectId():Boolean {
			return hasBuffEffectId_;
		}
		public function set buffEffectId(value:int):void {
			hasBuffEffectId_ = true;
			buffEffectId_ = value;
		}
		public function get buffEffectId():int {
			return buffEffectId_;
		}
		private var buffIconId_:int;
		private var hasBuffIconId_:Boolean = false;
		public function get hasBuffIconId():Boolean {
			return hasBuffIconId_;
		}
		public function set buffIconId(value:int):void {
			hasBuffIconId_ = true;
			buffIconId_ = value;
		}
		public function get buffIconId():int {
			return buffIconId_;
		}
		private var buffName_:String;
		public function get hasBuffName():Boolean {
			return null != buffName_;
		}
		public function set buffName(value:String):void {
			buffName_ = value;
		}
		public function get buffName():String {
			return buffName_;
		}
		private var bufDes_:String;
		public function get hasBufDes():Boolean {
			return null != bufDes_;
		}
		public function set bufDes(value:String):void {
			bufDes_ = value;
		}
		public function get bufDes():String {
			return bufDes_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasBuffId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, buffId);
			}
			if (hasBuffLayerCount) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, buffLayerCount);
			}
			if (hasBuffRemainRoundCount) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, buffRemainRoundCount);
			}
			if (hasBuffEffectId) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, buffEffectId);
			}
			if (hasBuffIconId) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, buffIconId);
			}
			if (hasBuffName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_STRING(output, buffName);
			}
			if (hasBufDes) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
				WriteUtils.write_TYPE_STRING(output, bufDes);
			}
		}
		public function readExternal(input:IDataInput):void {
			var buffIdCount:uint = 0;
			var buffLayerCountCount:uint = 0;
			var buffRemainRoundCountCount:uint = 0;
			var buffEffectIdCount:uint = 0;
			var buffIconIdCount:uint = 0;
			var buffNameCount:uint = 0;
			var bufDesCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (buffIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++buffIdCount;
					buffId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (buffLayerCountCount != 0) {
						throw new IOError('Bad data format.');
					}
					++buffLayerCountCount;
					buffLayerCount = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (buffRemainRoundCountCount != 0) {
						throw new IOError('Bad data format.');
					}
					++buffRemainRoundCountCount;
					buffRemainRoundCount = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (buffEffectIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++buffEffectIdCount;
					buffEffectId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (buffIconIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++buffIconIdCount;
					buffIconId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (buffNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++buffNameCount;
					buffName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 7:
					if (bufDesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++bufDesCount;
					bufDes = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
