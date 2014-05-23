package proto.map {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.map.InstanceMapInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class InstanceMapInfosResponse extends Message implements IExternalizable {
		public var result:Boolean;
		public var selfColor:int;
		[ArrayElementType("proto.map.InstanceMapInfo")]
		public var infos:Array = [];
		private var message_:String;
		public function get hasMessage():Boolean {
			return null != message_;
		}
		public function set message(value:String):void {
			message_ = value;
		}
		public function get message():String {
			return message_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_BOOL(output, result);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, selfColor);
			for (var infosIndex:uint = 0; infosIndex < infos.length; ++infosIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, infos[infosIndex]);
			}
			if (hasMessage) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, message);
			}
		}
		public function readExternal(input:IDataInput):void {
			var resultCount:uint = 0;
			var selfColorCount:uint = 0;
			var messageCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (resultCount != 0) {
						throw new IOError('Bad data format.');
					}
					++resultCount;
					result = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 2:
					if (selfColorCount != 0) {
						throw new IOError('Bad data format.');
					}
					++selfColorCount;
					selfColor = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					infos.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.map.InstanceMapInfo));
					break;
				case 4:
					if (messageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++messageCount;
					message = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (resultCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (selfColorCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
