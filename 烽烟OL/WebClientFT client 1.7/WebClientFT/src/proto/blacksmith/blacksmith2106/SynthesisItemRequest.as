package proto.blacksmith.blacksmith2106 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class SynthesisItemRequest extends Message implements IExternalizable {
		public var id:int;
		private var autoBuy_:Boolean;
		private var hasAutoBuy_:Boolean = false;
		public function get hasAutoBuy():Boolean {
			return hasAutoBuy_;
		}
		public function set autoBuy(value:Boolean):void {
			hasAutoBuy_ = true;
			autoBuy_ = value;
		}
		public function get autoBuy():Boolean {
			return autoBuy_;
		}
		private var autoSyntesis_:Boolean;
		private var hasAutoSyntesis_:Boolean = false;
		public function get hasAutoSyntesis():Boolean {
			return hasAutoSyntesis_;
		}
		public function set autoSyntesis(value:Boolean):void {
			hasAutoSyntesis_ = true;
			autoSyntesis_ = value;
		}
		public function get autoSyntesis():Boolean {
			return autoSyntesis_;
		}
		private var syntesisTarget_:int;
		private var hasSyntesisTarget_:Boolean = false;
		public function get hasSyntesisTarget():Boolean {
			return hasSyntesisTarget_;
		}
		public function set syntesisTarget(value:int):void {
			hasSyntesisTarget_ = true;
			syntesisTarget_ = value;
		}
		public function get syntesisTarget():int {
			return syntesisTarget_;
		}
		private var pos1ItemId_:int;
		private var hasPos1ItemId_:Boolean = false;
		public function get hasPos1ItemId():Boolean {
			return hasPos1ItemId_;
		}
		public function set pos1ItemId(value:int):void {
			hasPos1ItemId_ = true;
			pos1ItemId_ = value;
		}
		public function get pos1ItemId():int {
			return pos1ItemId_;
		}
		private var pos2ItemId_:int;
		private var hasPos2ItemId_:Boolean = false;
		public function get hasPos2ItemId():Boolean {
			return hasPos2ItemId_;
		}
		public function set pos2ItemId(value:int):void {
			hasPos2ItemId_ = true;
			pos2ItemId_ = value;
		}
		public function get pos2ItemId():int {
			return pos2ItemId_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			if (hasAutoBuy) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_BOOL(output, autoBuy);
			}
			if (hasAutoSyntesis) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_BOOL(output, autoSyntesis);
			}
			if (hasSyntesisTarget) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, syntesisTarget);
			}
			if (hasPos1ItemId) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, pos1ItemId);
			}
			if (hasPos2ItemId) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, pos2ItemId);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var autoBuyCount:uint = 0;
			var autoSyntesisCount:uint = 0;
			var syntesisTargetCount:uint = 0;
			var pos1ItemIdCount:uint = 0;
			var pos2ItemIdCount:uint = 0;
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
					if (autoBuyCount != 0) {
						throw new IOError('Bad data format.');
					}
					++autoBuyCount;
					autoBuy = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 3:
					if (autoSyntesisCount != 0) {
						throw new IOError('Bad data format.');
					}
					++autoSyntesisCount;
					autoSyntesis = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 4:
					if (syntesisTargetCount != 0) {
						throw new IOError('Bad data format.');
					}
					++syntesisTargetCount;
					syntesisTarget = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (pos1ItemIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++pos1ItemIdCount;
					pos1ItemId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (pos2ItemIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++pos2ItemIdCount;
					pos2ItemId = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
