package proto.tavern.tavern3500 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class TavernWoWInfo extends Message implements IExternalizable {
		private var wSkill_:String;
		public function get hasWSkill():Boolean {
			return null != wSkill_;
		}
		public function set wSkill(value:String):void {
			wSkill_ = value;
		}
		public function get wSkill():String {
			return wSkill_;
		}
		private var wTexing_:String;
		public function get hasWTexing():Boolean {
			return null != wTexing_;
		}
		public function set wTexing(value:String):void {
			wTexing_ = value;
		}
		public function get wTexing():String {
			return wTexing_;
		}
		private var wLiliang_:int;
		private var hasWLiliang_:Boolean = false;
		public function get hasWLiliang():Boolean {
			return hasWLiliang_;
		}
		public function set wLiliang(value:int):void {
			hasWLiliang_ = true;
			wLiliang_ = value;
		}
		public function get wLiliang():int {
			return wLiliang_;
		}
		private var wZhili_:int;
		private var hasWZhili_:Boolean = false;
		public function get hasWZhili():Boolean {
			return hasWZhili_;
		}
		public function set wZhili(value:int):void {
			hasWZhili_ = true;
			wZhili_ = value;
		}
		public function get wZhili():int {
			return wZhili_;
		}
		private var wNaili_:int;
		private var hasWNaili_:Boolean = false;
		public function get hasWNaili():Boolean {
			return hasWNaili_;
		}
		public function set wNaili(value:int):void {
			hasWNaili_ = true;
			wNaili_ = value;
		}
		public function get wNaili():int {
			return wNaili_;
		}
		private var wMinjie_:int;
		private var hasWMinjie_:Boolean = false;
		public function get hasWMinjie():Boolean {
			return hasWMinjie_;
		}
		public function set wMinjie(value:int):void {
			hasWMinjie_ = true;
			wMinjie_ = value;
		}
		public function get wMinjie():int {
			return wMinjie_;
		}
		private var wWugong_:int;
		private var hasWWugong_:Boolean = false;
		public function get hasWWugong():Boolean {
			return hasWWugong_;
		}
		public function set wWugong(value:int):void {
			hasWWugong_ = true;
			wWugong_ = value;
		}
		public function get wWugong():int {
			return wWugong_;
		}
		private var wMogong_:int;
		private var hasWMogong_:Boolean = false;
		public function get hasWMogong():Boolean {
			return hasWMogong_;
		}
		public function set wMogong(value:int):void {
			hasWMogong_ = true;
			wMogong_ = value;
		}
		public function get wMogong():int {
			return wMogong_;
		}
		private var wGongsu_:int;
		private var hasWGongsu_:Boolean = false;
		public function get hasWGongsu():Boolean {
			return hasWGongsu_;
		}
		public function set wGongsu(value:int):void {
			hasWGongsu_ = true;
			wGongsu_ = value;
		}
		public function get wGongsu():int {
			return wGongsu_;
		}
		private var wBaoji_:int;
		private var hasWBaoji_:Boolean = false;
		public function get hasWBaoji():Boolean {
			return hasWBaoji_;
		}
		public function set wBaoji(value:int):void {
			hasWBaoji_ = true;
			wBaoji_ = value;
		}
		public function get wBaoji():int {
			return wBaoji_;
		}
		private var wWufang_:int;
		private var hasWWufang_:Boolean = false;
		public function get hasWWufang():Boolean {
			return hasWWufang_;
		}
		public function set wWufang(value:int):void {
			hasWWufang_ = true;
			wWufang_ = value;
		}
		public function get wWufang():int {
			return wWufang_;
		}
		private var wMofang_:int;
		private var hasWMofang_:Boolean = false;
		public function get hasWMofang():Boolean {
			return hasWMofang_;
		}
		public function set wMofang(value:int):void {
			hasWMofang_ = true;
			wMofang_ = value;
		}
		public function get wMofang():int {
			return wMofang_;
		}
		private var wMingzhong_:int;
		private var hasWMingzhong_:Boolean = false;
		public function get hasWMingzhong():Boolean {
			return hasWMingzhong_;
		}
		public function set wMingzhong(value:int):void {
			hasWMingzhong_ = true;
			wMingzhong_ = value;
		}
		public function get wMingzhong():int {
			return wMingzhong_;
		}
		private var wShanbi_:int;
		private var hasWShanbi_:Boolean = false;
		public function get hasWShanbi():Boolean {
			return hasWShanbi_;
		}
		public function set wShanbi(value:int):void {
			hasWShanbi_ = true;
			wShanbi_ = value;
		}
		public function get wShanbi():int {
			return wShanbi_;
		}
		private var wKaobao_:int;
		private var hasWKaobao_:Boolean = false;
		public function get hasWKaobao():Boolean {
			return hasWKaobao_;
		}
		public function set wKaobao(value:int):void {
			hasWKaobao_ = true;
			wKaobao_ = value;
		}
		public function get wKaobao():int {
			return wKaobao_;
		}
		private var wGuyongzhi_:int;
		private var hasWGuyongzhi_:Boolean = false;
		public function get hasWGuyongzhi():Boolean {
			return hasWGuyongzhi_;
		}
		public function set wGuyongzhi(value:int):void {
			hasWGuyongzhi_ = true;
			wGuyongzhi_ = value;
		}
		public function get wGuyongzhi():int {
			return wGuyongzhi_;
		}
		private var wName_:String;
		public function get hasWName():Boolean {
			return null != wName_;
		}
		public function set wName(value:String):void {
			wName_ = value;
		}
		public function get wName():String {
			return wName_;
		}
		private var wGuYongJinBi_:int;
		private var hasWGuYongJinBi_:Boolean = false;
		public function get hasWGuYongJinBi():Boolean {
			return hasWGuYongJinBi_;
		}
		public function set wGuYongJinBi(value:int):void {
			hasWGuYongJinBi_ = true;
			wGuYongJinBi_ = value;
		}
		public function get wGuYongJinBi():int {
			return wGuYongJinBi_;
		}
		private var wGuYongXingYunZhi_:int;
		private var hasWGuYongXingYunZhi_:Boolean = false;
		public function get hasWGuYongXingYunZhi():Boolean {
			return hasWGuYongXingYunZhi_;
		}
		public function set wGuYongXingYunZhi(value:int):void {
			hasWGuYongXingYunZhi_ = true;
			wGuYongXingYunZhi_ = value;
		}
		public function get wGuYongXingYunZhi():int {
			return wGuYongXingYunZhi_;
		}
		private var id_:int;
		private var hasId_:Boolean = false;
		public function get hasId():Boolean {
			return hasId_;
		}
		public function set id(value:int):void {
			hasId_ = true;
			id_ = value;
		}
		public function get id():int {
			return id_;
		}
		private var color_:int;
		private var hasColor_:Boolean = false;
		public function get hasColor():Boolean {
			return hasColor_;
		}
		public function set color(value:int):void {
			hasColor_ = true;
			color_ = value;
		}
		public function get color():int {
			return color_;
		}
		private var type_:int;
		private var hasType_:Boolean = false;
		public function get hasType():Boolean {
			return hasType_;
		}
		public function set type(value:int):void {
			hasType_ = true;
			type_ = value;
		}
		public function get type():int {
			return type_;
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
		private var level_:int;
		private var hasLevel_:Boolean = false;
		public function get hasLevel():Boolean {
			return hasLevel_;
		}
		public function set level(value:int):void {
			hasLevel_ = true;
			level_ = value;
		}
		public function get level():int {
			return level_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasWSkill) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, wSkill);
			}
			if (hasWTexing) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, wTexing);
			}
			if (hasWLiliang) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, wLiliang);
			}
			if (hasWZhili) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, wZhili);
			}
			if (hasWNaili) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, wNaili);
			}
			if (hasWMinjie) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, wMinjie);
			}
			if (hasWWugong) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, wWugong);
			}
			if (hasWMogong) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, wMogong);
			}
			if (hasWGongsu) {
				WriteUtils.writeTag(output, WireType.VARINT, 9);
				WriteUtils.write_TYPE_INT32(output, wGongsu);
			}
			if (hasWBaoji) {
				WriteUtils.writeTag(output, WireType.VARINT, 10);
				WriteUtils.write_TYPE_INT32(output, wBaoji);
			}
			if (hasWWufang) {
				WriteUtils.writeTag(output, WireType.VARINT, 11);
				WriteUtils.write_TYPE_INT32(output, wWufang);
			}
			if (hasWMofang) {
				WriteUtils.writeTag(output, WireType.VARINT, 12);
				WriteUtils.write_TYPE_INT32(output, wMofang);
			}
			if (hasWMingzhong) {
				WriteUtils.writeTag(output, WireType.VARINT, 13);
				WriteUtils.write_TYPE_INT32(output, wMingzhong);
			}
			if (hasWShanbi) {
				WriteUtils.writeTag(output, WireType.VARINT, 14);
				WriteUtils.write_TYPE_INT32(output, wShanbi);
			}
			if (hasWKaobao) {
				WriteUtils.writeTag(output, WireType.VARINT, 15);
				WriteUtils.write_TYPE_INT32(output, wKaobao);
			}
			if (hasWGuyongzhi) {
				WriteUtils.writeTag(output, WireType.VARINT, 16);
				WriteUtils.write_TYPE_INT32(output, wGuyongzhi);
			}
			if (hasWName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 17);
				WriteUtils.write_TYPE_STRING(output, wName);
			}
			if (hasWGuYongJinBi) {
				WriteUtils.writeTag(output, WireType.VARINT, 18);
				WriteUtils.write_TYPE_INT32(output, wGuYongJinBi);
			}
			if (hasWGuYongXingYunZhi) {
				WriteUtils.writeTag(output, WireType.VARINT, 19);
				WriteUtils.write_TYPE_INT32(output, wGuYongXingYunZhi);
			}
			if (hasId) {
				WriteUtils.writeTag(output, WireType.VARINT, 20);
				WriteUtils.write_TYPE_INT32(output, id);
			}
			if (hasColor) {
				WriteUtils.writeTag(output, WireType.VARINT, 21);
				WriteUtils.write_TYPE_INT32(output, color);
			}
			if (hasType) {
				WriteUtils.writeTag(output, WireType.VARINT, 22);
				WriteUtils.write_TYPE_INT32(output, type);
			}
			if (hasIcon) {
				WriteUtils.writeTag(output, WireType.VARINT, 23);
				WriteUtils.write_TYPE_INT32(output, icon);
			}
			if (hasLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 24);
				WriteUtils.write_TYPE_INT32(output, level);
			}
		}
		public function readExternal(input:IDataInput):void {
			var wSkillCount:uint = 0;
			var wTexingCount:uint = 0;
			var wLiliangCount:uint = 0;
			var wZhiliCount:uint = 0;
			var wNailiCount:uint = 0;
			var wMinjieCount:uint = 0;
			var wWugongCount:uint = 0;
			var wMogongCount:uint = 0;
			var wGongsuCount:uint = 0;
			var wBaojiCount:uint = 0;
			var wWufangCount:uint = 0;
			var wMofangCount:uint = 0;
			var wMingzhongCount:uint = 0;
			var wShanbiCount:uint = 0;
			var wKaobaoCount:uint = 0;
			var wGuyongzhiCount:uint = 0;
			var wNameCount:uint = 0;
			var wGuYongJinBiCount:uint = 0;
			var wGuYongXingYunZhiCount:uint = 0;
			var idCount:uint = 0;
			var colorCount:uint = 0;
			var typeCount:uint = 0;
			var iconCount:uint = 0;
			var levelCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (wSkillCount != 0) {
						throw new IOError('Bad data format.');
					}
					++wSkillCount;
					wSkill = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (wTexingCount != 0) {
						throw new IOError('Bad data format.');
					}
					++wTexingCount;
					wTexing = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (wLiliangCount != 0) {
						throw new IOError('Bad data format.');
					}
					++wLiliangCount;
					wLiliang = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (wZhiliCount != 0) {
						throw new IOError('Bad data format.');
					}
					++wZhiliCount;
					wZhili = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (wNailiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++wNailiCount;
					wNaili = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (wMinjieCount != 0) {
						throw new IOError('Bad data format.');
					}
					++wMinjieCount;
					wMinjie = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (wWugongCount != 0) {
						throw new IOError('Bad data format.');
					}
					++wWugongCount;
					wWugong = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (wMogongCount != 0) {
						throw new IOError('Bad data format.');
					}
					++wMogongCount;
					wMogong = ReadUtils.read_TYPE_INT32(input);
					break;
				case 9:
					if (wGongsuCount != 0) {
						throw new IOError('Bad data format.');
					}
					++wGongsuCount;
					wGongsu = ReadUtils.read_TYPE_INT32(input);
					break;
				case 10:
					if (wBaojiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++wBaojiCount;
					wBaoji = ReadUtils.read_TYPE_INT32(input);
					break;
				case 11:
					if (wWufangCount != 0) {
						throw new IOError('Bad data format.');
					}
					++wWufangCount;
					wWufang = ReadUtils.read_TYPE_INT32(input);
					break;
				case 12:
					if (wMofangCount != 0) {
						throw new IOError('Bad data format.');
					}
					++wMofangCount;
					wMofang = ReadUtils.read_TYPE_INT32(input);
					break;
				case 13:
					if (wMingzhongCount != 0) {
						throw new IOError('Bad data format.');
					}
					++wMingzhongCount;
					wMingzhong = ReadUtils.read_TYPE_INT32(input);
					break;
				case 14:
					if (wShanbiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++wShanbiCount;
					wShanbi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 15:
					if (wKaobaoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++wKaobaoCount;
					wKaobao = ReadUtils.read_TYPE_INT32(input);
					break;
				case 16:
					if (wGuyongzhiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++wGuyongzhiCount;
					wGuyongzhi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 17:
					if (wNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++wNameCount;
					wName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 18:
					if (wGuYongJinBiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++wGuYongJinBiCount;
					wGuYongJinBi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 19:
					if (wGuYongXingYunZhiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++wGuYongXingYunZhiCount;
					wGuYongXingYunZhi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 20:
					if (idCount != 0) {
						throw new IOError('Bad data format.');
					}
					++idCount;
					id = ReadUtils.read_TYPE_INT32(input);
					break;
				case 21:
					if (colorCount != 0) {
						throw new IOError('Bad data format.');
					}
					++colorCount;
					color = ReadUtils.read_TYPE_INT32(input);
					break;
				case 22:
					if (typeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++typeCount;
					type = ReadUtils.read_TYPE_INT32(input);
					break;
				case 23:
					if (iconCount != 0) {
						throw new IOError('Bad data format.');
					}
					++iconCount;
					icon = ReadUtils.read_TYPE_INT32(input);
					break;
				case 24:
					if (levelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++levelCount;
					level = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
