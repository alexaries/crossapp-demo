package proto.groupBattle.groupBattle4406 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.groupBattle.groupBattle4406.GroupMember;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GroupInfo extends Message implements IExternalizable {
		private var groupName_:String;
		public function get hasGroupName():Boolean {
			return null != groupName_;
		}
		public function set groupName(value:String):void {
			groupName_ = value;
		}
		public function get groupName():String {
			return groupName_;
		}
		private var groupCount_:int;
		private var hasGroupCount_:Boolean = false;
		public function get hasGroupCount():Boolean {
			return hasGroupCount_;
		}
		public function set groupCount(value:int):void {
			hasGroupCount_ = true;
			groupCount_ = value;
		}
		public function get groupCount():int {
			return groupCount_;
		}
		private var icon_:int;
		private var hasIcon_:Boolean = false;
		public function get hasIcon():Boolean {
			return hasIcon_;
		}
		public function set icon(value:int):void {
			hasIcon_ = true;
			icon_ = value;
		}
		public function get icon():int {
			return icon_;
		}
		[ArrayElementType("proto.groupBattle.groupBattle4406.GroupMember")]
		public var groupMember:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasGroupName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, groupName);
			}
			if (hasGroupCount) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, groupCount);
			}
			if (hasIcon) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, icon);
			}
			for (var groupMemberIndex:uint = 0; groupMemberIndex < groupMember.length; ++groupMemberIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_MESSAGE(output, groupMember[groupMemberIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var groupNameCount:uint = 0;
			var groupCountCount:uint = 0;
			var iconCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (groupNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++groupNameCount;
					groupName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (groupCountCount != 0) {
						throw new IOError('Bad data format.');
					}
					++groupCountCount;
					groupCount = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (iconCount != 0) {
						throw new IOError('Bad data format.');
					}
					++iconCount;
					icon = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					groupMember.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.groupBattle.groupBattle4406.GroupMember));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
