package util
{
	import com.netease.protobuf.Int64;
	import com.netease.protobuf.UInt64;
	
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.filters.BitmapFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	import flashx.textLayout.operations.InsertTextOperation;
	import flashx.textLayout.operations.PasteOperation;
	import flashx.textLayout.operations.RedoOperation;
	import flashx.textLayout.operations.SplitParagraphOperation;
	
	import model.ProConst;
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Image;
	import mx.controls.Menu;
	import mx.core.UIComponent;
	import mx.events.MenuEvent;
	import mx.formatters.CurrencyFormatter;
	import mx.formatters.DateFormatter;
	
	import proto.ItemsInfo;
	import proto.Suite;
	
	import resource.CrotaItemConfig;
	import resource.CrotaResourceConfig;
	
	import sceneModule.model.vo.itemsVo.PackageSuite;
	import sceneModule.model.vo.packageVo.PackageItem;
	
	import spark.events.TextOperationEvent;

	public final class CommonTools
	{
		public function CommonTools()
		{
		}
		
		public static const TIPS:Array = [
			"군단마다 전용 던전과 상점이 있습니다",
			"군단계급 레벨이 높을수록 수용가능한 군단원 수가 많아집니다!!!",
			"기부 금화가 많을 수록 길드는 더욱 강해집니다",
			"군단에 가입하면 군단원들의 도움을 받아 더욱 강해질 수 있습니다",
											]
		
		

		/**
		 * 将Int64 转换为Number类型。
		 * 注意：此处有个值的范围，太大可能有问题。
		 */
		public static function readInt64(value:Int64):Number
		{
			if (!value)
				return 0;

			var a1:int;
			var a2:uint;
			var num:Number=0.0;
			a1=value.high;
			a2=value.low;

			num=Number(a1) * (1 << 16) * (1 << 16);
			num+=a2;
			return num;
		}

		/**
		 *将Number类型转换为Int64
		 *注意：此处有个值的范围，太大可能有问题。
		 */
		public static function writeInt64(value:Number):Int64
		{
			var a1:int;
			var a2:uint;
			//把一个long整型数据拆分成两个int型数据发送 a1为高4位,a2为低4位
			a1=value / (1 << 30) / 4;
			if (value < 0 && a1 == 0)
			{
				a1=-1;
			}
			a2=value - a1 * (1 << 30) * 4;
			var int64Value:Int64=new Int64(a2, a1);
			return int64Value;
		}

		/**
		 * 将UInt64 转换为Number类型。
		 * 注意：此处有个值的范围，太大可能有问题。
		 */
		public static function readUInt64(value:UInt64):Number
		{
			var a1:uint;
			var a2:uint;
			var num:Number=0.0;
			a1=value.high;
			a2=value.low;

			num=Number(a1) * (1 << 16) * (1 << 16);
			num+=a2;
			return num;
		}

		/**
		 *将Number类型转换为UInt64
		 *注意：此处有个值的范围，太大可能有问题。
		 */
		public static function writeUInt64(value:Number):UInt64
		{
			var a1:uint;
			var a2:uint;
			//把一个long整型数据拆分成两个int型数据发送 a1为高4位,a2为低4位
			a1=value / (1 << 30) / 4;
			//			if (value < 0 && a1 == 0)
			//			{
			//				a1=-1;
			//			}
			a2=value - a1 * (1 << 30) * 4;
			var uint64Value:UInt64=new UInt64(a2, a1);
			return uint64Value;
		}

		//时间格式  按秒计算
		public static function formateTimeToString2(time:Number):String
		{
			var hour:int;
			var min:int;
			var sec:int;
			var hourStr:String;
			var minStr:String;
			var secStr:String;
			var timeString:String="";
			hour=time / 3600;
			min=time / 60 - hour * 60;
			sec=time - hour * 3600 - min * 60;
			if (hour < 10)
			{
				hourStr="0" + hour;
			}
			else
			{
				hourStr="" + hour;
			}
			if (min < 10)
			{
				minStr="0" + min;
			}
			else
			{
				minStr="" + min;
			}
			if (sec < 10)
			{
				secStr="0" + sec;
			}
			else
			{
				secStr="" + sec;
			}
			timeString=hourStr + ":" + minStr + ":" + secStr;
			return timeString;

		}


		/**
		 * 将日期按照指定的格式转换成字符串。
		 * @param time Number Date.time的时间，从January 1, 1970 0:00:000 GMT算起
		 * @param format String 默认为"MM-DD JJ:NN:SS"
		 * 注意：这里应为 JJ(0-23):NN:SS 而不是 HH(1-24):NN:SS
		 */
		public static function formatDateToString(time:Number, format:String="YYYY년MM월DD일 JJ:NN:SS"):String
		{
			var dateFormatter:DateFormatter=new DateFormatter();
			dateFormatter.formatString=format;
//			trace("current time:" + new Date().time + "your time:" + time);
			return dateFormatter.format(new Date(time));
		}

		/**
		 *	将毫秒转化为 天/时/分/秒/
		 * @ mil  毫秒
		 */
		public static function formatChangeMinToHour(mil:Number):String
		{
			var dateStr:String="";
			var dayInt:int=0;
			var hourInt:int=0;
			var minuteInt:int=0;
			var secondInt:int=0;
			secondInt=mil / 1000;
			if (secondInt > 60)
			{
				minuteInt=secondInt / 60;
				secondInt=secondInt % 60;
			}
			if (minuteInt > 60)
			{
				hourInt=minuteInt / 60;
				minuteInt=minuteInt % 60;
			}
			if (hourInt > 24)
			{
				dayInt=hourInt / 24;
				hourInt=hourInt % 24;
			}
			dateStr=dayInt + CrotaResourceConfig.getInstance().getTextByModuleAndId('commontool','ct_tian') + hourInt + CrotaResourceConfig.getInstance().getTextByModuleAndId('commontool','ct_shi') + minuteInt + CrotaResourceConfig.getInstance().getTextByModuleAndId('commontool','ct_fen') + secondInt +CrotaResourceConfig.getInstance().getTextByModuleAndId('commontool','ct_miao');
			return dateStr;
		}

		/**
		 *	将字符串转化为数组
		 */
		public static function changeStringToArray(str:String):Array
		{
			var arr:Array;
			if (str != null)
			{
				arr=str.split(',');
			}
			return arr;
		}

		/**
		 * Change image color, default color is black-white.
		 *
		 */
		public static function changeColorFilter(t:Number=0.975):BitmapFilter
		{
			t=t ? t : 1;
			var r:Number=0.212671;
			var g:Number=0.715160;
			var b:Number=0.072169;
			return new ColorMatrixFilter([t * r + 1 - t, t * g, t * b, 0, 0, t * r, t * g + 1 - t, t * b, 0, 0, t * r, t * g, t * b + 1 - t, 0, 0, 0, 0, 0, 1, 0]);
		}
		
		public static function onMailContentChange(evt:TextOperationEvent):void{
			if(evt.operation as InsertTextOperation)
			{
				var input:String=(evt.operation as InsertTextOperation).text;
				
				if((ByteArrayUtil.__getStringBytesLength(evt.target.text,"gb2312") + ByteArrayUtil.__getStringBytesLength(input,'gb2312')) > evt.target.maxChars)
				{
					getLengthStringAddToTextArea(input,evt);
					evt.preventDefault();
				}
			}else if(evt.operation as PasteOperation){
				var clipStr:String = Clipboard.generalClipboard.getData(ClipboardFormats.TEXT_FORMAT) as String;
				if((ByteArrayUtil.__getStringBytesLength(evt.target.text,"gb2312") + ByteArrayUtil.__getStringBytesLength(clipStr,'gb2312')) > evt.target.maxChars)
				{
					getLengthStringAddToTextArea(clipStr,evt);
					evt.preventDefault();
				}
			}else if(evt.operation as SplitParagraphOperation){
				evt.preventDefault();
				evt.stopPropagation();
			}
			
		}
		/**
		 * 获取指定长度的字符串添加到邮件信息尾部
		 */
		public static function getLengthStringAddToTextArea(changeStr:String,evt:Event):void{
			var remainCount:int = evt.target.maxChars - ByteArrayUtil.__getStringBytesLength(evt.target.text,"gb2312");
			evt.target.text += ByteArrayUtil.getStringOnNumberBytes(changeStr,'gb2312',remainCount);
		}
        /**
		 * 货币格式化
		 */
		public static function setMoneyCurrencyFormatter(money:int):String{
			if(money>0){
				var cf:CurrencyFormatter = new CurrencyFormatter();
				cf.currencySymbol = "";//设置转换的货币符号
				cf.alignSymbol = "left";//设置货币符号的位置
				//			cf.precision = 2;//设置精确位数
				cf.thousandsSeparatorTo = ",";//设置千位的分隔符
				cf.decimalSeparatorTo = ".";//设置小数的分隔符
				cf.useThousandsSeparator = true;//这个默认为false ，需要手动设置才能起效
				cf.useNegativeSign = true;//如果为true 负数就直接在前面加-
				return cf.format(money);  
			}
			return '0';
		}
		
		public static function getRoleProfession(profession:int):String{
			var professionStr:String;
			switch(profession){
				case ProConst.WARRIOR:
					professionStr = CrotaResourceConfig.getInstance().getTextByModuleAndId('pack','mmeT_zs');
					break;
				case ProConst.RANGER:
					professionStr = CrotaResourceConfig.getInstance().getTextByModuleAndId('pack','mmeT_yx');
					break;
				case ProConst.PASTOR:
					professionStr = CrotaResourceConfig.getInstance().getTextByModuleAndId('pack','mmeT_ms');
					break;
				case ProConst.MAGE:
					professionStr = CrotaResourceConfig.getInstance().getTextByModuleAndId('pack','mmeT_fashi');
					break;
			}
			return professionStr;
		}
		
		public static function get_tips():String {
			var r_num:int = Math.random() * TIPS.length;
			var r:String = CrotaResourceConfig.getInstance().getTextByModuleAndId('commontool','ct_tips') + CrotaResourceConfig.getInstance().getTextByModuleAndId('commontool','ct_tip'+r_num.toString());
			return r;
		}
		
		
		public static function get_format_str(str:String, args:Array = null):String {
			var r:String = str;
			if (null != args) {
				var arglen:int = args.length;
				for (var i:int = 0; i < arglen; i++) 
				{
					var arg:String = args[i];
					r = r.replace("%s", arg);
				}
			}
			return r;
		}
		
		public static function make_bitmap(img:Image):Bitmap {
		 var bm:Bitmap;
		 if (null == img.source as Bitmap) {
			bm = new Bitmap();
			img.source = bm;
		 }
		 else {
			bm = img.source as Bitmap;
		 }
		 return bm;
		}
		
		public static function setEquipmentUrl(s:int,t:int):String{
			if(t == 0){
				return '';
			}else{
				var url:String = ProConst.getImageResUrl(t);
				url += (s + '.png');
				return url
			}
		}
		
		public static function getEquipmentPos(itemId:int):Point{
			var startX:int = 695;
			var startY:int = 115;
			var l:int = SystemDataModel.packageinfoVo.packageInfoColl.length;
			var item_pos:int;
			for(var i:int = 0;i < l;i++){
				if(SystemDataModel.packageinfoVo.packageInfoColl[i].id == itemId){
					item_pos = SystemDataModel.packageinfoVo.packageInfoColl[i].position;
					break;
				}
			}
			var h_index:int = (item_pos % 6 ) + 1;
			var v_index:int = item_pos - (h_index -1)*6 + 1;
			return new Point(startX+(h_index-1)*42,startY+(v_index-1)*42);
		}
		
		public static function get_equipement_color(type:int):uint {
			var color:uint = 0xffffff;
			switch(type){
					case 1:
						color=0x00FF00;
						break;
					case 2:
						color=0x00FFFF;
						break;
					case 3:
						color=0x9900FF;
						break;
					case 4:
						color=0xFFFF00;
						break;
					case 5:
						color=0xFF6600;
						break;
					case 6:
						color=0xFF0000;
						break;
					case 7:
						color=0xFF00CC;
						break;
				}
				return color;
		}
		
		public static function get_wowName_color(type:int):uint {
			var color:uint = 0xffffff;
			switch(type){
				case 0:
					color=0x00FF00;
					break;
				case 1:
					color=0x00FFFF;
					break;
				case 2:
					color=0x9900FF;
					break;
				case 3:
					color=0xFFFF00;
					break;
				case 4:
					color=0xFF0000;
					break;
				case 5:
					color=0xFF00CC;
					break;
			}
			return color;
		}
		
		public static function get_equipement_color_html(type:int):String{
			var color:String = '#ffffff';
			switch(type){
				case 1:
					color='#00FF00';
					break;
				case 2:
					color='#00FFFF';
					break;
				case 3:
					color='#9900FF';
					break;
				case 4:
					color='#FFFF00';
					break;
				case 5:
					color='#FF6600';
					break;
				case 6:
					color='#FF0000';
					break;
				case 7:
					color='#FF00CC';
					break;
			}
			return color;
		}
		
		public static function convert_item_info(itemInfo:ItemsInfo, pos:int = 0):PackageItem {
			var packageInfoVo:PackageItem = CrotaItemConfig.getItemInfoByTempleteId(itemInfo.templateId);
			PackageIitemInfoSettingUtil.setItemDefaultInfo2(packageInfoVo,itemInfo);
			packageInfoVo.position = pos;
			return packageInfoVo;
		}
		
		public static function getJobImg(profession:int):String{
			var r:String = null;
			switch (profession) 
			{
				case 1:
					r = "assets/word_map/ZS";
					break;
				case 2:
					r = "assets/word_map/FS";
					break;
				case 3:
					r = "assets/word_map/YX";
					break;
				case 4:
					r = "assets/word_map/ZSO";
					break;
				case 5:
					r = "assets/word_map/FSO";
					break;
				case 6:
					r = "assets/word_map/YXO";
					break;
				
				default:
					r = null;
			}
			return r;
		}
		
		public static function createTF():TextField {
			var tf:TextField = new TextField();
			tf.selectable = false;
			tf.autoSize = TextFieldAutoSize.LEFT;
			return tf;
		}
		
		public static function createFTF():TextField {
			var tf:TextField = new TextField();
			tf.selectable = false;
			tf.autoSize = TextFieldAutoSize.LEFT;
			var growFilte:GlowFilter = new GlowFilter(0x34332d ,0.7,2,2,5);
			tf.filters = [growFilte];
			var f:TextFormat = new TextFormat();
			f.color = 0xbebebe;
			f.size = 12;
			tf.defaultTextFormat = f;
			return tf;
		}
		
		public static function createBlackTF():TextField {
			var tf:TextField = new TextField();
			tf.selectable = false;
			tf.autoSize = TextFieldAutoSize.LEFT;
			var growFilte:GlowFilter = new GlowFilter(0x34332d ,0.7,2,2,5);
			tf.filters = [growFilte];
			var f:TextFormat = new TextFormat();
			f.color = 0x0;
			f.size = 12;
			tf.defaultTextFormat = f;
			return tf;
		}
		
		public static function createHuangseTF():TextField {
			var tf:TextField = new TextField();
			tf.selectable = false;
			tf.autoSize = TextFieldAutoSize.LEFT;
			var growFilte:GlowFilter = new GlowFilter(0x34332d ,0.7,2,2,5);
			tf.filters = [growFilte];
			var f:TextFormat = new TextFormat();
			f.color = 0xFFFF00;
			f.size = 12;
			tf.defaultTextFormat = f;
			return tf;
		}
		
		public static function createMoneyTF():TextField {
			var tf:TextField = new TextField();
			tf.selectable = false;
			tf.autoSize = TextFieldAutoSize.LEFT;
			var growFilte:GlowFilter = new GlowFilter(0x34332d ,0.7,2,2,5);
			tf.filters = [growFilte];
			var f:TextFormat = new TextFormat();
			f.color = 0x74725d;
			f.size = 12;
			tf.defaultTextFormat = f;
			return tf;
		}
		//htmltext样式
		public static  function getHtmStr(str:String , color:String="#00ff00",_data:String = '', isLink:Boolean=false, size:uint=12, font:String="宋体", underLine : Boolean = true):String
		{
			var f:String = "<font ";
			var f_ : String = ">";
			var _f : String = "</font>";
			var u_ : String = "<u>";
			var _u : String = "</u>";
			var a : String = "<a href='event:";
			var a_ : String = "'>";
			var _a : String = "</a>";
			var co:String = "color='" + color + "' ";
			var fa:String = "face='" + font + "' ";
			var si:String = "size='" + size.toString() + "'";
			if(isLink)
			{
				/**为了传递 slg任务追踪的任务id 添加 _data  */
				var _str : String = _data.length?_data:str;
				if(underLine) return u_ + a + _str + a_ + f + co + si +  f_ +  str  + _f + _a + _u;
				else return  a + _str + a_ + f + co + si +  f_ +  str  + _f + _a ;
			}
			return f + co + fa + si + f_ +  str  + _f;
		}
		
		public static function onOpenNavigate():void{
			var url:URLRequest = new URLRequest("http://www.bigzhu.com/Payment");
			navigateToURL(url, '_blank');
		}
		
		public static function delayClick():Boolean{
			if(new Date().time - SystemDataModel.preClickFunctionBtnTime >=1000){
				SystemDataModel.preClickFunctionBtnTime = new Date().time;
				return true;
			}
			return false;
		}
		
		public static function getXiangQianReqCoin(lev:int):int{
			return (lev*2500+3000) - (lev*2500+3000)*(SystemDataModel.roleInfo.roletype*0.1);
		}
		
		public static function getZhaiXiaReqCoin(lev:int):int{
			return (lev*1000+3000) - (lev*1000+3000)*(SystemDataModel.roleInfo.roletype*0.1);
		}
		
		public static function getNameColor(color:int):uint	 {
			var nameColor:uint = 0;
			switch(color){
				case 1:
					nameColor=0x00CD00;
					break;
				case 2:
					nameColor=0x0000FF;
					break;
				case 3:
					nameColor=0x00008B;
					break;
				case 4:
					nameColor=0xFFFF00;
					break;
				case 5:
					nameColor=0xFFB90F;
					break;
				case 6:
					nameColor=0xFF0000;
					break;
			}
			return nameColor;
		}
	}
}

