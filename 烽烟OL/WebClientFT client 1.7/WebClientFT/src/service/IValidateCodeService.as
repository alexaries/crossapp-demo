package service
{
	public interface IValidateCodeService
	{
		/**
		 * 获取注册时的验证码 
		 * @param actionUrl 获取验证码的URL
		 * 
		 */		
		function getRegistValidateCode(actionUrl:String):void; 
	}
}