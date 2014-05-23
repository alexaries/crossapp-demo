package util
{
	import flash.events.NetStatusEvent;
	import flash.net.*;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	import mx.formatters.DateFormatter;
	
	public class ByteArrayUtil
	{
		
		public function ByteArrayUtil()
		{
		}
		
		public static function getPosLabel(x:int, y:int):String {
			return (x == -1 || y == -1) ? "--" : "["+x + "," + y+"]";
		}
		
		/**
	    * 从ByteArray中以byte序列的方式读取Id
	    */
		public static function readIdBytes(input:ByteArray, idLength:int):ByteArray
		{
			var longBytes:ByteArray = new ByteArray();
			input.readBytes(longBytes, 0, idLength);
			return longBytes;
		}
		
				
		/**
	    * 向ByteArray中以byte序列的方式写入Id
	    */
		public static function writeIdBytes(output:ByteArray, longBytes:ByteArray):void
		{
			output.writeBytes(longBytes, 0, longBytes.length);
		}		
		
		/**
		 * 转换id的byte序列为string
		 */ 
		public static function idBytesToString(longBytes:ByteArray):String 
		{
			var rtnString:String = "";
			var oldPosition:uint = longBytes.position;
			longBytes.position = 0;
			while (longBytes.bytesAvailable > 0) {
				rtnString += "["+longBytes.readByte().toString(16)+"]";
			}
			longBytes.position = oldPosition;
			return rtnString;
		}
        		
		/**
	    * 从ByteArray中读取long型数据
	    */
		public static function readLong(data:ByteArray):Number
		{
			var a1:int;
			var a2:uint;
			var num:Number = 0.0;
			a1=data.readInt();
			a2=data.readUnsignedInt();

			num = Number(a1) * (1 << 16) * (1 << 16);
			num += a2;
			return num;
		}
		
				
		/**
	    * 向ByteArray中写long型数据
	    */
		public static function writeLong(byteArray:ByteArray,data:Number):void
		{
			var a1:int;
			var a2:uint;
			//把一个long整型数据拆分成两个int型数据发送 a1为高4位,a2为低4位
			a1=data /(1 << 30) / 4 ;
			if (data < 0 && a1 == 0) {
				a1 = -1;
			}
			a2=data - a1 * (1 << 30) * 4 ;
			byteArray.writeInt(a1);
			byteArray.writeUnsignedInt(a2);
		}
		
		/**
		 * 弹出指定网址的Web页面
		 * URLString 网址字符串
		 */
		public static function openWebPage(URLString:String):void
		{
			var request:URLRequest = new URLRequest(URLString);
       		navigateToURL(request);
		} 
		 
		/**
		 * 将long类型的用毫秒数表示的一段时间转化为xx小时xx分xx秒的字符串格式
		 * time 毫秒数表示的一段时间
		 */ 
		public static function formateTimeToString(time:Number):String
		{
			var hour:int;
			var min:int;
			var sec:int;
			var timeString:String = "";
			hour = time/3600000;
			min = (time/1000 - hour*3600)/60;
			sec = time/1000 - hour*3600-min*60;
			if (hour > 0) {
				timeString += hour+"小时";
			}
			if (min > 0 || hour > 0) {
				timeString += min +"分"
			}
			timeString += sec + "秒";
			return timeString;
		}
		/**
		 * 将long类型的用毫秒数表示的一段时间转化为xx小时xx分xx秒的字符串格式
		 * time 毫秒数表示的一段时间
		 */ 
		public static function formateTimeToString2(time:Number):String
		{
			var hour:int;
			var min:int;
			var sec:int;
			var timeString:String = "";
			hour = time/3600000;
			min = (time/1000 - hour*3600)/60;
			sec = time/1000 - hour*3600-min*60;
			if (hour > 0) {
				if(hour>=10){
					timeString += hour+":";
				}else{
					timeString += '0'+hour+":";
				}
			}else{
				timeString += "00:";
			}
			if (min > 0 || hour > 0) {
				if(min>=10){
					timeString += min +":"
				}else{
					timeString += '0'+min +":"
				}
			}else{
				timeString += "00:"
			}
			if(sec>=10){
				timeString += sec;
			}else{
				timeString += '0'+sec;
			}
			return timeString;
		}
		/**
		 * 将日期按照指定的格式转换成字符串。
		 * @param time Number Date.time的时间，从January 1, 1970 0:00:000 GMT算起
		 * @param format String 默认为"MM-DD JJ:NN:SS"
		 * 注意：这里应为 JJ(0-23):NN:SS 而不是 HH(1-24):NN:SS
		 */ 
		public static function formatDateToString(time:Number, format:String = "MM-DD JJ:NN:SS"):String {
			var dateFormatter:DateFormatter = new DateFormatter();
			dateFormatter.formatString = format;
			return dateFormatter.format(new Date(time));
		}
		
		/**
		 * 将日期按照指定的格式转换成字符串。
		 * @param time Number Date.time的时间，从January 1, 1970 0:00:000 GMT算起
		 * @param format String 默认为"MM-DD JJ:NN:SS"
		 * 注意：这里应为 JJ(0-23):NN:SS 而不是 HH(1-24):NN:SS
		 */ 
		public static function formatDateToString2(time:Number, format:String = "JJ:NN:SS"):String {
			var dateFormatter:DateFormatter = new DateFormatter();
			dateFormatter.formatString = format;
			return dateFormatter.format(new Date(time));
		}
		/**
		 * 
		 * 将时间转换为模糊时间 
		 * 
		 */		
		 public static function formateDateToBlurTime(time:Number):String{
		 	var timeStr:String = "";
		 	var beforeMinutes:Number = 60*60*1000;
		 	var beforeHours:Number = 48*60*60*1000;
		 	if(time<beforeMinutes){
		 		timeStr = int(time/1000/60)+" 分钟前";
		 	}
		 	if(time>beforeMinutes && time<beforeHours){
		 		timeStr = int(time/1000/60/60) + " 小时前";
		 	}
			if(time>beforeHours){
				timeStr = int(time/1000/60/60/24) + " 天前";
			}
			return timeStr;
		 }
		/**
		 * 把得到的Number型数字转换成int型，
		 * 取小数点后位，如果小数点后六位有数，则向上加１
		 */
		public static function parseNumber(num:Number):int{
			var formateNum:int;
			var intFromNumber:int = int(num);
			var numMinusIntFromNumber:Number = (num - Number(intFromNumber))*1000000; 
			if(int(numMinusIntFromNumber)>0){
				formateNum = int(intFromNumber) + 1;
			}else{
				formateNum = int(intFromNumber);
			}
			return formateNum;
		}		 
		/**
		 * 去掉一个字符串的左边的空格等字符
		 * s 要操作的字符串
		 */ 
		public static function LTrim(s : String) :String{
    	   var i : Number = 0; 
   	       while(s.charCodeAt(i) == 32 || s.charCodeAt(i) == 13 
 				 || s.charCodeAt(i) == 10  || s.charCodeAt(i) == 9) {
    		  i++;
    	   }     	   
   	  	   return s.substring(i,s.length);
 	    }
 	    
  		/**
		 * 去掉一个字符串的右边的空格等字符
		 * s 要操作的字符串
		 */
		public static function RTrim(s : String):String {
		    var i : Number = s.length - 1;
		    while(s.charCodeAt(i) == 32  || s.charCodeAt(i) == 13 
		 		   || s.charCodeAt(i) == 10  || s.charCodeAt(i) == 9) {
		       i--;
		    }  
		    return s.substring(0,i+1);
		 } 
		/**
		 * 去掉字符串左边的0
		 */
		public static function LTrim0(s:String):String{
		   var i : Number = 0; 
   	       while(s.charCodeAt(i) == 48 ) {
    		  i++;
    	   }     	   
   	  	   return s.substring(i,s.length);
		}
  
  		/**
		 * 去掉一个字符串的两边的空格等字符
		 * s 要操作的字符串
		 */
		public static function Trim(s : String):String { 
		    return LTrim(RTrim(s)); 
		} 
		
		
		/**
		 *	保存数据到flash ShareObject
		 *  cookieName:需要保存至ShareObject的记录名称
		 *  data:需要保存的数据
		 */    
	    public static function saveToShareObject(cookieName:String,data:Object):void { 
	   	 
	       	  var mySo:SharedObject = SharedObject.getLocal(cookieName);
	          mySo.clear();
	          mySo.data.data = data;       
	          var flushStatus:String = null;
	          try {
	              flushStatus = mySo.flush();
	          } catch (error:Error) {
	          	  Alert.show('请将flash Player的本地存储大小设置为100k以上');
	              Security.showSettings(SecurityPanel.LOCAL_STORAGE);
	          }
	          if (flushStatus != null) {
	             switch (flushStatus) {
	                case SharedObjectFlushStatus.PENDING:                        
	                    mySo.addEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
	                    break;
	                case SharedObjectFlushStatus.FLUSHED:                        
	                    break;
	                }
	          } 
	    }
	    
	     /*
		 *	处理保存密码到本地的异常问题
		 */    
	    private static function onFlushStatus(event:NetStatusEvent):void {
	           
	        switch (event.info.code) 
	        {
	           case "SharedObject.Flush.Success":                    
	                 break;
	           case "SharedObject.Flush.Failed":
	                 break;
	        }
	        event.target.removeEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
	    }
	    
	    /**
		 *	从flash ShareObject中读取数据
		 *  cookieName:ShareObject的记录名称
		 */    
	    public static function getShareObjectData(cookieName:String):Object {
    	    var data:Object;	           
		    var mySo:SharedObject = SharedObject.getLocal(cookieName);
			data = mySo.data.data;
			return data;   
	    }
		/**
		 * 获取指定字节数数的字符串
		 */
		public static function getStringOnNumberBytes(str:String,charSet:String,len:int):String{
			if(!str)return '';
			var bytes:ByteArray = new ByteArray();
			bytes.writeMultiByte(str,charSet);
			bytes.position = 0;
			var strLen:String=bytes.readMultiByte(len,charSet);
			return strLen;
		}
		/**
		 * 获取该字符串的字节数 
		 */ 
		public static function __getStringBytesLength(str:String,charSet:String):int
		{
			if(!str) return 0;
			var bytes:ByteArray = new ByteArray();
			
			bytes.writeMultiByte(str, charSet);
			
			bytes.position = 0;
			return bytes.length;
			
		}
	}	
}