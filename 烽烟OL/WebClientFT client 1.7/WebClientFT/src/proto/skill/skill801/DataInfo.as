package proto.skill.skill801 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.skill.skill801.SkillInfoList;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class DataInfo extends Message implements IExternalizable {
		[ArrayElementType("proto.skill.skill801.SkillInfoList")]
		public var skillInfoList:Array = [];
		public function writeExternal(output:IDataOutput):void {
			for (var skillInfoListIndex:uint = 0; skillInfoListIndex < skillInfoList.length; ++skillInfoListIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, skillInfoList[skillInfoListIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					skillInfoList.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.skill.skill801.SkillInfoList));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
