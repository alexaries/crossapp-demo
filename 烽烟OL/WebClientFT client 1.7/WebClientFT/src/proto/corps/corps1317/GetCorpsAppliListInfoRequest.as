package proto.corps.corps1317 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GetCorpsAppliListInfoRequest extends Message implements IExternalizable {
		public var id:int;
		private var searchCriteria_:String;
		public function get hasSearchCriteria():Boolean {
			return null != searchCriteria_;
		}
		public function set searchCriteria(value:String):void {
			searchCriteria_ = value;
		}
		public function get searchCriteria():String {
			return searchCriteria_;
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
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			if (hasSearchCriteria) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, searchCriteria);
			}
			if (hasCurPage) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, curPage);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var searchCriteriaCount:uint = 0;
			var curPageCount:uint = 0;
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
					if (searchCriteriaCount != 0) {
						throw new IOError('Bad data format.');
					}
					++searchCriteriaCount;
					searchCriteria = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (curPageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curPageCount;
					curPage = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
