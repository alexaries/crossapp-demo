package proto.battle.battle705 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.battle.battle705.cardsInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class responseData extends Message implements IExternalizable {
		[ArrayElementType("proto.battle.battle705.cardsInfo")]
		public var card:Array = [];
		public function writeExternal(output:IDataOutput):void {
			for (var cardIndex:uint = 0; cardIndex < card.length; ++cardIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, card[cardIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					card.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.battle.battle705.cardsInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
