package proto.shop.shop206 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.shop.shop206.PackageInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ShopInfo extends Message implements IExternalizable {
		[ArrayElementType("proto.shop.shop206.PackageInfo")]
		public var packageItemInfo:Array = [];
		private var shopCategory_:int;
		private var hasShopCategory_:Boolean = false;
		public function get hasShopCategory():Boolean {
			return hasShopCategory_;
		}
		public function set shopCategory(value:int):void {
			hasShopCategory_ = true;
			shopCategory_ = value;
		}
		public function get shopCategory():int {
			return shopCategory_;
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
		private var maxPage_:int;
		private var hasMaxPage_:Boolean = false;
		public function get hasMaxPage():Boolean {
			return hasMaxPage_;
		}
		public function set maxPage(value:int):void {
			hasMaxPage_ = true;
			maxPage_ = value;
		}
		public function get maxPage():int {
			return maxPage_;
		}
		public function writeExternal(output:IDataOutput):void {
			for (var packageItemInfoIndex:uint = 0; packageItemInfoIndex < packageItemInfo.length; ++packageItemInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, packageItemInfo[packageItemInfoIndex]);
			}
			if (hasShopCategory) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, shopCategory);
			}
			if (hasCurPage) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, curPage);
			}
			if (hasMaxPage) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, maxPage);
			}
		}
		public function readExternal(input:IDataInput):void {
			var shopCategoryCount:uint = 0;
			var curPageCount:uint = 0;
			var maxPageCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					packageItemInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.shop.shop206.PackageInfo));
					break;
				case 2:
					if (shopCategoryCount != 0) {
						throw new IOError('Bad data format.');
					}
					++shopCategoryCount;
					shopCategory = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (curPageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curPageCount;
					curPage = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (maxPageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxPageCount;
					maxPage = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
