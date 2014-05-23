package proto.guanjue.guanjue3300 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GuanJueInfo extends Message implements IExternalizable {
		private var currentJuewei_:String;
		public function get hasCurrentJuewei():Boolean {
			return null != currentJuewei_;
		}
		public function set currentJuewei(value:String):void {
			currentJuewei_ = value;
		}
		public function get currentJuewei():String {
			return currentJuewei_;
		}
		private var weiwang_:int;
		private var hasWeiwang_:Boolean = false;
		public function get hasWeiwang():Boolean {
			return hasWeiwang_;
		}
		public function set weiwang(value:int):void {
			hasWeiwang_ = true;
			weiwang_ = value;
		}
		public function get weiwang():int {
			return weiwang_;
		}
		private var currentJinbi_:int;
		private var hasCurrentJinbi_:Boolean = false;
		public function get hasCurrentJinbi():Boolean {
			return hasCurrentJinbi_;
		}
		public function set currentJinbi(value:int):void {
			hasCurrentJinbi_ = true;
			currentJinbi_ = value;
		}
		public function get currentJinbi():int {
			return currentJinbi_;
		}
		private var currentDouqi_:int;
		private var hasCurrentDouqi_:Boolean = false;
		public function get hasCurrentDouqi():Boolean {
			return hasCurrentDouqi_;
		}
		public function set currentDouqi(value:int):void {
			hasCurrentDouqi_ = true;
			currentDouqi_ = value;
		}
		public function get currentDouqi():int {
			return currentDouqi_;
		}
		[ArrayElementType("String")]
		public var adddq:Array = [];
		private var nextJuewei_:String;
		public function get hasNextJuewei():Boolean {
			return null != nextJuewei_;
		}
		public function set nextJuewei(value:String):void {
			nextJuewei_ = value;
		}
		public function get nextJuewei():String {
			return nextJuewei_;
		}
		private var nextWeiwang_:int;
		private var hasNextWeiwang_:Boolean = false;
		public function get hasNextWeiwang():Boolean {
			return hasNextWeiwang_;
		}
		public function set nextWeiwang(value:int):void {
			hasNextWeiwang_ = true;
			nextWeiwang_ = value;
		}
		public function get nextWeiwang():int {
			return nextWeiwang_;
		}
		private var nextJinbi_:int;
		private var hasNextJinbi_:Boolean = false;
		public function get hasNextJinbi():Boolean {
			return hasNextJinbi_;
		}
		public function set nextJinbi(value:int):void {
			hasNextJinbi_ = true;
			nextJinbi_ = value;
		}
		public function get nextJinbi():int {
			return nextJinbi_;
		}
		private var nextDouqi_:int;
		private var hasNextDouqi_:Boolean = false;
		public function get hasNextDouqi():Boolean {
			return hasNextDouqi_;
		}
		public function set nextDouqi(value:int):void {
			hasNextDouqi_ = true;
			nextDouqi_ = value;
		}
		public function get nextDouqi():int {
			return nextDouqi_;
		}
		[ArrayElementType("String")]
		public var addxj:Array = [];
		[ArrayElementType("String")]
		public var ftime:Array = [];
		[ArrayElementType("String")]
		public var fcontext:Array = [];
		private var curpage_:int;
		private var hasCurpage_:Boolean = false;
		public function get hasCurpage():Boolean {
			return hasCurpage_;
		}
		public function set curpage(value:int):void {
			hasCurpage_ = true;
			curpage_ = value;
		}
		public function get curpage():int {
			return curpage_;
		}
		private var totalpage_:int;
		private var hasTotalpage_:Boolean = false;
		public function get hasTotalpage():Boolean {
			return hasTotalpage_;
		}
		public function set totalpage(value:int):void {
			hasTotalpage_ = true;
			totalpage_ = value;
		}
		public function get totalpage():int {
			return totalpage_;
		}
		private var isjw_:Boolean;
		private var hasIsjw_:Boolean = false;
		public function get hasIsjw():Boolean {
			return hasIsjw_;
		}
		public function set isjw(value:Boolean):void {
			hasIsjw_ = true;
			isjw_ = value;
		}
		public function get isjw():Boolean {
			return isjw_;
		}
		private var hasGetSalary_:Boolean;
		private var hasHasGetSalary_:Boolean = false;
		public function get hasHasGetSalary():Boolean {
			return hasHasGetSalary_;
		}
		public function set hasGetSalary(value:Boolean):void {
			hasHasGetSalary_ = true;
			hasGetSalary_ = value;
		}
		public function get hasGetSalary():Boolean {
			return hasGetSalary_;
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
			if (hasCurrentJuewei) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, currentJuewei);
			}
			if (hasWeiwang) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, weiwang);
			}
			if (hasCurrentJinbi) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, currentJinbi);
			}
			if (hasCurrentDouqi) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, currentDouqi);
			}
			for (var adddqIndex:uint = 0; adddqIndex < adddq.length; ++adddqIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_STRING(output, adddq[adddqIndex]);
			}
			if (hasNextJuewei) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_STRING(output, nextJuewei);
			}
			if (hasNextWeiwang) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, nextWeiwang);
			}
			if (hasNextJinbi) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, nextJinbi);
			}
			if (hasNextDouqi) {
				WriteUtils.writeTag(output, WireType.VARINT, 9);
				WriteUtils.write_TYPE_INT32(output, nextDouqi);
			}
			for (var addxjIndex:uint = 0; addxjIndex < addxj.length; ++addxjIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 10);
				WriteUtils.write_TYPE_STRING(output, addxj[addxjIndex]);
			}
			for (var ftimeIndex:uint = 0; ftimeIndex < ftime.length; ++ftimeIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 11);
				WriteUtils.write_TYPE_STRING(output, ftime[ftimeIndex]);
			}
			for (var fcontextIndex:uint = 0; fcontextIndex < fcontext.length; ++fcontextIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 12);
				WriteUtils.write_TYPE_STRING(output, fcontext[fcontextIndex]);
			}
			if (hasCurpage) {
				WriteUtils.writeTag(output, WireType.VARINT, 13);
				WriteUtils.write_TYPE_INT32(output, curpage);
			}
			if (hasTotalpage) {
				WriteUtils.writeTag(output, WireType.VARINT, 14);
				WriteUtils.write_TYPE_INT32(output, totalpage);
			}
			if (hasIsjw) {
				WriteUtils.writeTag(output, WireType.VARINT, 15);
				WriteUtils.write_TYPE_BOOL(output, isjw);
			}
			if (hasHasGetSalary) {
				WriteUtils.writeTag(output, WireType.VARINT, 16);
				WriteUtils.write_TYPE_BOOL(output, hasGetSalary);
			}
			if (hasLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 17);
				WriteUtils.write_TYPE_INT32(output, level);
			}
		}
		public function readExternal(input:IDataInput):void {
			var currentJueweiCount:uint = 0;
			var weiwangCount:uint = 0;
			var currentJinbiCount:uint = 0;
			var currentDouqiCount:uint = 0;
			var nextJueweiCount:uint = 0;
			var nextWeiwangCount:uint = 0;
			var nextJinbiCount:uint = 0;
			var nextDouqiCount:uint = 0;
			var curpageCount:uint = 0;
			var totalpageCount:uint = 0;
			var isjwCount:uint = 0;
			var hasGetSalaryCount:uint = 0;
			var levelCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (currentJueweiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++currentJueweiCount;
					currentJuewei = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (weiwangCount != 0) {
						throw new IOError('Bad data format.');
					}
					++weiwangCount;
					weiwang = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (currentJinbiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++currentJinbiCount;
					currentJinbi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (currentDouqiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++currentDouqiCount;
					currentDouqi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					adddq.push(ReadUtils.read_TYPE_STRING(input));
					break;
				case 6:
					if (nextJueweiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nextJueweiCount;
					nextJuewei = ReadUtils.read_TYPE_STRING(input);
					break;
				case 7:
					if (nextWeiwangCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nextWeiwangCount;
					nextWeiwang = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (nextJinbiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nextJinbiCount;
					nextJinbi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 9:
					if (nextDouqiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nextDouqiCount;
					nextDouqi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 10:
					addxj.push(ReadUtils.read_TYPE_STRING(input));
					break;
				case 11:
					ftime.push(ReadUtils.read_TYPE_STRING(input));
					break;
				case 12:
					fcontext.push(ReadUtils.read_TYPE_STRING(input));
					break;
				case 13:
					if (curpageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curpageCount;
					curpage = ReadUtils.read_TYPE_INT32(input);
					break;
				case 14:
					if (totalpageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++totalpageCount;
					totalpage = ReadUtils.read_TYPE_INT32(input);
					break;
				case 15:
					if (isjwCount != 0) {
						throw new IOError('Bad data format.');
					}
					++isjwCount;
					isjw = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 16:
					if (hasGetSalaryCount != 0) {
						throw new IOError('Bad data format.');
					}
					++hasGetSalaryCount;
					hasGetSalary = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 17:
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
