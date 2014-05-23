package proto.blacksmith.blacksmith2115 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class PeiFangInfo extends Message implements IExternalizable {
		private var coinrequired_:int;
		private var hasCoinrequired_:Boolean = false;
		public function get hasCoinrequired():Boolean {
			return hasCoinrequired_;
		}
		public function set coinrequired(value:int):void {
			hasCoinrequired_ = true;
			coinrequired_ = value;
		}
		public function get coinrequired():int {
			return coinrequired_;
		}
		private var itemA_:int;
		private var hasItemA_:Boolean = false;
		public function get hasItemA():Boolean {
			return hasItemA_;
		}
		public function set itemA(value:int):void {
			hasItemA_ = true;
			itemA_ = value;
		}
		public function get itemA():int {
			return itemA_;
		}
		private var itemAcnt_:int;
		private var hasItemAcnt_:Boolean = false;
		public function get hasItemAcnt():Boolean {
			return hasItemAcnt_;
		}
		public function set itemAcnt(value:int):void {
			hasItemAcnt_ = true;
			itemAcnt_ = value;
		}
		public function get itemAcnt():int {
			return itemAcnt_;
		}
		private var itemAGoal_:int;
		private var hasItemAGoal_:Boolean = false;
		public function get hasItemAGoal():Boolean {
			return hasItemAGoal_;
		}
		public function set itemAGoal(value:int):void {
			hasItemAGoal_ = true;
			itemAGoal_ = value;
		}
		public function get itemAGoal():int {
			return itemAGoal_;
		}
		private var itemB_:int;
		private var hasItemB_:Boolean = false;
		public function get hasItemB():Boolean {
			return hasItemB_;
		}
		public function set itemB(value:int):void {
			hasItemB_ = true;
			itemB_ = value;
		}
		public function get itemB():int {
			return itemB_;
		}
		private var itemBcnt_:int;
		private var hasItemBcnt_:Boolean = false;
		public function get hasItemBcnt():Boolean {
			return hasItemBcnt_;
		}
		public function set itemBcnt(value:int):void {
			hasItemBcnt_ = true;
			itemBcnt_ = value;
		}
		public function get itemBcnt():int {
			return itemBcnt_;
		}
		private var itemBGoal_:int;
		private var hasItemBGoal_:Boolean = false;
		public function get hasItemBGoal():Boolean {
			return hasItemBGoal_;
		}
		public function set itemBGoal(value:int):void {
			hasItemBGoal_ = true;
			itemBGoal_ = value;
		}
		public function get itemBGoal():int {
			return itemBGoal_;
		}
		private var itemBound_:int;
		private var hasItemBound_:Boolean = false;
		public function get hasItemBound():Boolean {
			return hasItemBound_;
		}
		public function set itemBound(value:int):void {
			hasItemBound_ = true;
			itemBound_ = value;
		}
		public function get itemBound():int {
			return itemBound_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasCoinrequired) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, coinrequired);
			}
			if (hasItemA) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, itemA);
			}
			if (hasItemAcnt) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, itemAcnt);
			}
			if (hasItemAGoal) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, itemAGoal);
			}
			if (hasItemB) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, itemB);
			}
			if (hasItemBcnt) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, itemBcnt);
			}
			if (hasItemBGoal) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, itemBGoal);
			}
			if (hasItemBound) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, itemBound);
			}
		}
		public function readExternal(input:IDataInput):void {
			var coinrequiredCount:uint = 0;
			var itemACount:uint = 0;
			var itemAcntCount:uint = 0;
			var itemAGoalCount:uint = 0;
			var itemBCount:uint = 0;
			var itemBcntCount:uint = 0;
			var itemBGoalCount:uint = 0;
			var itemBoundCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (coinrequiredCount != 0) {
						throw new IOError('Bad data format.');
					}
					++coinrequiredCount;
					coinrequired = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (itemACount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemACount;
					itemA = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (itemAcntCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemAcntCount;
					itemAcnt = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (itemAGoalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemAGoalCount;
					itemAGoal = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (itemBCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemBCount;
					itemB = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (itemBcntCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemBcntCount;
					itemBcnt = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (itemBGoalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemBGoalCount;
					itemBGoal = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (itemBoundCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemBoundCount;
					itemBound = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
