package proto.scene.scene610 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class SceneEntityMoveNotify extends Message implements IExternalizable {
		public var entityid:int;
		public var targetPosx:int;
		public var targetPosy:int;
		private var sourcePosx_:int;
		private var hasSourcePosx_:Boolean = false;
		public function get hasSourcePosx():Boolean {
			return hasSourcePosx_;
		}
		public function set sourcePosx(value:int):void {
			hasSourcePosx_ = true;
			sourcePosx_ = value;
		}
		public function get sourcePosx():int {
			return sourcePosx_;
		}
		private var sourcePosy_:int;
		private var hasSourcePosy_:Boolean = false;
		public function get hasSourcePosy():Boolean {
			return hasSourcePosy_;
		}
		public function set sourcePosy(value:int):void {
			hasSourcePosy_ = true;
			sourcePosy_ = value;
		}
		public function get sourcePosy():int {
			return sourcePosy_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, entityid);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, targetPosx);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, targetPosy);
			if (hasSourcePosx) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, sourcePosx);
			}
			if (hasSourcePosy) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, sourcePosy);
			}
		}
		public function readExternal(input:IDataInput):void {
			var entityidCount:uint = 0;
			var targetPosxCount:uint = 0;
			var targetPosyCount:uint = 0;
			var sourcePosxCount:uint = 0;
			var sourcePosyCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (entityidCount != 0) {
						throw new IOError('Bad data format.');
					}
					++entityidCount;
					entityid = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (targetPosxCount != 0) {
						throw new IOError('Bad data format.');
					}
					++targetPosxCount;
					targetPosx = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (targetPosyCount != 0) {
						throw new IOError('Bad data format.');
					}
					++targetPosyCount;
					targetPosy = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (sourcePosxCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sourcePosxCount;
					sourcePosx = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (sourcePosyCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sourcePosyCount;
					sourcePosy = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (entityidCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (targetPosxCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (targetPosyCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
