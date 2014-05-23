package proto.corps.corps1317 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class AppliListBaseInfo extends Message implements IExternalizable {
		private var memberliId_:int;
		private var hasMemberliId_:Boolean = false;
		public function get hasMemberliId():Boolean {
			return hasMemberliId_;
		}
		public function set memberliId(value:int):void {
			hasMemberliId_ = true;
			memberliId_ = value;
		}
		public function get memberliId():int {
			return memberliId_;
		}
		private var memberName_:String;
		public function get hasMemberName():Boolean {
			return null != memberName_;
		}
		public function set memberName(value:String):void {
			memberName_ = value;
		}
		public function get memberName():String {
			return memberName_;
		}
		private var memberLevel_:int;
		private var hasMemberLevel_:Boolean = false;
		public function get hasMemberLevel():Boolean {
			return hasMemberLevel_;
		}
		public function set memberLevel(value:int):void {
			hasMemberLevel_ = true;
			memberLevel_ = value;
		}
		public function get memberLevel():int {
			return memberLevel_;
		}
		private var memberProfession_:String;
		public function get hasMemberProfession():Boolean {
			return null != memberProfession_;
		}
		public function set memberProfession(value:String):void {
			memberProfession_ = value;
		}
		public function get memberProfession():String {
			return memberProfession_;
		}
		private var memberRank_:String;
		public function get hasMemberRank():Boolean {
			return null != memberRank_;
		}
		public function set memberRank(value:String):void {
			memberRank_ = value;
		}
		public function get memberRank():String {
			return memberRank_;
		}
		private var memberTime_:String;
		public function get hasMemberTime():Boolean {
			return null != memberTime_;
		}
		public function set memberTime(value:String):void {
			memberTime_ = value;
		}
		public function get memberTime():String {
			return memberTime_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasMemberliId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, memberliId);
			}
			if (hasMemberName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, memberName);
			}
			if (hasMemberLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, memberLevel);
			}
			if (hasMemberProfession) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, memberProfession);
			}
			if (hasMemberRank) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_STRING(output, memberRank);
			}
			if (hasMemberTime) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_STRING(output, memberTime);
			}
		}
		public function readExternal(input:IDataInput):void {
			var memberliIdCount:uint = 0;
			var memberNameCount:uint = 0;
			var memberLevelCount:uint = 0;
			var memberProfessionCount:uint = 0;
			var memberRankCount:uint = 0;
			var memberTimeCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (memberliIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++memberliIdCount;
					memberliId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (memberNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++memberNameCount;
					memberName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (memberLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++memberLevelCount;
					memberLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (memberProfessionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++memberProfessionCount;
					memberProfession = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (memberRankCount != 0) {
						throw new IOError('Bad data format.');
					}
					++memberRankCount;
					memberRank = ReadUtils.read_TYPE_STRING(input);
					break;
				case 6:
					if (memberTimeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++memberTimeCount;
					memberTime = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
