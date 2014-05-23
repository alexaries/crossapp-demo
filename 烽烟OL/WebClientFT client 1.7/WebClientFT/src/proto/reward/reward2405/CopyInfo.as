package proto.reward.reward2405 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.reward.reward2405.ItemManInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class CopyInfo extends Message implements IExternalizable {
		private var cId_:int;
		private var hasCId_:Boolean = false;
		public function get hasCId():Boolean {
			return hasCId_;
		}
		public function set cId(value:int):void {
			hasCId_ = true;
			cId_ = value;
		}
		public function get cId():int {
			return cId_;
		}
		private var cName_:String;
		public function get hasCName():Boolean {
			return null != cName_;
		}
		public function set cName(value:String):void {
			cName_ = value;
		}
		public function get cName():String {
			return cName_;
		}
		private var liLiang_:int;
		private var hasLiLiang_:Boolean = false;
		public function get hasLiLiang():Boolean {
			return hasLiLiang_;
		}
		public function set liLiang(value:int):void {
			hasLiLiang_ = true;
			liLiang_ = value;
		}
		public function get liLiang():int {
			return liLiang_;
		}
		private var addLiLiang_:int;
		private var hasAddLiLiang_:Boolean = false;
		public function get hasAddLiLiang():Boolean {
			return hasAddLiLiang_;
		}
		public function set addLiLiang(value:int):void {
			hasAddLiLiang_ = true;
			addLiLiang_ = value;
		}
		public function get addLiLiang():int {
			return addLiLiang_;
		}
		private var minJie_:int;
		private var hasMinJie_:Boolean = false;
		public function get hasMinJie():Boolean {
			return hasMinJie_;
		}
		public function set minJie(value:int):void {
			hasMinJie_ = true;
			minJie_ = value;
		}
		public function get minJie():int {
			return minJie_;
		}
		private var addMinJie_:int;
		private var hasAddMinJie_:Boolean = false;
		public function get hasAddMinJie():Boolean {
			return hasAddMinJie_;
		}
		public function set addMinJie(value:int):void {
			hasAddMinJie_ = true;
			addMinJie_ = value;
		}
		public function get addMinJie():int {
			return addMinJie_;
		}
		private var zhiLi_:int;
		private var hasZhiLi_:Boolean = false;
		public function get hasZhiLi():Boolean {
			return hasZhiLi_;
		}
		public function set zhiLi(value:int):void {
			hasZhiLi_ = true;
			zhiLi_ = value;
		}
		public function get zhiLi():int {
			return zhiLi_;
		}
		private var addZhiLi_:int;
		private var hasAddZhiLi_:Boolean = false;
		public function get hasAddZhiLi():Boolean {
			return hasAddZhiLi_;
		}
		public function set addZhiLi(value:int):void {
			hasAddZhiLi_ = true;
			addZhiLi_ = value;
		}
		public function get addZhiLi():int {
			return addZhiLi_;
		}
		private var naiLi_:int;
		private var hasNaiLi_:Boolean = false;
		public function get hasNaiLi():Boolean {
			return hasNaiLi_;
		}
		public function set naiLi(value:int):void {
			hasNaiLi_ = true;
			naiLi_ = value;
		}
		public function get naiLi():int {
			return naiLi_;
		}
		private var addNaiLi_:int;
		private var hasAddNaiLi_:Boolean = false;
		public function get hasAddNaiLi():Boolean {
			return hasAddNaiLi_;
		}
		public function set addNaiLi(value:int):void {
			hasAddNaiLi_ = true;
			addNaiLi_ = value;
		}
		public function get addNaiLi():int {
			return addNaiLi_;
		}
		private var jiShen_:int;
		private var hasJiShen_:Boolean = false;
		public function get hasJiShen():Boolean {
			return hasJiShen_;
		}
		public function set jiShen(value:int):void {
			hasJiShen_ = true;
			jiShen_ = value;
		}
		public function get jiShen():int {
			return jiShen_;
		}
		private var addJiShen_:int;
		private var hasAddJiShen_:Boolean = false;
		public function get hasAddJiShen():Boolean {
			return hasAddJiShen_;
		}
		public function set addJiShen(value:int):void {
			hasAddJiShen_ = true;
			addJiShen_ = value;
		}
		public function get addJiShen():int {
			return addJiShen_;
		}
		private var wuGong_:int;
		private var hasWuGong_:Boolean = false;
		public function get hasWuGong():Boolean {
			return hasWuGong_;
		}
		public function set wuGong(value:int):void {
			hasWuGong_ = true;
			wuGong_ = value;
		}
		public function get wuGong():int {
			return wuGong_;
		}
		private var addWuGong_:int;
		private var hasAddWuGong_:Boolean = false;
		public function get hasAddWuGong():Boolean {
			return hasAddWuGong_;
		}
		public function set addWuGong(value:int):void {
			hasAddWuGong_ = true;
			addWuGong_ = value;
		}
		public function get addWuGong():int {
			return addWuGong_;
		}
		private var wuFang_:int;
		private var hasWuFang_:Boolean = false;
		public function get hasWuFang():Boolean {
			return hasWuFang_;
		}
		public function set wuFang(value:int):void {
			hasWuFang_ = true;
			wuFang_ = value;
		}
		public function get wuFang():int {
			return wuFang_;
		}
		private var addWuFang_:int;
		private var hasAddWuFang_:Boolean = false;
		public function get hasAddWuFang():Boolean {
			return hasAddWuFang_;
		}
		public function set addWuFang(value:int):void {
			hasAddWuFang_ = true;
			addWuFang_ = value;
		}
		public function get addWuFang():int {
			return addWuFang_;
		}
		private var moGong_:int;
		private var hasMoGong_:Boolean = false;
		public function get hasMoGong():Boolean {
			return hasMoGong_;
		}
		public function set moGong(value:int):void {
			hasMoGong_ = true;
			moGong_ = value;
		}
		public function get moGong():int {
			return moGong_;
		}
		private var addMoGong_:int;
		private var hasAddMoGong_:Boolean = false;
		public function get hasAddMoGong():Boolean {
			return hasAddMoGong_;
		}
		public function set addMoGong(value:int):void {
			hasAddMoGong_ = true;
			addMoGong_ = value;
		}
		public function get addMoGong():int {
			return addMoGong_;
		}
		private var moFang_:int;
		private var hasMoFang_:Boolean = false;
		public function get hasMoFang():Boolean {
			return hasMoFang_;
		}
		public function set moFang(value:int):void {
			hasMoFang_ = true;
			moFang_ = value;
		}
		public function get moFang():int {
			return moFang_;
		}
		private var addMoFang_:int;
		private var hasAddMoFang_:Boolean = false;
		public function get hasAddMoFang():Boolean {
			return hasAddMoFang_;
		}
		public function set addMoFang(value:int):void {
			hasAddMoFang_ = true;
			addMoFang_ = value;
		}
		public function get addMoFang():int {
			return addMoFang_;
		}
		private var gongSu_:int;
		private var hasGongSu_:Boolean = false;
		public function get hasGongSu():Boolean {
			return hasGongSu_;
		}
		public function set gongSu(value:int):void {
			hasGongSu_ = true;
			gongSu_ = value;
		}
		public function get gongSu():int {
			return gongSu_;
		}
		private var addGongSu_:int;
		private var hasAddGongSu_:Boolean = false;
		public function get hasAddGongSu():Boolean {
			return hasAddGongSu_;
		}
		public function set addGongSu(value:int):void {
			hasAddGongSu_ = true;
			addGongSu_ = value;
		}
		public function get addGongSu():int {
			return addGongSu_;
		}
		private var mingZhong_:int;
		private var hasMingZhong_:Boolean = false;
		public function get hasMingZhong():Boolean {
			return hasMingZhong_;
		}
		public function set mingZhong(value:int):void {
			hasMingZhong_ = true;
			mingZhong_ = value;
		}
		public function get mingZhong():int {
			return mingZhong_;
		}
		private var addMingZhong_:int;
		private var hasAddMingZhong_:Boolean = false;
		public function get hasAddMingZhong():Boolean {
			return hasAddMingZhong_;
		}
		public function set addMingZhong(value:int):void {
			hasAddMingZhong_ = true;
			addMingZhong_ = value;
		}
		public function get addMingZhong():int {
			return addMingZhong_;
		}
		private var baoJi_:int;
		private var hasBaoJi_:Boolean = false;
		public function get hasBaoJi():Boolean {
			return hasBaoJi_;
		}
		public function set baoJi(value:int):void {
			hasBaoJi_ = true;
			baoJi_ = value;
		}
		public function get baoJi():int {
			return baoJi_;
		}
		private var addBaoJi_:int;
		private var hasAddBaoJi_:Boolean = false;
		public function get hasAddBaoJi():Boolean {
			return hasAddBaoJi_;
		}
		public function set addBaoJi(value:int):void {
			hasAddBaoJi_ = true;
			addBaoJi_ = value;
		}
		public function get addBaoJi():int {
			return addBaoJi_;
		}
		private var shanBi_:int;
		private var hasShanBi_:Boolean = false;
		public function get hasShanBi():Boolean {
			return hasShanBi_;
		}
		public function set shanBi(value:int):void {
			hasShanBi_ = true;
			shanBi_ = value;
		}
		public function get shanBi():int {
			return shanBi_;
		}
		private var addShanBi_:int;
		private var hasAddShanBi_:Boolean = false;
		public function get hasAddShanBi():Boolean {
			return hasAddShanBi_;
		}
		public function set addShanBi(value:int):void {
			hasAddShanBi_ = true;
			addShanBi_ = value;
		}
		public function get addShanBi():int {
			return addShanBi_;
		}
		private var liliangInfo_:proto.reward.reward2405.ItemManInfo;
		public function get hasLiliangInfo():Boolean {
			return null != liliangInfo_;
		}
		public function set liliangInfo(value:proto.reward.reward2405.ItemManInfo):void {
			liliangInfo_ = value;
		}
		public function get liliangInfo():proto.reward.reward2405.ItemManInfo {
			return liliangInfo_;
		}
		private var minjieInfo_:proto.reward.reward2405.ItemManInfo;
		public function get hasMinjieInfo():Boolean {
			return null != minjieInfo_;
		}
		public function set minjieInfo(value:proto.reward.reward2405.ItemManInfo):void {
			minjieInfo_ = value;
		}
		public function get minjieInfo():proto.reward.reward2405.ItemManInfo {
			return minjieInfo_;
		}
		private var zhiliInfo_:proto.reward.reward2405.ItemManInfo;
		public function get hasZhiliInfo():Boolean {
			return null != zhiliInfo_;
		}
		public function set zhiliInfo(value:proto.reward.reward2405.ItemManInfo):void {
			zhiliInfo_ = value;
		}
		public function get zhiliInfo():proto.reward.reward2405.ItemManInfo {
			return zhiliInfo_;
		}
		private var nailiInfo_:proto.reward.reward2405.ItemManInfo;
		public function get hasNailiInfo():Boolean {
			return null != nailiInfo_;
		}
		public function set nailiInfo(value:proto.reward.reward2405.ItemManInfo):void {
			nailiInfo_ = value;
		}
		public function get nailiInfo():proto.reward.reward2405.ItemManInfo {
			return nailiInfo_;
		}
		private var jingshenInfo_:proto.reward.reward2405.ItemManInfo;
		public function get hasJingshenInfo():Boolean {
			return null != jingshenInfo_;
		}
		public function set jingshenInfo(value:proto.reward.reward2405.ItemManInfo):void {
			jingshenInfo_ = value;
		}
		public function get jingshenInfo():proto.reward.reward2405.ItemManInfo {
			return jingshenInfo_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasCId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, cId);
			}
			if (hasCName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, cName);
			}
			if (hasLiLiang) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, liLiang);
			}
			if (hasAddLiLiang) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, addLiLiang);
			}
			if (hasMinJie) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, minJie);
			}
			if (hasAddMinJie) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, addMinJie);
			}
			if (hasZhiLi) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, zhiLi);
			}
			if (hasAddZhiLi) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, addZhiLi);
			}
			if (hasNaiLi) {
				WriteUtils.writeTag(output, WireType.VARINT, 9);
				WriteUtils.write_TYPE_INT32(output, naiLi);
			}
			if (hasAddNaiLi) {
				WriteUtils.writeTag(output, WireType.VARINT, 10);
				WriteUtils.write_TYPE_INT32(output, addNaiLi);
			}
			if (hasJiShen) {
				WriteUtils.writeTag(output, WireType.VARINT, 11);
				WriteUtils.write_TYPE_INT32(output, jiShen);
			}
			if (hasAddJiShen) {
				WriteUtils.writeTag(output, WireType.VARINT, 12);
				WriteUtils.write_TYPE_INT32(output, addJiShen);
			}
			if (hasWuGong) {
				WriteUtils.writeTag(output, WireType.VARINT, 13);
				WriteUtils.write_TYPE_INT32(output, wuGong);
			}
			if (hasAddWuGong) {
				WriteUtils.writeTag(output, WireType.VARINT, 14);
				WriteUtils.write_TYPE_INT32(output, addWuGong);
			}
			if (hasWuFang) {
				WriteUtils.writeTag(output, WireType.VARINT, 15);
				WriteUtils.write_TYPE_INT32(output, wuFang);
			}
			if (hasAddWuFang) {
				WriteUtils.writeTag(output, WireType.VARINT, 16);
				WriteUtils.write_TYPE_INT32(output, addWuFang);
			}
			if (hasMoGong) {
				WriteUtils.writeTag(output, WireType.VARINT, 17);
				WriteUtils.write_TYPE_INT32(output, moGong);
			}
			if (hasAddMoGong) {
				WriteUtils.writeTag(output, WireType.VARINT, 18);
				WriteUtils.write_TYPE_INT32(output, addMoGong);
			}
			if (hasMoFang) {
				WriteUtils.writeTag(output, WireType.VARINT, 19);
				WriteUtils.write_TYPE_INT32(output, moFang);
			}
			if (hasAddMoFang) {
				WriteUtils.writeTag(output, WireType.VARINT, 20);
				WriteUtils.write_TYPE_INT32(output, addMoFang);
			}
			if (hasGongSu) {
				WriteUtils.writeTag(output, WireType.VARINT, 21);
				WriteUtils.write_TYPE_INT32(output, gongSu);
			}
			if (hasAddGongSu) {
				WriteUtils.writeTag(output, WireType.VARINT, 22);
				WriteUtils.write_TYPE_INT32(output, addGongSu);
			}
			if (hasMingZhong) {
				WriteUtils.writeTag(output, WireType.VARINT, 23);
				WriteUtils.write_TYPE_INT32(output, mingZhong);
			}
			if (hasAddMingZhong) {
				WriteUtils.writeTag(output, WireType.VARINT, 24);
				WriteUtils.write_TYPE_INT32(output, addMingZhong);
			}
			if (hasBaoJi) {
				WriteUtils.writeTag(output, WireType.VARINT, 25);
				WriteUtils.write_TYPE_INT32(output, baoJi);
			}
			if (hasAddBaoJi) {
				WriteUtils.writeTag(output, WireType.VARINT, 26);
				WriteUtils.write_TYPE_INT32(output, addBaoJi);
			}
			if (hasShanBi) {
				WriteUtils.writeTag(output, WireType.VARINT, 27);
				WriteUtils.write_TYPE_INT32(output, shanBi);
			}
			if (hasAddShanBi) {
				WriteUtils.writeTag(output, WireType.VARINT, 28);
				WriteUtils.write_TYPE_INT32(output, addShanBi);
			}
			if (hasLiliangInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 29);
				WriteUtils.write_TYPE_MESSAGE(output, liliangInfo);
			}
			if (hasMinjieInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 30);
				WriteUtils.write_TYPE_MESSAGE(output, minjieInfo);
			}
			if (hasZhiliInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 31);
				WriteUtils.write_TYPE_MESSAGE(output, zhiliInfo);
			}
			if (hasNailiInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 32);
				WriteUtils.write_TYPE_MESSAGE(output, nailiInfo);
			}
			if (hasJingshenInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 33);
				WriteUtils.write_TYPE_MESSAGE(output, jingshenInfo);
			}
		}
		public function readExternal(input:IDataInput):void {
			var cIdCount:uint = 0;
			var cNameCount:uint = 0;
			var liLiangCount:uint = 0;
			var addLiLiangCount:uint = 0;
			var minJieCount:uint = 0;
			var addMinJieCount:uint = 0;
			var zhiLiCount:uint = 0;
			var addZhiLiCount:uint = 0;
			var naiLiCount:uint = 0;
			var addNaiLiCount:uint = 0;
			var jiShenCount:uint = 0;
			var addJiShenCount:uint = 0;
			var wuGongCount:uint = 0;
			var addWuGongCount:uint = 0;
			var wuFangCount:uint = 0;
			var addWuFangCount:uint = 0;
			var moGongCount:uint = 0;
			var addMoGongCount:uint = 0;
			var moFangCount:uint = 0;
			var addMoFangCount:uint = 0;
			var gongSuCount:uint = 0;
			var addGongSuCount:uint = 0;
			var mingZhongCount:uint = 0;
			var addMingZhongCount:uint = 0;
			var baoJiCount:uint = 0;
			var addBaoJiCount:uint = 0;
			var shanBiCount:uint = 0;
			var addShanBiCount:uint = 0;
			var liliangInfoCount:uint = 0;
			var minjieInfoCount:uint = 0;
			var zhiliInfoCount:uint = 0;
			var nailiInfoCount:uint = 0;
			var jingshenInfoCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (cIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++cIdCount;
					cId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (cNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++cNameCount;
					cName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (liLiangCount != 0) {
						throw new IOError('Bad data format.');
					}
					++liLiangCount;
					liLiang = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (addLiLiangCount != 0) {
						throw new IOError('Bad data format.');
					}
					++addLiLiangCount;
					addLiLiang = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (minJieCount != 0) {
						throw new IOError('Bad data format.');
					}
					++minJieCount;
					minJie = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (addMinJieCount != 0) {
						throw new IOError('Bad data format.');
					}
					++addMinJieCount;
					addMinJie = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (zhiLiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++zhiLiCount;
					zhiLi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (addZhiLiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++addZhiLiCount;
					addZhiLi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 9:
					if (naiLiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++naiLiCount;
					naiLi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 10:
					if (addNaiLiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++addNaiLiCount;
					addNaiLi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 11:
					if (jiShenCount != 0) {
						throw new IOError('Bad data format.');
					}
					++jiShenCount;
					jiShen = ReadUtils.read_TYPE_INT32(input);
					break;
				case 12:
					if (addJiShenCount != 0) {
						throw new IOError('Bad data format.');
					}
					++addJiShenCount;
					addJiShen = ReadUtils.read_TYPE_INT32(input);
					break;
				case 13:
					if (wuGongCount != 0) {
						throw new IOError('Bad data format.');
					}
					++wuGongCount;
					wuGong = ReadUtils.read_TYPE_INT32(input);
					break;
				case 14:
					if (addWuGongCount != 0) {
						throw new IOError('Bad data format.');
					}
					++addWuGongCount;
					addWuGong = ReadUtils.read_TYPE_INT32(input);
					break;
				case 15:
					if (wuFangCount != 0) {
						throw new IOError('Bad data format.');
					}
					++wuFangCount;
					wuFang = ReadUtils.read_TYPE_INT32(input);
					break;
				case 16:
					if (addWuFangCount != 0) {
						throw new IOError('Bad data format.');
					}
					++addWuFangCount;
					addWuFang = ReadUtils.read_TYPE_INT32(input);
					break;
				case 17:
					if (moGongCount != 0) {
						throw new IOError('Bad data format.');
					}
					++moGongCount;
					moGong = ReadUtils.read_TYPE_INT32(input);
					break;
				case 18:
					if (addMoGongCount != 0) {
						throw new IOError('Bad data format.');
					}
					++addMoGongCount;
					addMoGong = ReadUtils.read_TYPE_INT32(input);
					break;
				case 19:
					if (moFangCount != 0) {
						throw new IOError('Bad data format.');
					}
					++moFangCount;
					moFang = ReadUtils.read_TYPE_INT32(input);
					break;
				case 20:
					if (addMoFangCount != 0) {
						throw new IOError('Bad data format.');
					}
					++addMoFangCount;
					addMoFang = ReadUtils.read_TYPE_INT32(input);
					break;
				case 21:
					if (gongSuCount != 0) {
						throw new IOError('Bad data format.');
					}
					++gongSuCount;
					gongSu = ReadUtils.read_TYPE_INT32(input);
					break;
				case 22:
					if (addGongSuCount != 0) {
						throw new IOError('Bad data format.');
					}
					++addGongSuCount;
					addGongSu = ReadUtils.read_TYPE_INT32(input);
					break;
				case 23:
					if (mingZhongCount != 0) {
						throw new IOError('Bad data format.');
					}
					++mingZhongCount;
					mingZhong = ReadUtils.read_TYPE_INT32(input);
					break;
				case 24:
					if (addMingZhongCount != 0) {
						throw new IOError('Bad data format.');
					}
					++addMingZhongCount;
					addMingZhong = ReadUtils.read_TYPE_INT32(input);
					break;
				case 25:
					if (baoJiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baoJiCount;
					baoJi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 26:
					if (addBaoJiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++addBaoJiCount;
					addBaoJi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 27:
					if (shanBiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++shanBiCount;
					shanBi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 28:
					if (addShanBiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++addShanBiCount;
					addShanBi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 29:
					if (liliangInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++liliangInfoCount;
					liliangInfo = new proto.reward.reward2405.ItemManInfo;
					ReadUtils.read_TYPE_MESSAGE(input, liliangInfo);
					break;
				case 30:
					if (minjieInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++minjieInfoCount;
					minjieInfo = new proto.reward.reward2405.ItemManInfo;
					ReadUtils.read_TYPE_MESSAGE(input, minjieInfo);
					break;
				case 31:
					if (zhiliInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++zhiliInfoCount;
					zhiliInfo = new proto.reward.reward2405.ItemManInfo;
					ReadUtils.read_TYPE_MESSAGE(input, zhiliInfo);
					break;
				case 32:
					if (nailiInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nailiInfoCount;
					nailiInfo = new proto.reward.reward2405.ItemManInfo;
					ReadUtils.read_TYPE_MESSAGE(input, nailiInfo);
					break;
				case 33:
					if (jingshenInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++jingshenInfoCount;
					jingshenInfo = new proto.reward.reward2405.ItemManInfo;
					ReadUtils.read_TYPE_MESSAGE(input, jingshenInfo);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
