package proto.shop.shop208 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.shop.shop208.ItemIifo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class responseData extends Message implements IExternalizable {
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
		private var categories_:int;
		private var hasCategories_:Boolean = false;
		public function get hasCategories():Boolean {
			return hasCategories_;
		}
		public function set categories(value:int):void {
			hasCategories_ = true;
			categories_ = value;
		}
		public function get categories():int {
			return categories_;
		}
		private var goal_:int;
		private var hasGoal_:Boolean = false;
		public function get hasGoal():Boolean {
			return hasGoal_;
		}
		public function set goal(value:int):void {
			hasGoal_ = true;
			goal_ = value;
		}
		public function get goal():int {
			return goal_;
		}
		[ArrayElementType("proto.shop.shop208.ItemIifo")]
		public var items:Array = [];
		[ArrayElementType("proto.shop.shop208.ItemIifo")]
		public var zxItems:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasCurpage) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, curpage);
			}
			if (hasCategories) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, categories);
			}
			if (hasGoal) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, goal);
			}
			for (var itemsIndex:uint = 0; itemsIndex < items.length; ++itemsIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_MESSAGE(output, items[itemsIndex]);
			}
			for (var zxItemsIndex:uint = 0; zxItemsIndex < zxItems.length; ++zxItemsIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_MESSAGE(output, zxItems[zxItemsIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var curpageCount:uint = 0;
			var categoriesCount:uint = 0;
			var goalCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (curpageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curpageCount;
					curpage = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (categoriesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++categoriesCount;
					categories = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (goalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++goalCount;
					goal = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					items.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.shop.shop208.ItemIifo));
					break;
				case 5:
					zxItems.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.shop.shop208.ItemIifo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
