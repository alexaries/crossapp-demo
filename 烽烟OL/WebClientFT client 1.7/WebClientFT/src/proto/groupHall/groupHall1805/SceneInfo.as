package proto.groupHall.groupHall1805 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.groupHall.groupHall1805.MonsterInfo;
	import proto.groupHall.groupHall1805.DropItemInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class SceneInfo extends Message implements IExternalizable {
		private var sceneResId_:int;
		private var hasSceneResId_:Boolean = false;
		public function get hasSceneResId():Boolean {
			return hasSceneResId_;
		}
		public function set sceneResId(value:int):void {
			hasSceneResId_ = true;
			sceneResId_ = value;
		}
		public function get sceneResId():int {
			return sceneResId_;
		}
		private var name_:String;
		public function get hasName():Boolean {
			return null != name_;
		}
		public function set name(value:String):void {
			name_ = value;
		}
		public function get name():String {
			return name_;
		}
		[ArrayElementType("proto.groupHall.groupHall1805.MonsterInfo")]
		public var monsterInfo:Array = [];
		[ArrayElementType("proto.groupHall.groupHall1805.DropItemInfo")]
		public var dropItemInfo:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasSceneResId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, sceneResId);
			}
			if (hasName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, name);
			}
			for (var monsterInfoIndex:uint = 0; monsterInfoIndex < monsterInfo.length; ++monsterInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, monsterInfo[monsterInfoIndex]);
			}
			for (var dropItemInfoIndex:uint = 0; dropItemInfoIndex < dropItemInfo.length; ++dropItemInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_MESSAGE(output, dropItemInfo[dropItemInfoIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var sceneResIdCount:uint = 0;
			var nameCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (sceneResIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sceneResIdCount;
					sceneResId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (nameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nameCount;
					name = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					monsterInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.groupHall.groupHall1805.MonsterInfo));
					break;
				case 4:
					dropItemInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.groupHall.groupHall1805.DropItemInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
