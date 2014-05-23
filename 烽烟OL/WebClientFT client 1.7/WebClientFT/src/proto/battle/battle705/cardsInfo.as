package proto.battle.battle705 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.battle.battle705.ItemInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class cardsInfo extends Message implements IExternalizable {
		private var cardId_:int;
		private var hasCardId_:Boolean = false;
		public function get hasCardId():Boolean {
			return hasCardId_;
		}
		public function set cardId(value:int):void {
			hasCardId_ = true;
			cardId_ = value;
		}
		public function get cardId():int {
			return cardId_;
		}
		private var coinBounds_:int;
		private var hasCoinBounds_:Boolean = false;
		public function get hasCoinBounds():Boolean {
			return hasCoinBounds_;
		}
		public function set coinBounds(value:int):void {
			hasCoinBounds_ = true;
			coinBounds_ = value;
		}
		public function get coinBounds():int {
			return coinBounds_;
		}
		private var itemBound_:proto.battle.battle705.ItemInfo;
		public function get hasItemBound():Boolean {
			return null != itemBound_;
		}
		public function set itemBound(value:proto.battle.battle705.ItemInfo):void {
			itemBound_ = value;
		}
		public function get itemBound():proto.battle.battle705.ItemInfo {
			return itemBound_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasCardId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, cardId);
			}
			if (hasCoinBounds) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, coinBounds);
			}
			if (hasItemBound) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, itemBound);
			}
		}
		public function readExternal(input:IDataInput):void {
			var cardIdCount:uint = 0;
			var coinBoundsCount:uint = 0;
			var itemBoundCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (cardIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++cardIdCount;
					cardId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (coinBoundsCount != 0) {
						throw new IOError('Bad data format.');
					}
					++coinBoundsCount;
					coinBounds = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (itemBoundCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemBoundCount;
					itemBound = new proto.battle.battle705.ItemInfo;
					ReadUtils.read_TYPE_MESSAGE(input, itemBound);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
