package proto.pet.pet2306 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.pet.pet2306.MatrixTitleInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class MatrixInfo extends Message implements IExternalizable {
		private var jwDes_:String;
		public function get hasJwDes():Boolean {
			return null != jwDes_;
		}
		public function set jwDes(value:String):void {
			jwDes_ = value;
		}
		public function get jwDes():String {
			return jwDes_;
		}
		private var curNum_:int;
		private var hasCurNum_:Boolean = false;
		public function get hasCurNum():Boolean {
			return hasCurNum_;
		}
		public function set curNum(value:int):void {
			hasCurNum_ = true;
			curNum_ = value;
		}
		public function get curNum():int {
			return curNum_;
		}
		private var maxNum_:int;
		private var hasMaxNum_:Boolean = false;
		public function get hasMaxNum():Boolean {
			return hasMaxNum_;
		}
		public function set maxNum(value:int):void {
			hasMaxNum_ = true;
			maxNum_ = value;
		}
		public function get maxNum():int {
			return maxNum_;
		}
		[ArrayElementType("proto.pet.pet2306.MatrixTitleInfo")]
		public var matrixTitleInfo:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasJwDes) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, jwDes);
			}
			if (hasCurNum) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, curNum);
			}
			if (hasMaxNum) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, maxNum);
			}
			for (var matrixTitleInfoIndex:uint = 0; matrixTitleInfoIndex < matrixTitleInfo.length; ++matrixTitleInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_MESSAGE(output, matrixTitleInfo[matrixTitleInfoIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var jwDesCount:uint = 0;
			var curNumCount:uint = 0;
			var maxNumCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (jwDesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++jwDesCount;
					jwDes = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (curNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curNumCount;
					curNum = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (maxNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxNumCount;
					maxNum = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					matrixTitleInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.pet.pet2306.MatrixTitleInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
