package proto.pratice.getRestRoomInfo {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.pratice.getRestRoomInfo.List;
	import proto.pratice.getRestRoomInfo.Info;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class dataPacket extends Message implements IExternalizable {
		private var npcInfo_:proto.pratice.getRestRoomInfo.Info;
		public function get hasNpcInfo():Boolean {
			return null != npcInfo_;
		}
		public function set npcInfo(value:proto.pratice.getRestRoomInfo.Info):void {
			npcInfo_ = value;
		}
		public function get npcInfo():proto.pratice.getRestRoomInfo.Info {
			return npcInfo_;
		}
		private var countList_:proto.pratice.getRestRoomInfo.List;
		public function get hasCountList():Boolean {
			return null != countList_;
		}
		public function set countList(value:proto.pratice.getRestRoomInfo.List):void {
			countList_ = value;
		}
		public function get countList():proto.pratice.getRestRoomInfo.List {
			return countList_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasNpcInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, npcInfo);
			}
			if (hasCountList) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_MESSAGE(output, countList);
			}
		}
		public function readExternal(input:IDataInput):void {
			var npcInfoCount:uint = 0;
			var countListCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (npcInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++npcInfoCount;
					npcInfo = new proto.pratice.getRestRoomInfo.Info;
					ReadUtils.read_TYPE_MESSAGE(input, npcInfo);
					break;
				case 2:
					if (countListCount != 0) {
						throw new IOError('Bad data format.');
					}
					++countListCount;
					countList = new proto.pratice.getRestRoomInfo.List;
					ReadUtils.read_TYPE_MESSAGE(input, countList);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
