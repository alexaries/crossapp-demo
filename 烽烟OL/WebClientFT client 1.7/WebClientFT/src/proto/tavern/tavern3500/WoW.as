package proto.tavern.tavern3500 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.tavern.tavern3500.Schedule;
	import proto.tavern.tavern3500.TavernWoWInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class WoW extends Message implements IExternalizable {
		[ArrayElementType("proto.tavern.tavern3500.TavernWoWInfo")]
		public var wowInfo:Array = [];
		[ArrayElementType("proto.tavern.tavern3500.Schedule")]
		public var fashiPet:Array = [];
		[ArrayElementType("proto.tavern.tavern3500.Schedule")]
		public var zhanshiPet:Array = [];
		[ArrayElementType("proto.tavern.tavern3500.Schedule")]
		public var youxiaPet:Array = [];
		private var xingyunzhi_:int;
		private var hasXingyunzhi_:Boolean = false;
		public function get hasXingyunzhi():Boolean {
			return hasXingyunzhi_;
		}
		public function set xingyunzhi(value:int):void {
			hasXingyunzhi_ = true;
			xingyunzhi_ = value;
		}
		public function get xingyunzhi():int {
			return xingyunzhi_;
		}
		private var refreshTime_:int;
		private var hasRefreshTime_:Boolean = false;
		public function get hasRefreshTime():Boolean {
			return hasRefreshTime_;
		}
		public function set refreshTime(value:int):void {
			hasRefreshTime_ = true;
			refreshTime_ = value;
		}
		public function get refreshTime():int {
			return refreshTime_;
		}
		public var isClose:Boolean;
		private var shengYuCiShu_:int;
		private var hasShengYuCiShu_:Boolean = false;
		public function get hasShengYuCiShu():Boolean {
			return hasShengYuCiShu_;
		}
		public function set shengYuCiShu(value:int):void {
			hasShengYuCiShu_ = true;
			shengYuCiShu_ = value;
		}
		public function get shengYuCiShu():int {
			return shengYuCiShu_;
		}
		public function writeExternal(output:IDataOutput):void {
			for (var wowInfoIndex:uint = 0; wowInfoIndex < wowInfo.length; ++wowInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, wowInfo[wowInfoIndex]);
			}
			for (var fashiPetIndex:uint = 0; fashiPetIndex < fashiPet.length; ++fashiPetIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_MESSAGE(output, fashiPet[fashiPetIndex]);
			}
			for (var zhanshiPetIndex:uint = 0; zhanshiPetIndex < zhanshiPet.length; ++zhanshiPetIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, zhanshiPet[zhanshiPetIndex]);
			}
			for (var youxiaPetIndex:uint = 0; youxiaPetIndex < youxiaPet.length; ++youxiaPetIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_MESSAGE(output, youxiaPet[youxiaPetIndex]);
			}
			if (hasXingyunzhi) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, xingyunzhi);
			}
			if (hasRefreshTime) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, refreshTime);
			}
			WriteUtils.writeTag(output, WireType.VARINT, 7);
			WriteUtils.write_TYPE_BOOL(output, isClose);
			if (hasShengYuCiShu) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, shengYuCiShu);
			}
		}
		public function readExternal(input:IDataInput):void {
			var xingyunzhiCount:uint = 0;
			var refreshTimeCount:uint = 0;
			var isCloseCount:uint = 0;
			var shengYuCiShuCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					wowInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.tavern.tavern3500.TavernWoWInfo));
					break;
				case 2:
					fashiPet.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.tavern.tavern3500.Schedule));
					break;
				case 3:
					zhanshiPet.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.tavern.tavern3500.Schedule));
					break;
				case 4:
					youxiaPet.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.tavern.tavern3500.Schedule));
					break;
				case 5:
					if (xingyunzhiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++xingyunzhiCount;
					xingyunzhi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (refreshTimeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++refreshTimeCount;
					refreshTime = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (isCloseCount != 0) {
						throw new IOError('Bad data format.');
					}
					++isCloseCount;
					isClose = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 8:
					if (shengYuCiShuCount != 0) {
						throw new IOError('Bad data format.');
					}
					++shengYuCiShuCount;
					shengYuCiShu = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (isCloseCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
