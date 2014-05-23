package proto.scene.scene605 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.scene.scene605.Portal;
	import proto.scene.scene605.NPC;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class EnterSceneMessage extends Message implements IExternalizable {
		public var sceneId:int;
		public var resourceId:int;
		public var sceneType:int;
		public var scenename:String;
		[ArrayElementType("proto.scene.scene605.NPC")]
		public var npclist:Array = [];
		[ArrayElementType("proto.scene.scene605.Portal")]
		public var portals:Array = [];
		private var corpsName_:String;
		public function get hasCorpsName():Boolean {
			return null != corpsName_;
		}
		public function set corpsName(value:String):void {
			corpsName_ = value;
		}
		public function get corpsName():String {
			return corpsName_;
		}
		private var rewardCorpsName_:String;
		public function get hasRewardCorpsName():Boolean {
			return null != rewardCorpsName_;
		}
		public function set rewardCorpsName(value:String):void {
			rewardCorpsName_ = value;
		}
		public function get rewardCorpsName():String {
			return rewardCorpsName_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, sceneId);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, resourceId);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, sceneType);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
			WriteUtils.write_TYPE_STRING(output, scenename);
			for (var npclistIndex:uint = 0; npclistIndex < npclist.length; ++npclistIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_MESSAGE(output, npclist[npclistIndex]);
			}
			for (var portalsIndex:uint = 0; portalsIndex < portals.length; ++portalsIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_MESSAGE(output, portals[portalsIndex]);
			}
			if (hasCorpsName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
				WriteUtils.write_TYPE_STRING(output, corpsName);
			}
			if (hasRewardCorpsName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 8);
				WriteUtils.write_TYPE_STRING(output, rewardCorpsName);
			}
		}
		public function readExternal(input:IDataInput):void {
			var sceneIdCount:uint = 0;
			var resourceIdCount:uint = 0;
			var sceneTypeCount:uint = 0;
			var scenenameCount:uint = 0;
			var corpsNameCount:uint = 0;
			var rewardCorpsNameCount:uint = 0;
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
					if (resourceIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++resourceIdCount;
					resourceId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (sceneTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sceneTypeCount;
					sceneType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (scenenameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++scenenameCount;
					scenename = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					npclist.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.scene.scene605.NPC));
					break;
				case 6:
					portals.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.scene.scene605.Portal));
					break;
				case 7:
					if (corpsNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++corpsNameCount;
					corpsName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 8:
					if (rewardCorpsNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++rewardCorpsNameCount;
					rewardCorpsName = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (sceneIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (resourceIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (sceneTypeCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (scenenameCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
