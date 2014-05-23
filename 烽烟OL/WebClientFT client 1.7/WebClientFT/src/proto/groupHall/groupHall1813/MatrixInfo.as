package proto.groupHall.groupHall1813 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.groupHall.groupHall1813.FrontEye;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class MatrixInfo extends Message implements IExternalizable {
		private var matrixId_:int;
		private var hasMatrixId_:Boolean = false;
		public function get hasMatrixId():Boolean {
			return hasMatrixId_;
		}
		public function set matrixId(value:int):void {
			hasMatrixId_ = true;
			matrixId_ = value;
		}
		public function get matrixId():int {
			return matrixId_;
		}
		private var matrixname_:String;
		public function get hasMatrixname():Boolean {
			return null != matrixname_;
		}
		public function set matrixname(value:String):void {
			matrixname_ = value;
		}
		public function get matrixname():String {
			return matrixname_;
		}
		private var description_:String;
		public function get hasDescription():Boolean {
			return null != description_;
		}
		public function set description(value:String):void {
			description_ = value;
		}
		public function get description():String {
			return description_;
		}
		private var noweffect_:int;
		private var hasNoweffect_:Boolean = false;
		public function get hasNoweffect():Boolean {
			return hasNoweffect_;
		}
		public function set noweffect(value:int):void {
			hasNoweffect_ = true;
			noweffect_ = value;
		}
		public function get noweffect():int {
			return noweffect_;
		}
		[ArrayElementType("proto.groupHall.groupHall1813.FrontEye")]
		public var frontEyeList:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasMatrixId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, matrixId);
			}
			if (hasMatrixname) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, matrixname);
			}
			if (hasDescription) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, description);
			}
			if (hasNoweffect) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, noweffect);
			}
			for (var frontEyeListIndex:uint = 0; frontEyeListIndex < frontEyeList.length; ++frontEyeListIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_MESSAGE(output, frontEyeList[frontEyeListIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var matrixIdCount:uint = 0;
			var matrixnameCount:uint = 0;
			var descriptionCount:uint = 0;
			var noweffectCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (matrixIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++matrixIdCount;
					matrixId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (matrixnameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++matrixnameCount;
					matrixname = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (descriptionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++descriptionCount;
					description = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (noweffectCount != 0) {
						throw new IOError('Bad data format.');
					}
					++noweffectCount;
					noweffect = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					frontEyeList.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.groupHall.groupHall1813.FrontEye));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
