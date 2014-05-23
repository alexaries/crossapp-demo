package proto.panpa.panpa4200 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class PanPaInfo extends Message implements IExternalizable {
		private var curLev_:int;
		private var hasCurLev_:Boolean = false;
		public function get hasCurLev():Boolean {
			return hasCurLev_;
		}
		public function set curLev(value:int):void {
			hasCurLev_ = true;
			curLev_ = value;
		}
		public function get curLev():int {
			return curLev_;
		}
		private var curMonster_:String;
		public function get hasCurMonster():Boolean {
			return null != curMonster_;
		}
		public function set curMonster(value:String):void {
			curMonster_ = value;
		}
		public function get curMonster():String {
			return curMonster_;
		}
		private var obtainItem_:String;
		public function get hasObtainItem():Boolean {
			return null != obtainItem_;
		}
		public function set obtainItem(value:String):void {
			obtainItem_ = value;
		}
		public function get obtainItem():String {
			return obtainItem_;
		}
		private var reCount_:int;
		private var hasReCount_:Boolean = false;
		public function get hasReCount():Boolean {
			return hasReCount_;
		}
		public function set reCount(value:int):void {
			hasReCount_ = true;
			reCount_ = value;
		}
		public function get reCount():int {
			return reCount_;
		}
		private var reZuan_:int;
		private var hasReZuan_:Boolean = false;
		public function get hasReZuan():Boolean {
			return hasReZuan_;
		}
		public function set reZuan(value:int):void {
			hasReZuan_ = true;
			reZuan_ = value;
		}
		public function get reZuan():int {
			return reZuan_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasCurLev) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, curLev);
			}
			if (hasCurMonster) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, curMonster);
			}
			if (hasObtainItem) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, obtainItem);
			}
			if (hasReCount) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, reCount);
			}
			if (hasReZuan) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, reZuan);
			}
		}
		public function readExternal(input:IDataInput):void {
			var curLevCount:uint = 0;
			var curMonsterCount:uint = 0;
			var obtainItemCount:uint = 0;
			var reCountCount:uint = 0;
			var reZuanCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (curLevCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curLevCount;
					curLev = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (curMonsterCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curMonsterCount;
					curMonster = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (obtainItemCount != 0) {
						throw new IOError('Bad data format.');
					}
					++obtainItemCount;
					obtainItem = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (reCountCount != 0) {
						throw new IOError('Bad data format.');
					}
					++reCountCount;
					reCount = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (reZuanCount != 0) {
						throw new IOError('Bad data format.');
					}
					++reZuanCount;
					reZuan = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
