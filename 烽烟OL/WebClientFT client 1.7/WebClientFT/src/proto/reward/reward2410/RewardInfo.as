package proto.reward.reward2410 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.ItemsInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class RewardInfo extends Message implements IExternalizable {
		private var rewardDes_:String;
		public function get hasRewardDes():Boolean {
			return null != rewardDes_;
		}
		public function set rewardDes(value:String):void {
			rewardDes_ = value;
		}
		public function get rewardDes():String {
			return rewardDes_;
		}
		private var gold_:int;
		private var hasGold_:Boolean = false;
		public function get hasGold():Boolean {
			return hasGold_;
		}
		public function set gold(value:int):void {
			hasGold_ = true;
			gold_ = value;
		}
		public function get gold():int {
			return gold_;
		}
		private var zuan_:int;
		private var hasZuan_:Boolean = false;
		public function get hasZuan():Boolean {
			return hasZuan_;
		}
		public function set zuan(value:int):void {
			hasZuan_ = true;
			zuan_ = value;
		}
		public function get zuan():int {
			return zuan_;
		}
		private var tili_:int;
		private var hasTili_:Boolean = false;
		public function get hasTili():Boolean {
			return hasTili_;
		}
		public function set tili(value:int):void {
			hasTili_ = true;
			tili_ = value;
		}
		public function get tili():int {
			return tili_;
		}
		[ArrayElementType("proto.ItemsInfo")]
		public var itemInfo:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasRewardDes) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, rewardDes);
			}
			if (hasGold) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, gold);
			}
			if (hasZuan) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, zuan);
			}
			if (hasTili) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, tili);
			}
			for (var itemInfoIndex:uint = 0; itemInfoIndex < itemInfo.length; ++itemInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_MESSAGE(output, itemInfo[itemInfoIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var rewardDesCount:uint = 0;
			var goldCount:uint = 0;
			var zuanCount:uint = 0;
			var tiliCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (rewardDesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++rewardDesCount;
					rewardDes = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (goldCount != 0) {
						throw new IOError('Bad data format.');
					}
					++goldCount;
					gold = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (zuanCount != 0) {
						throw new IOError('Bad data format.');
					}
					++zuanCount;
					zuan = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (tiliCount != 0) {
						throw new IOError('Bad data format.');
					}
					++tiliCount;
					tili = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					itemInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.ItemsInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
