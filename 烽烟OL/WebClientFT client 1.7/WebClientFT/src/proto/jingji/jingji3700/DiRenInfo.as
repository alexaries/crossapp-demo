package proto.jingji.jingji3700 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class DiRenInfo extends Message implements IExternalizable {
		private var bId_:int;
		private var hasBId_:Boolean = false;
		public function get hasBId():Boolean {
			return hasBId_;
		}
		public function set bId(value:int):void {
			hasBId_ = true;
			bId_ = value;
		}
		public function get bId():int {
			return bId_;
		}
		private var bName_:String;
		public function get hasBName():Boolean {
			return null != bName_;
		}
		public function set bName(value:String):void {
			bName_ = value;
		}
		public function get bName():String {
			return bName_;
		}
		private var bLevel_:int;
		private var hasBLevel_:Boolean = false;
		public function get hasBLevel():Boolean {
			return hasBLevel_;
		}
		public function set bLevel(value:int):void {
			hasBLevel_ = true;
			bLevel_ = value;
		}
		public function get bLevel():int {
			return bLevel_;
		}
		private var bRank_:int;
		private var hasBRank_:Boolean = false;
		public function get hasBRank():Boolean {
			return hasBRank_;
		}
		public function set bRank(value:int):void {
			hasBRank_ = true;
			bRank_ = value;
		}
		public function get bRank():int {
			return bRank_;
		}
		private var profession_:int;
		private var hasProfession_:Boolean = false;
		public function get hasProfession():Boolean {
			return hasProfession_;
		}
		public function set profession(value:int):void {
			hasProfession_ = true;
			profession_ = value;
		}
		public function get profession():int {
			return profession_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasBId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, bId);
			}
			if (hasBName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, bName);
			}
			if (hasBLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, bLevel);
			}
			if (hasBRank) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, bRank);
			}
			if (hasProfession) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, profession);
			}
		}
		public function readExternal(input:IDataInput):void {
			var bIdCount:uint = 0;
			var bNameCount:uint = 0;
			var bLevelCount:uint = 0;
			var bRankCount:uint = 0;
			var professionCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (bIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++bIdCount;
					bId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (bNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++bNameCount;
					bName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (bLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++bLevelCount;
					bLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (bRankCount != 0) {
						throw new IOError('Bad data format.');
					}
					++bRankCount;
					bRank = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (professionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++professionCount;
					profession = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
