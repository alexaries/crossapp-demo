package proto.commission.commission1202 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.commission.commission1202.ConsignmentInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class responseData extends Message implements IExternalizable {
		private var pageGoal_:int;
		private var hasPageGoal_:Boolean = false;
		public function get hasPageGoal():Boolean {
			return hasPageGoal_;
		}
		public function set pageGoal(value:int):void {
			hasPageGoal_ = true;
			pageGoal_ = value;
		}
		public function get pageGoal():int {
			return pageGoal_;
		}
		private var searchType_:int;
		private var hasSearchType_:Boolean = false;
		public function get hasSearchType():Boolean {
			return hasSearchType_;
		}
		public function set searchType(value:int):void {
			hasSearchType_ = true;
			searchType_ = value;
		}
		public function get searchType():int {
			return searchType_;
		}
		[ArrayElementType("proto.commission.commission1202.ConsignmentInfo")]
		public var consignInfo:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasPageGoal) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, pageGoal);
			}
			if (hasSearchType) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, searchType);
			}
			for (var consignInfoIndex:uint = 0; consignInfoIndex < consignInfo.length; ++consignInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, consignInfo[consignInfoIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var pageGoalCount:uint = 0;
			var searchTypeCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (pageGoalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++pageGoalCount;
					pageGoal = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (searchTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++searchTypeCount;
					searchType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					consignInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.commission.commission1202.ConsignmentInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
