package utility
{
	/**
	 * 通用工具类 
	 * @author mutou
	 * 
	 */	
	public class CommonUtils
	{
		public function CommonUtils()
		{
		}
		
		public static function generateDateCode():Number{
			var dateStr:Number;
			dateStr =new  Date().getTime();
			return dateStr;
		}
		public static function generateRanCode(num:int):String {
			//get num radom 
			var ran:int;
			var number:int;
			var code:String;
			var ranCode:String="";
			var i:int;
			
			for (i=0; i<num; i++) {
				ran=Math.round(Math.random()*2);
				number=Math.round(Math.random()*10000);//get result like 0.1234 
				if (ran==0) {
					code = String.fromCharCode(48+(number % 10));
					//0's ASCII code is 48 、0-9(10)
				} else if (ran==1) {
					code = String.fromCharCode(65+(number % 26)) ;
					// A's ASCII code is 65 、A-Z(26)
				} else {
					code = String.fromCharCode(97+(number % 26)) ;
				}// a's ASCII code is 97 、a-z(26)
				
				ranCode+=code;
			}
			return ranCode;
		}
	}
	
}