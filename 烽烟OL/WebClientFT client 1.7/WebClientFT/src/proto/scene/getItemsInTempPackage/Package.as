package proto.scene.getItemsInTempPackage {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.scene.getItemsInTempPackage.itemTemplate;
	import proto.scene.getItemsInTempPackage.extraAttribute;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class Package extends Message implements IExternalizable {
		private var isEquiped_:Boolean;
		private var hasIsEquiped_:Boolean = false;
		public function get hasIsEquiped():Boolean {
			return hasIsEquiped_;
		}
		public function set isEquiped(value:Boolean):void {
			hasIsEquiped_ = true;
			isEquiped_ = value;
		}
		public function get isEquiped():Boolean {
			return isEquiped_;
		}
		private var itemLevel_:int;
		private var hasItemLevel_:Boolean = false;
		public function get hasItemLevel():Boolean {
			return hasItemLevel_;
		}
		public function set itemLevel(value:int):void {
			hasItemLevel_ = true;
			itemLevel_ = value;
		}
		public function get itemLevel():int {
			return itemLevel_;
		}
		private var itemId_:int;
		private var hasItemId_:Boolean = false;
		public function get hasItemId():Boolean {
			return hasItemId_;
		}
		public function set itemId(value:int):void {
			hasItemId_ = true;
			itemId_ = value;
		}
		public function get itemId():int {
			return itemId_;
		}
		private var bindType_:String;
		public function get hasBindType():Boolean {
			return null != bindType_;
		}
		public function set bindType(value:String):void {
			bindType_ = value;
		}
		public function get bindType():String {
			return bindType_;
		}
		private var isBound_:int;
		private var hasIsBound_:Boolean = false;
		public function get hasIsBound():Boolean {
			return hasIsBound_;
		}
		public function set isBound(value:int):void {
			hasIsBound_ = true;
			isBound_ = value;
		}
		public function get isBound():int {
			return isBound_;
		}
		private var isBoundDesc_:String;
		public function get hasIsBoundDesc():Boolean {
			return null != isBoundDesc_;
		}
		public function set isBoundDesc(value:String):void {
			isBoundDesc_ = value;
		}
		public function get isBoundDesc():String {
			return isBoundDesc_;
		}
		private var sellPrice_:int;
		private var hasSellPrice_:Boolean = false;
		public function get hasSellPrice():Boolean {
			return hasSellPrice_;
		}
		public function set sellPrice(value:int):void {
			hasSellPrice_ = true;
			sellPrice_ = value;
		}
		public function get sellPrice():int {
			return sellPrice_;
		}
		[ArrayElementType("proto.scene.getItemsInTempPackage.extraAttribute")]
		public var extraAttributeList:Array = [];
		private var name_:String;
		public function get hasName():Boolean {
			return null != name_;
		}
		public function set name(value:String):void {
			name_ = value;
		}
		public function get name():String {
			return name_;
		}
		private var from_:String;
		public function get hasFrom():Boolean {
			return null != from_;
		}
		public function set from(value:String):void {
			from_ = value;
		}
		public function get from():String {
			return from_;
		}
		private var itemTemplateInfo_:proto.scene.getItemsInTempPackage.itemTemplate;
		public function get hasItemTemplateInfo():Boolean {
			return null != itemTemplateInfo_;
		}
		public function set itemTemplateInfo(value:proto.scene.getItemsInTempPackage.itemTemplate):void {
			itemTemplateInfo_ = value;
		}
		public function get itemTemplateInfo():proto.scene.getItemsInTempPackage.itemTemplate {
			return itemTemplateInfo_;
		}
		private var professionRequireName_:String;
		public function get hasProfessionRequireName():Boolean {
			return null != professionRequireName_;
		}
		public function set professionRequireName(value:String):void {
			professionRequireName_ = value;
		}
		public function get professionRequireName():String {
			return professionRequireName_;
		}
		private var stack_:int;
		private var hasStack_:Boolean = false;
		public function get hasStack():Boolean {
			return hasStack_;
		}
		public function set stack(value:int):void {
			hasStack_ = true;
			stack_ = value;
		}
		public function get stack():int {
			return stack_;
		}
		[ArrayElementType("int")]
		public var position:Array = [];
		private var idInPackage_:int;
		private var hasIdInPackage_:Boolean = false;
		public function get hasIdInPackage():Boolean {
			return hasIdInPackage_;
		}
		public function set idInPackage(value:int):void {
			hasIdInPackage_ = true;
			idInPackage_ = value;
		}
		public function get idInPackage():int {
			return idInPackage_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasIsEquiped) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_BOOL(output, isEquiped);
			}
			if (hasItemLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, itemLevel);
			}
			if (hasItemId) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, itemId);
			}
			if (hasBindType) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, bindType);
			}
			if (hasIsBound) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, isBound);
			}
			if (hasIsBoundDesc) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_STRING(output, isBoundDesc);
			}
			if (hasSellPrice) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, sellPrice);
			}
			for (var extraAttributeListIndex:uint = 0; extraAttributeListIndex < extraAttributeList.length; ++extraAttributeListIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 8);
				WriteUtils.write_TYPE_MESSAGE(output, extraAttributeList[extraAttributeListIndex]);
			}
			if (hasName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 9);
				WriteUtils.write_TYPE_STRING(output, name);
			}
			if (hasFrom) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 10);
				WriteUtils.write_TYPE_STRING(output, from);
			}
			if (hasItemTemplateInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 11);
				WriteUtils.write_TYPE_MESSAGE(output, itemTemplateInfo);
			}
			if (hasProfessionRequireName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 12);
				WriteUtils.write_TYPE_STRING(output, professionRequireName);
			}
			if (hasStack) {
				WriteUtils.writeTag(output, WireType.VARINT, 13);
				WriteUtils.write_TYPE_INT32(output, stack);
			}
			for (var positionIndex:uint = 0; positionIndex < position.length; ++positionIndex) {
				WriteUtils.writeTag(output, WireType.VARINT, 14);
				WriteUtils.write_TYPE_INT32(output, position[positionIndex]);
			}
			if (hasIdInPackage) {
				WriteUtils.writeTag(output, WireType.VARINT, 15);
				WriteUtils.write_TYPE_INT32(output, idInPackage);
			}
		}
		public function readExternal(input:IDataInput):void {
			var isEquipedCount:uint = 0;
			var itemLevelCount:uint = 0;
			var itemIdCount:uint = 0;
			var bindTypeCount:uint = 0;
			var isBoundCount:uint = 0;
			var isBoundDescCount:uint = 0;
			var sellPriceCount:uint = 0;
			var nameCount:uint = 0;
			var fromCount:uint = 0;
			var itemTemplateInfoCount:uint = 0;
			var professionRequireNameCount:uint = 0;
			var stackCount:uint = 0;
			var idInPackageCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (isEquipedCount != 0) {
						throw new IOError('Bad data format.');
					}
					++isEquipedCount;
					isEquiped = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 2:
					if (itemLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemLevelCount;
					itemLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (itemIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemIdCount;
					itemId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (bindTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++bindTypeCount;
					bindType = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (isBoundCount != 0) {
						throw new IOError('Bad data format.');
					}
					++isBoundCount;
					isBound = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (isBoundDescCount != 0) {
						throw new IOError('Bad data format.');
					}
					++isBoundDescCount;
					isBoundDesc = ReadUtils.read_TYPE_STRING(input);
					break;
				case 7:
					if (sellPriceCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sellPriceCount;
					sellPrice = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					extraAttributeList.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.scene.getItemsInTempPackage.extraAttribute));
					break;
				case 9:
					if (nameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nameCount;
					name = ReadUtils.read_TYPE_STRING(input);
					break;
				case 10:
					if (fromCount != 0) {
						throw new IOError('Bad data format.');
					}
					++fromCount;
					from = ReadUtils.read_TYPE_STRING(input);
					break;
				case 11:
					if (itemTemplateInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemTemplateInfoCount;
					itemTemplateInfo = new proto.scene.getItemsInTempPackage.itemTemplate;
					ReadUtils.read_TYPE_MESSAGE(input, itemTemplateInfo);
					break;
				case 12:
					if (professionRequireNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++professionRequireNameCount;
					professionRequireName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 13:
					if (stackCount != 0) {
						throw new IOError('Bad data format.');
					}
					++stackCount;
					stack = ReadUtils.read_TYPE_INT32(input);
					break;
				case 14:
					if (tag.wireType == WireType.LENGTH_DELIMITED) {
						ReadUtils.readPackedRepeated(input, ReadUtils.read_TYPE_INT32, position);
					break;
					}
					position.push(ReadUtils.read_TYPE_INT32(input));
					break;
				case 15:
					if (idInPackageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++idInPackageCount;
					idInPackage = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
