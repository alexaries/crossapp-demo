package proto.task {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.task.TaskTalk;
	import proto.task.ItemInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class TaskItemInfo extends Message implements IExternalizable {
		public var taskId:int;
		public var taskType:int;
		public var taskState:int;
		public var taskPriceCoins:int;
		public var taskPriceZuan:int;
		public var taskExp:int;
		public var taskName:String;
		private var taskIsTrack_:int;
		private var hasTaskIsTrack_:Boolean = false;
		public function get hasTaskIsTrack():Boolean {
			return hasTaskIsTrack_;
		}
		public function set taskIsTrack(value:int):void {
			hasTaskIsTrack_ = true;
			taskIsTrack_ = value;
		}
		public function get taskIsTrack():int {
			return taskIsTrack_;
		}
		private var taskLv_:int;
		private var hasTaskLv_:Boolean = false;
		public function get hasTaskLv():Boolean {
			return hasTaskLv_;
		}
		public function set taskLv(value:int):void {
			hasTaskLv_ = true;
			taskLv_ = value;
		}
		public function get taskLv():int {
			return taskLv_;
		}
		private var taskTypeName_:String;
		public function get hasTaskTypeName():Boolean {
			return null != taskTypeName_;
		}
		public function set taskTypeName(value:String):void {
			taskTypeName_ = value;
		}
		public function get taskTypeName():String {
			return taskTypeName_;
		}
		private var taskUiDes_:String;
		public function get hasTaskUiDes():Boolean {
			return null != taskUiDes_;
		}
		public function set taskUiDes(value:String):void {
			taskUiDes_ = value;
		}
		public function get taskUiDes():String {
			return taskUiDes_;
		}
		private var taskRuningDes_:String;
		public function get hasTaskRuningDes():Boolean {
			return null != taskRuningDes_;
		}
		public function set taskRuningDes(value:String):void {
			taskRuningDes_ = value;
		}
		public function get taskRuningDes():String {
			return taskRuningDes_;
		}
		private var taskTaget_:String;
		public function get hasTaskTaget():Boolean {
			return null != taskTaget_;
		}
		public function set taskTaget(value:String):void {
			taskTaget_ = value;
		}
		public function get taskTaget():String {
			return taskTaget_;
		}
		[ArrayElementType("proto.task.TaskTalk")]
		public var taskDes:Array = [];
		[ArrayElementType("proto.task.ItemInfo")]
		public var taskPriceItem:Array = [];
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, taskId);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, taskType);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, taskState);
			WriteUtils.writeTag(output, WireType.VARINT, 4);
			WriteUtils.write_TYPE_INT32(output, taskPriceCoins);
			WriteUtils.writeTag(output, WireType.VARINT, 5);
			WriteUtils.write_TYPE_INT32(output, taskPriceZuan);
			WriteUtils.writeTag(output, WireType.VARINT, 6);
			WriteUtils.write_TYPE_INT32(output, taskExp);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
			WriteUtils.write_TYPE_STRING(output, taskName);
			if (hasTaskIsTrack) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, taskIsTrack);
			}
			if (hasTaskLv) {
				WriteUtils.writeTag(output, WireType.VARINT, 9);
				WriteUtils.write_TYPE_INT32(output, taskLv);
			}
			if (hasTaskTypeName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 10);
				WriteUtils.write_TYPE_STRING(output, taskTypeName);
			}
			if (hasTaskUiDes) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 11);
				WriteUtils.write_TYPE_STRING(output, taskUiDes);
			}
			if (hasTaskRuningDes) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 12);
				WriteUtils.write_TYPE_STRING(output, taskRuningDes);
			}
			if (hasTaskTaget) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 13);
				WriteUtils.write_TYPE_STRING(output, taskTaget);
			}
			for (var taskDesIndex:uint = 0; taskDesIndex < taskDes.length; ++taskDesIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 14);
				WriteUtils.write_TYPE_MESSAGE(output, taskDes[taskDesIndex]);
			}
			for (var taskPriceItemIndex:uint = 0; taskPriceItemIndex < taskPriceItem.length; ++taskPriceItemIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 15);
				WriteUtils.write_TYPE_MESSAGE(output, taskPriceItem[taskPriceItemIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var taskIdCount:uint = 0;
			var taskTypeCount:uint = 0;
			var taskStateCount:uint = 0;
			var taskPriceCoinsCount:uint = 0;
			var taskPriceZuanCount:uint = 0;
			var taskExpCount:uint = 0;
			var taskNameCount:uint = 0;
			var taskIsTrackCount:uint = 0;
			var taskLvCount:uint = 0;
			var taskTypeNameCount:uint = 0;
			var taskUiDesCount:uint = 0;
			var taskRuningDesCount:uint = 0;
			var taskTagetCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (taskIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++taskIdCount;
					taskId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (taskTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++taskTypeCount;
					taskType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (taskStateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++taskStateCount;
					taskState = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (taskPriceCoinsCount != 0) {
						throw new IOError('Bad data format.');
					}
					++taskPriceCoinsCount;
					taskPriceCoins = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (taskPriceZuanCount != 0) {
						throw new IOError('Bad data format.');
					}
					++taskPriceZuanCount;
					taskPriceZuan = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (taskExpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++taskExpCount;
					taskExp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (taskNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++taskNameCount;
					taskName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 8:
					if (taskIsTrackCount != 0) {
						throw new IOError('Bad data format.');
					}
					++taskIsTrackCount;
					taskIsTrack = ReadUtils.read_TYPE_INT32(input);
					break;
				case 9:
					if (taskLvCount != 0) {
						throw new IOError('Bad data format.');
					}
					++taskLvCount;
					taskLv = ReadUtils.read_TYPE_INT32(input);
					break;
				case 10:
					if (taskTypeNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++taskTypeNameCount;
					taskTypeName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 11:
					if (taskUiDesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++taskUiDesCount;
					taskUiDes = ReadUtils.read_TYPE_STRING(input);
					break;
				case 12:
					if (taskRuningDesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++taskRuningDesCount;
					taskRuningDes = ReadUtils.read_TYPE_STRING(input);
					break;
				case 13:
					if (taskTagetCount != 0) {
						throw new IOError('Bad data format.');
					}
					++taskTagetCount;
					taskTaget = ReadUtils.read_TYPE_STRING(input);
					break;
				case 14:
					taskDes.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.task.TaskTalk));
					break;
				case 15:
					taskPriceItem.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.task.ItemInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (taskIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (taskTypeCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (taskStateCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (taskPriceCoinsCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (taskPriceZuanCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (taskExpCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (taskNameCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
