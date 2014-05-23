package proto.scene.scene602 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class characterPosition extends Message implements IExternalizable {
		public var id:int;
		public var name:String;
		public var profession:String;
		public var figure:int;
		public var x:int;
		public var y:int;
		private var guildname_:String;
		public function get hasGuildname():Boolean {
			return null != guildname_;
		}
		public function set guildname(value:String):void {
			guildname_ = value;
		}
		public function get guildname():String {
			return guildname_;
		}
		private var masterId_:int;
		private var hasMasterId_:Boolean = false;
		public function get hasMasterId():Boolean {
			return hasMasterId_;
		}
		public function set masterId(value:int):void {
			hasMasterId_ = true;
			masterId_ = value;
		}
		public function get masterId():int {
			return masterId_;
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
		private var viptype_:int;
		private var hasViptype_:Boolean = false;
		public function get hasViptype():Boolean {
			return hasViptype_;
		}
		public function set viptype(value:int):void {
			hasViptype_ = true;
			viptype_ = value;
		}
		public function get viptype():int {
			return viptype_;
		}
		private var gemlevel_:int;
		private var hasGemlevel_:Boolean = false;
		public function get hasGemlevel():Boolean {
			return hasGemlevel_;
		}
		public function set gemlevel(value:int):void {
			hasGemlevel_ = true;
			gemlevel_ = value;
		}
		public function get gemlevel():int {
			return gemlevel_;
		}
		private var headicon_:int;
		private var hasHeadicon_:Boolean = false;
		public function get hasHeadicon():Boolean {
			return hasHeadicon_;
		}
		public function set headicon(value:int):void {
			hasHeadicon_ = true;
			headicon_ = value;
		}
		public function get headicon():int {
			return headicon_;
		}
		private var currentHP_:int;
		private var hasCurrentHP_:Boolean = false;
		public function get hasCurrentHP():Boolean {
			return hasCurrentHP_;
		}
		public function set currentHP(value:int):void {
			hasCurrentHP_ = true;
			currentHP_ = value;
		}
		public function get currentHP():int {
			return currentHP_;
		}
		private var MaxHP_:int;
		private var hasMaxHP_:Boolean = false;
		public function get hasMaxHP():Boolean {
			return hasMaxHP_;
		}
		public function set MaxHP(value:int):void {
			hasMaxHP_ = true;
			MaxHP_ = value;
		}
		public function get MaxHP():int {
			return MaxHP_;
		}
		private var camp_:int;
		private var hasCamp_:Boolean = false;
		public function get hasCamp():Boolean {
			return hasCamp_;
		}
		public function set camp(value:int):void {
			hasCamp_ = true;
			camp_ = value;
		}
		public function get camp():int {
			return camp_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
			WriteUtils.write_TYPE_STRING(output, name);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
			WriteUtils.write_TYPE_STRING(output, profession);
			WriteUtils.writeTag(output, WireType.VARINT, 4);
			WriteUtils.write_TYPE_INT32(output, figure);
			WriteUtils.writeTag(output, WireType.VARINT, 5);
			WriteUtils.write_TYPE_INT32(output, x);
			WriteUtils.writeTag(output, WireType.VARINT, 6);
			WriteUtils.write_TYPE_INT32(output, y);
			if (hasGuildname) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
				WriteUtils.write_TYPE_STRING(output, guildname);
			}
			if (hasMasterId) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, masterId);
			}
			if (hasLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 9);
				WriteUtils.write_TYPE_INT32(output, level);
			}
			if (hasViptype) {
				WriteUtils.writeTag(output, WireType.VARINT, 10);
				WriteUtils.write_TYPE_INT32(output, viptype);
			}
			if (hasGemlevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 11);
				WriteUtils.write_TYPE_INT32(output, gemlevel);
			}
			if (hasHeadicon) {
				WriteUtils.writeTag(output, WireType.VARINT, 12);
				WriteUtils.write_TYPE_INT32(output, headicon);
			}
			if (hasCurrentHP) {
				WriteUtils.writeTag(output, WireType.VARINT, 13);
				WriteUtils.write_TYPE_INT32(output, currentHP);
			}
			if (hasMaxHP) {
				WriteUtils.writeTag(output, WireType.VARINT, 14);
				WriteUtils.write_TYPE_INT32(output, MaxHP);
			}
			if (hasCamp) {
				WriteUtils.writeTag(output, WireType.VARINT, 15);
				WriteUtils.write_TYPE_INT32(output, camp);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var nameCount:uint = 0;
			var professionCount:uint = 0;
			var figureCount:uint = 0;
			var xCount:uint = 0;
			var yCount:uint = 0;
			var guildnameCount:uint = 0;
			var masterIdCount:uint = 0;
			var levelCount:uint = 0;
			var viptypeCount:uint = 0;
			var gemlevelCount:uint = 0;
			var headiconCount:uint = 0;
			var currentHPCount:uint = 0;
			var MaxHPCount:uint = 0;
			var campCount:uint = 0;
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
					if (nameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nameCount;
					name = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (professionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++professionCount;
					profession = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (figureCount != 0) {
						throw new IOError('Bad data format.');
					}
					++figureCount;
					figure = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (xCount != 0) {
						throw new IOError('Bad data format.');
					}
					++xCount;
					x = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (yCount != 0) {
						throw new IOError('Bad data format.');
					}
					++yCount;
					y = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (guildnameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++guildnameCount;
					guildname = ReadUtils.read_TYPE_STRING(input);
					break;
				case 8:
					if (masterIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++masterIdCount;
					masterId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 9:
					if (levelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++levelCount;
					level = ReadUtils.read_TYPE_INT32(input);
					break;
				case 10:
					if (viptypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++viptypeCount;
					viptype = ReadUtils.read_TYPE_INT32(input);
					break;
				case 11:
					if (gemlevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++gemlevelCount;
					gemlevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 12:
					if (headiconCount != 0) {
						throw new IOError('Bad data format.');
					}
					++headiconCount;
					headicon = ReadUtils.read_TYPE_INT32(input);
					break;
				case 13:
					if (currentHPCount != 0) {
						throw new IOError('Bad data format.');
					}
					++currentHPCount;
					currentHP = ReadUtils.read_TYPE_INT32(input);
					break;
				case 14:
					if (MaxHPCount != 0) {
						throw new IOError('Bad data format.');
					}
					++MaxHPCount;
					MaxHP = ReadUtils.read_TYPE_INT32(input);
					break;
				case 15:
					if (campCount != 0) {
						throw new IOError('Bad data format.');
					}
					++campCount;
					camp = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (nameCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (professionCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (figureCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (xCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (yCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
