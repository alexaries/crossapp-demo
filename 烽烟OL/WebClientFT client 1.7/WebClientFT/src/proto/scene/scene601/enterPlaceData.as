package proto.scene.scene601 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class enterPlaceData extends Message implements IExternalizable {
		private var placeId_:int;
		private var hasPlaceId_:Boolean = false;
		public function get hasPlaceId():Boolean {
			return hasPlaceId_;
		}
		public function set placeId(value:int):void {
			hasPlaceId_ = true;
			placeId_ = value;
		}
		public function get placeId():int {
			return placeId_;
		}
		private var isboos_:Boolean;
		private var hasIsboos_:Boolean = false;
		public function get hasIsboos():Boolean {
			return hasIsboos_;
		}
		public function set isboos(value:Boolean):void {
			hasIsboos_ = true;
			isboos_ = value;
		}
		public function get isboos():Boolean {
			return isboos_;
		}
		private var copySceneId_:int;
		private var hasCopySceneId_:Boolean = false;
		public function get hasCopySceneId():Boolean {
			return hasCopySceneId_;
		}
		public function set copySceneId(value:int):void {
			hasCopySceneId_ = true;
			copySceneId_ = value;
		}
		public function get copySceneId():int {
			return copySceneId_;
		}
		private var sceneType_:int;
		private var hasSceneType_:Boolean = false;
		public function get hasSceneType():Boolean {
			return hasSceneType_;
		}
		public function set sceneType(value:int):void {
			hasSceneType_ = true;
			sceneType_ = value;
		}
		public function get sceneType():int {
			return sceneType_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasPlaceId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, placeId);
			}
			if (hasIsboos) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_BOOL(output, isboos);
			}
			if (hasCopySceneId) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, copySceneId);
			}
			if (hasSceneType) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, sceneType);
			}
		}
		public function readExternal(input:IDataInput):void {
			var placeIdCount:uint = 0;
			var isboosCount:uint = 0;
			var copySceneIdCount:uint = 0;
			var sceneTypeCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (placeIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++placeIdCount;
					placeId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (isboosCount != 0) {
						throw new IOError('Bad data format.');
					}
					++isboosCount;
					isboos = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 3:
					if (copySceneIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++copySceneIdCount;
					copySceneId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (sceneTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sceneTypeCount;
					sceneType = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
