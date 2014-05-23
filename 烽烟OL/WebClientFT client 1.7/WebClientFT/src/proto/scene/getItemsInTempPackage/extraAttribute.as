package proto.scene.getItemsInTempPackage {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.scene.getItemsInTempPackage.attributeEffect;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class extraAttribute extends Message implements IExternalizable {
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
		private var script_:String;
		public function get hasScript():Boolean {
			return null != script_;
		}
		public function set script(value:String):void {
			script_ = value;
		}
		public function get script():String {
			return script_;
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
		private var effects_:String;
		public function get hasEffects():Boolean {
			return null != effects_;
		}
		public function set effects(value:String):void {
			effects_ = value;
		}
		public function get effects():String {
			return effects_;
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
		private var id_:int;
		private var hasId_:Boolean = false;
		public function get hasId():Boolean {
			return hasId_;
		}
		public function set id(value:int):void {
			hasId_ = true;
			id_ = value;
		}
		public function get id():int {
			return id_;
		}
		[ArrayElementType("proto.scene.getItemsInTempPackage.attributeEffect")]
		public var attributeEffects:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, name);
			}
			if (hasScript) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, script);
			}
			if (hasLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, level);
			}
			if (hasEffects) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, effects);
			}
			if (hasType) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, type);
			}
			if (hasId) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, id);
			}
			for (var attributeEffectsIndex:uint = 0; attributeEffectsIndex < attributeEffects.length; ++attributeEffectsIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
				WriteUtils.write_TYPE_MESSAGE(output, attributeEffects[attributeEffectsIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var nameCount:uint = 0;
			var scriptCount:uint = 0;
			var levelCount:uint = 0;
			var effectsCount:uint = 0;
			var typeCount:uint = 0;
			var idCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (nameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nameCount;
					name = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (scriptCount != 0) {
						throw new IOError('Bad data format.');
					}
					++scriptCount;
					script = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (levelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++levelCount;
					level = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (effectsCount != 0) {
						throw new IOError('Bad data format.');
					}
					++effectsCount;
					effects = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (typeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++typeCount;
					type = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (idCount != 0) {
						throw new IOError('Bad data format.');
					}
					++idCount;
					id = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					attributeEffects.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.scene.getItemsInTempPackage.attributeEffect));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
