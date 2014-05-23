package proto.scene.scene605 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class NPC extends Message implements IExternalizable {
		private var npcId_:int;
		private var hasNpcId_:Boolean = false;
		public function get hasNpcId():Boolean {
			return hasNpcId_;
		}
		public function set npcId(value:int):void {
			hasNpcId_ = true;
			npcId_ = value;
		}
		public function get npcId():int {
			return npcId_;
		}
		private var npcName_:String;
		public function get hasNpcName():Boolean {
			return null != npcName_;
		}
		public function set npcName(value:String):void {
			npcName_ = value;
		}
		public function get npcName():String {
			return npcName_;
		}
		private var resourceId_:int;
		private var hasResourceId_:Boolean = false;
		public function get hasResourceId():Boolean {
			return hasResourceId_;
		}
		public function set resourceId(value:int):void {
			hasResourceId_ = true;
			resourceId_ = value;
		}
		public function get resourceId():int {
			return resourceId_;
		}
		private var funcType_:int;
		private var hasFuncType_:Boolean = false;
		public function get hasFuncType():Boolean {
			return hasFuncType_;
		}
		public function set funcType(value:int):void {
			hasFuncType_ = true;
			funcType_ = value;
		}
		public function get funcType():int {
			return funcType_;
		}
		private var positionX_:int;
		private var hasPositionX_:Boolean = false;
		public function get hasPositionX():Boolean {
			return hasPositionX_;
		}
		public function set positionX(value:int):void {
			hasPositionX_ = true;
			positionX_ = value;
		}
		public function get positionX():int {
			return positionX_;
		}
		private var positionY_:int;
		private var hasPositionY_:Boolean = false;
		public function get hasPositionY():Boolean {
			return hasPositionY_;
		}
		public function set positionY(value:int):void {
			hasPositionY_ = true;
			positionY_ = value;
		}
		public function get positionY():int {
			return positionY_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasNpcId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, npcId);
			}
			if (hasNpcName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, npcName);
			}
			if (hasResourceId) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, resourceId);
			}
			if (hasFuncType) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, funcType);
			}
			if (hasPositionX) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, positionX);
			}
			if (hasPositionY) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, positionY);
			}
		}
		public function readExternal(input:IDataInput):void {
			var npcIdCount:uint = 0;
			var npcNameCount:uint = 0;
			var resourceIdCount:uint = 0;
			var funcTypeCount:uint = 0;
			var positionXCount:uint = 0;
			var positionYCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (npcIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++npcIdCount;
					npcId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (npcNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++npcNameCount;
					npcName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (resourceIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++resourceIdCount;
					resourceId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (funcTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++funcTypeCount;
					funcType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (positionXCount != 0) {
						throw new IOError('Bad data format.');
					}
					++positionXCount;
					positionX = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (positionYCount != 0) {
						throw new IOError('Bad data format.');
					}
					++positionYCount;
					positionY = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
