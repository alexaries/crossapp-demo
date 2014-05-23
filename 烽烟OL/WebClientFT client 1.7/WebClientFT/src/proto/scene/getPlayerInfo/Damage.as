package proto.scene.getPlayerInfo {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class Damage extends Message implements IExternalizable {
		private var maxDamage_:Number;
		private var hasMaxDamage_:Boolean = false;
		public function get hasMaxDamage():Boolean {
			return hasMaxDamage_;
		}
		public function set maxDamage(value:Number):void {
			hasMaxDamage_ = true;
			maxDamage_ = value;
		}
		public function get maxDamage():Number {
			return maxDamage_;
		}
		private var minDamage_:Number;
		private var hasMinDamage_:Boolean = false;
		public function get hasMinDamage():Boolean {
			return hasMinDamage_;
		}
		public function set minDamage(value:Number):void {
			hasMinDamage_ = true;
			minDamage_ = value;
		}
		public function get minDamage():Number {
			return minDamage_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasMaxDamage) {
				WriteUtils.writeTag(output, WireType.FIXED_32_BIT, 1);
				WriteUtils.write_TYPE_FLOAT(output, maxDamage);
			}
			if (hasMinDamage) {
				WriteUtils.writeTag(output, WireType.FIXED_32_BIT, 2);
				WriteUtils.write_TYPE_FLOAT(output, minDamage);
			}
		}
		public function readExternal(input:IDataInput):void {
			var maxDamageCount:uint = 0;
			var minDamageCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (maxDamageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxDamageCount;
					maxDamage = ReadUtils.read_TYPE_FLOAT(input);
					break;
				case 2:
					if (minDamageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++minDamageCount;
					minDamage = ReadUtils.read_TYPE_FLOAT(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
