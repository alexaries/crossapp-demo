package proto.guaji.guaji3203 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class RewardInfo extends Message implements IExternalizable {
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
		private var icon_:int;
		private var hasIcon_:Boolean = false;
		public function get hasIcon():Boolean {
			return hasIcon_;
		}
		public function set icon(value:int):void {
			hasIcon_ = true;
			icon_ = value;
		}
		public function get icon():int {
			return icon_;
		}
		private var stack_:int;
		private var hasStack_:Boolean = false;
		public function get hasStack():Boolean {
			return hasStack_;
		}
		public function set stack(value:int):void {
			hasStack_ = true;
			stack_ = value;
		}
		public function get stack():int {
			return stack_;
		}
		private var type_:int;
		private var hasType_:Boolean = false;
		public function get hasType():Boolean {
			return hasType_;
		}
		public function set type(value:int):void {
			hasType_ = true;
			type_ = value;
		}
		public function get type():int {
			return type_;
		}
		private var rewardType_:int;
		private var hasRewardType_:Boolean = false;
		public function get hasRewardType():Boolean {
			return hasRewardType_;
		}
		public function set rewardType(value:int):void {
			hasRewardType_ = true;
			rewardType_ = value;
		}
		public function get rewardType():int {
			return rewardType_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasItemId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, itemId);
			}
			if (hasIcon) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, icon);
			}
			if (hasStack) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, stack);
			}
			if (hasType) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, type);
			}
			if (hasRewardType) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, rewardType);
			}
		}
		public function readExternal(input:IDataInput):void {
			var itemIdCount:uint = 0;
			var iconCount:uint = 0;
			var stackCount:uint = 0;
			var typeCount:uint = 0;
			var rewardTypeCount:uint = 0;
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
					if (iconCount != 0) {
						throw new IOError('Bad data format.');
					}
					++iconCount;
					icon = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (stackCount != 0) {
						throw new IOError('Bad data format.');
					}
					++stackCount;
					stack = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (typeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++typeCount;
					type = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (rewardTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++rewardTypeCount;
					rewardType = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
