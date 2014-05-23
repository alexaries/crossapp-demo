package proto.sysOpe.sysOpe2900 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.sysOpe.sysOpe2900.GuaJiInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class SysOpeCorpsResponse extends Message implements IExternalizable {
		private var roleId_:int;
		private var hasRoleId_:Boolean = false;
		public function get hasRoleId():Boolean {
			return hasRoleId_;
		}
		public function set roleId(value:int):void {
			hasRoleId_ = true;
			roleId_ = value;
		}
		public function get roleId():int {
			return roleId_;
		}
		private var roleName_:String;
		public function get hasRoleName():Boolean {
			return null != roleName_;
		}
		public function set roleName(value:String):void {
			roleName_ = value;
		}
		public function get roleName():String {
			return roleName_;
		}
		private var sysOpeType_:int;
		private var hasSysOpeType_:Boolean = false;
		public function get hasSysOpeType():Boolean {
			return hasSysOpeType_;
		}
		public function set sysOpeType(value:int):void {
			hasSysOpeType_ = true;
			sysOpeType_ = value;
		}
		public function get sysOpeType():int {
			return sysOpeType_;
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
		private var pos_:int;
		private var hasPos_:Boolean = false;
		public function get hasPos():Boolean {
			return hasPos_;
		}
		public function set pos(value:int):void {
			hasPos_ = true;
			pos_ = value;
		}
		public function get pos():int {
			return pos_;
		}
		private var curPage_:int;
		private var hasCurPage_:Boolean = false;
		public function get hasCurPage():Boolean {
			return hasCurPage_;
		}
		public function set curPage(value:int):void {
			hasCurPage_ = true;
			curPage_ = value;
		}
		public function get curPage():int {
			return curPage_;
		}
		private var tishiStr_:String;
		public function get hasTishiStr():Boolean {
			return null != tishiStr_;
		}
		public function set tishiStr(value:String):void {
			tishiStr_ = value;
		}
		public function get tishiStr():String {
			return tishiStr_;
		}
		private var contentStr_:String;
		public function get hasContentStr():Boolean {
			return null != contentStr_;
		}
		public function set contentStr(value:String):void {
			contentStr_ = value;
		}
		public function get contentStr():String {
			return contentStr_;
		}
		private var caozuoStr_:String;
		public function get hasCaozuoStr():Boolean {
			return null != caozuoStr_;
		}
		public function set caozuoStr(value:String):void {
			caozuoStr_ = value;
		}
		public function get caozuoStr():String {
			return caozuoStr_;
		}
		private var toposition_:int;
		private var hasToposition_:Boolean = false;
		public function get hasToposition():Boolean {
			return hasToposition_;
		}
		public function set toposition(value:int):void {
			hasToposition_ = true;
			toposition_ = value;
		}
		public function get toposition():int {
			return toposition_;
		}
		private var guaJiInfo_:proto.sysOpe.sysOpe2900.GuaJiInfo;
		public function get hasGuaJiInfo():Boolean {
			return null != guaJiInfo_;
		}
		public function set guaJiInfo(value:proto.sysOpe.sysOpe2900.GuaJiInfo):void {
			guaJiInfo_ = value;
		}
		public function get guaJiInfo():proto.sysOpe.sysOpe2900.GuaJiInfo {
			return guaJiInfo_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasRoleId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, roleId);
			}
			if (hasRoleName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, roleName);
			}
			if (hasSysOpeType) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, sysOpeType);
			}
			if (hasIcon) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, icon);
			}
			if (hasType) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, type);
			}
			if (hasPos) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, pos);
			}
			if (hasCurPage) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, curPage);
			}
			if (hasTishiStr) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 8);
				WriteUtils.write_TYPE_STRING(output, tishiStr);
			}
			if (hasContentStr) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 9);
				WriteUtils.write_TYPE_STRING(output, contentStr);
			}
			if (hasCaozuoStr) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 10);
				WriteUtils.write_TYPE_STRING(output, caozuoStr);
			}
			if (hasToposition) {
				WriteUtils.writeTag(output, WireType.VARINT, 11);
				WriteUtils.write_TYPE_INT32(output, toposition);
			}
			if (hasGuaJiInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 12);
				WriteUtils.write_TYPE_MESSAGE(output, guaJiInfo);
			}
		}
		public function readExternal(input:IDataInput):void {
			var roleIdCount:uint = 0;
			var roleNameCount:uint = 0;
			var sysOpeTypeCount:uint = 0;
			var iconCount:uint = 0;
			var typeCount:uint = 0;
			var posCount:uint = 0;
			var curPageCount:uint = 0;
			var tishiStrCount:uint = 0;
			var contentStrCount:uint = 0;
			var caozuoStrCount:uint = 0;
			var topositionCount:uint = 0;
			var guaJiInfoCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (roleIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++roleIdCount;
					roleId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (roleNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++roleNameCount;
					roleName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (sysOpeTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sysOpeTypeCount;
					sysOpeType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (iconCount != 0) {
						throw new IOError('Bad data format.');
					}
					++iconCount;
					icon = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (typeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++typeCount;
					type = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (posCount != 0) {
						throw new IOError('Bad data format.');
					}
					++posCount;
					pos = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (curPageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curPageCount;
					curPage = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (tishiStrCount != 0) {
						throw new IOError('Bad data format.');
					}
					++tishiStrCount;
					tishiStr = ReadUtils.read_TYPE_STRING(input);
					break;
				case 9:
					if (contentStrCount != 0) {
						throw new IOError('Bad data format.');
					}
					++contentStrCount;
					contentStr = ReadUtils.read_TYPE_STRING(input);
					break;
				case 10:
					if (caozuoStrCount != 0) {
						throw new IOError('Bad data format.');
					}
					++caozuoStrCount;
					caozuoStr = ReadUtils.read_TYPE_STRING(input);
					break;
				case 11:
					if (topositionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++topositionCount;
					toposition = ReadUtils.read_TYPE_INT32(input);
					break;
				case 12:
					if (guaJiInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++guaJiInfoCount;
					guaJiInfo = new proto.sysOpe.sysOpe2900.GuaJiInfo;
					ReadUtils.read_TYPE_MESSAGE(input, guaJiInfo);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
