package proto.commission.commission1206 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class CommissionSellItemRequest extends Message implements IExternalizable {
		public var id:int;
		public var itemId:int;
		public var commissionType:int;
		public var sellNum:int;
		public var commissionTime:int;
		public var setTop:Boolean;
		public var muchType:int;
		public var muchNum:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, itemId);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, commissionType);
			WriteUtils.writeTag(output, WireType.VARINT, 4);
			WriteUtils.write_TYPE_INT32(output, sellNum);
			WriteUtils.writeTag(output, WireType.VARINT, 5);
			WriteUtils.write_TYPE_INT32(output, commissionTime);
			WriteUtils.writeTag(output, WireType.VARINT, 6);
			WriteUtils.write_TYPE_BOOL(output, setTop);
			WriteUtils.writeTag(output, WireType.VARINT, 7);
			WriteUtils.write_TYPE_INT32(output, muchType);
			WriteUtils.writeTag(output, WireType.VARINT, 8);
			WriteUtils.write_TYPE_INT32(output, muchNum);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var itemIdCount:uint = 0;
			var commissionTypeCount:uint = 0;
			var sellNumCount:uint = 0;
			var commissionTimeCount:uint = 0;
			var setTopCount:uint = 0;
			var muchTypeCount:uint = 0;
			var muchNumCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (idCount != 0) {
						throw new IOError('Bad data format.');
					}
					++idCount;
					id = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (itemIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemIdCount;
					itemId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (commissionTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++commissionTypeCount;
					commissionType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (sellNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sellNumCount;
					sellNum = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (commissionTimeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++commissionTimeCount;
					commissionTime = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (setTopCount != 0) {
						throw new IOError('Bad data format.');
					}
					++setTopCount;
					setTop = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 7:
					if (muchTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++muchTypeCount;
					muchType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (muchNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++muchNumCount;
					muchNum = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (itemIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (commissionTypeCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (sellNumCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (commissionTimeCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (setTopCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (muchTypeCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (muchNumCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
