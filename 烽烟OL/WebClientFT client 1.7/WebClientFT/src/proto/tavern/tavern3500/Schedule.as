package proto.tavern.tavern3500 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	[Bindable]
	public final class Schedule extends Message implements IExternalizable {
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
		private var Skill_:String;
		public function get hasSkill():Boolean {
			return null != Skill_;
		}
		public function set Skill(value:String):void {
			Skill_ = value;
		}
		public function get Skill():String {
			return Skill_;
		}
		private var Texing_:String;
		public function get hasTexing():Boolean {
			return null != Texing_;
		}
		public function set Texing(value:String):void {
			Texing_ = value;
		}
		public function get Texing():String {
			return Texing_;
		}
		private var Liliang_:int;
		private var hasLiliang_:Boolean = false;
		public function get hasLiliang():Boolean {
			return hasLiliang_;
		}
		public function set Liliang(value:int):void {
			hasLiliang_ = true;
			Liliang_ = value;
		}
		public function get Liliang():int {
			return Liliang_;
		}
		private var Zhili_:int;
		private var hasZhili_:Boolean = false;
		public function get hasZhili():Boolean {
			return hasZhili_;
		}
		public function set Zhili(value:int):void {
			hasZhili_ = true;
			Zhili_ = value;
		}
		public function get Zhili():int {
			return Zhili_;
		}
		private var Naili_:int;
		private var hasNaili_:Boolean = false;
		public function get hasNaili():Boolean {
			return hasNaili_;
		}
		public function set Naili(value:int):void {
			hasNaili_ = true;
			Naili_ = value;
		}
		public function get Naili():int {
			return Naili_;
		}
		private var Minjie_:int;
		private var hasMinjie_:Boolean = false;
		public function get hasMinjie():Boolean {
			return hasMinjie_;
		}
		public function set Minjie(value:int):void {
			hasMinjie_ = true;
			Minjie_ = value;
		}
		public function get Minjie():int {
			return Minjie_;
		}
		private var Dengji_:int;
		private var hasDengji_:Boolean = false;
		public function get hasDengji():Boolean {
			return hasDengji_;
		}
		public function set Dengji(value:int):void {
			hasDengji_ = true;
			Dengji_ = value;
		}
		public function get Dengji():int {
			return Dengji_;
		}
		private var Hp_:int;
		private var hasHp_:Boolean = false;
		public function get hasHp():Boolean {
			return hasHp_;
		}
		public function set Hp(value:int):void {
			hasHp_ = true;
			Hp_ = value;
		}
		public function get Hp():int {
			return Hp_;
		}
		private var Name_:String;
		public function get hasName():Boolean {
			return null != Name_;
		}
		public function set Name(value:String):void {
			Name_ = value;
		}
		public function get Name():String {
			return Name_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasType) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, type);
			}
			if (hasIcon) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, icon);
			}
			if (hasSkill) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, Skill);
			}
			if (hasTexing) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, Texing);
			}
			if (hasLiliang) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, Liliang);
			}
			if (hasZhili) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, Zhili);
			}
			if (hasNaili) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, Naili);
			}
			if (hasMinjie) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, Minjie);
			}
			if (hasDengji) {
				WriteUtils.writeTag(output, WireType.VARINT, 9);
				WriteUtils.write_TYPE_INT32(output, Dengji);
			}
			if (hasHp) {
				WriteUtils.writeTag(output, WireType.VARINT, 10);
				WriteUtils.write_TYPE_INT32(output, Hp);
			}
			if (hasName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 11);
				WriteUtils.write_TYPE_STRING(output, Name);
			}
		}
		public function readExternal(input:IDataInput):void {
			var typeCount:uint = 0;
			var iconCount:uint = 0;
			var SkillCount:uint = 0;
			var TexingCount:uint = 0;
			var LiliangCount:uint = 0;
			var ZhiliCount:uint = 0;
			var NailiCount:uint = 0;
			var MinjieCount:uint = 0;
			var DengjiCount:uint = 0;
			var HpCount:uint = 0;
			var NameCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (typeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++typeCount;
					type = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (iconCount != 0) {
						throw new IOError('Bad data format.');
					}
					++iconCount;
					icon = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (SkillCount != 0) {
						throw new IOError('Bad data format.');
					}
					++SkillCount;
					Skill = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (TexingCount != 0) {
						throw new IOError('Bad data format.');
					}
					++TexingCount;
					Texing = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (LiliangCount != 0) {
						throw new IOError('Bad data format.');
					}
					++LiliangCount;
					Liliang = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (ZhiliCount != 0) {
						throw new IOError('Bad data format.');
					}
					++ZhiliCount;
					Zhili = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (NailiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++NailiCount;
					Naili = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (MinjieCount != 0) {
						throw new IOError('Bad data format.');
					}
					++MinjieCount;
					Minjie = ReadUtils.read_TYPE_INT32(input);
					break;
				case 9:
					if (DengjiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++DengjiCount;
					Dengji = ReadUtils.read_TYPE_INT32(input);
					break;
				case 10:
					if (HpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++HpCount;
					Hp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 11:
					if (NameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++NameCount;
					Name = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
