package proto.scene.scene602 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.scene.scene602.characterPosition;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class pushSceneMessage extends Message implements IExternalizable {
		public var sceneId:int;
		[ArrayElementType("proto.scene.scene602.characterPosition")]
		public var PlayerPosition:Array = [];
		[ArrayElementType("proto.scene.scene602.characterPosition")]
		public var MonsterPosition:Array = [];
		[ArrayElementType("proto.scene.scene602.characterPosition")]
		public var petInfo:Array = [];
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, sceneId);
			for (var PlayerPositionIndex:uint = 0; PlayerPositionIndex < PlayerPosition.length; ++PlayerPositionIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_MESSAGE(output, PlayerPosition[PlayerPositionIndex]);
			}
			for (var MonsterPositionIndex:uint = 0; MonsterPositionIndex < MonsterPosition.length; ++MonsterPositionIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, MonsterPosition[MonsterPositionIndex]);
			}
			for (var petInfoIndex:uint = 0; petInfoIndex < petInfo.length; ++petInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_MESSAGE(output, petInfo[petInfoIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var sceneIdCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (sceneIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sceneIdCount;
					sceneId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					PlayerPosition.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.scene.scene602.characterPosition));
					break;
				case 3:
					MonsterPosition.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.scene.scene602.characterPosition));
					break;
				case 4:
					petInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.scene.scene602.characterPosition));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (sceneIdCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
