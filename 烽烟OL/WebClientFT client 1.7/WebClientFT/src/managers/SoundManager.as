package managers
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import model.ProConst;
	import model.SystemDataModel;
	
	import mx.core.SoundAsset;

	public class SoundManager  
	{  
		/** 
		 * 默认声音大小 
		 */       
		public var defaultVolume:Number=1.0;  
		
		private var activeSound:Dictionary;  
		
		private var _soundOn:Boolean=true;//是否关闭声音,游戏音效  
		private var _bgSoundOn:Boolean=true;//是否关闭背景音乐  
		
		private static var _instance:SoundManager=null;  
		
//		//城镇的声音
//		[Bindable] [Embed(source="../assets/sound/city.mp3")]
//		public static var citySoundEffect:Class;
//		public var myCitySound:SoundAsset = new citySoundEffect() as SoundAsset;
//		
//		//副本的声音
//		[Bindable] [Embed(source="../assets/sound/fuben.mp3")]
//		public static var fubenSoundEffect:Class;
//		public var myfubenSound:SoundAsset = new fubenSoundEffect() as SoundAsset;
//		
//		//UI的声音
//		[Bindable] [Embed(source="../assets/sound/operUI.mp3")]
//		public static var uiSoundEffect:Class;
//		public var myuiSound:SoundAsset = new uiSoundEffect() as SoundAsset;
//		
//		//攻击
//		[Bindable] [Embed(source="../assets/sound/battleAttack.mp3")]
//		public static var attackSoundEffect:Class;
//		public var myAttackSound:SoundAsset = new attackSoundEffect() as SoundAsset;
//		
//		//被攻击
//		[Bindable] [Embed(source="../assets/sound/battleAttacked.mp3")]
//		public static var attackedSoundEffect:Class;
//		public var myAttackedSound:SoundAsset = new attackedSoundEffect() as SoundAsset;
//		
//		//战斗
//		[Bindable] [Embed(source="../assets/sound/battleScene.mp3")]
//		public static var battleSoundEffect:Class;
//		public var myBattleSound:SoundAsset = new battleSoundEffect() as SoundAsset;
		
		public function SoundManager()  
		{  
			activeSound = new Dictionary();  
		}  
		
		
		/** 
		 * 设置全局声音的大小 
		 * @param volume 声音音量 
		 *  
		 */       
		public function setGlobalVolume(volume:Number):void  
		{  
			SoundMixer.soundTransform = new SoundTransform(volume);           
		}  
		/** 
		 * 设置声音的大小 
		 *   
		 * @param name  名称 
		 * @param volume    声音 
		 */   
		public function setVolume(name:String, volume:Number):void  
		{  
			var sc:SoundChannel = getActiveChannel(name);  
			if (sc)  
				sc.soundTransform = new SoundTransform(volume);           
		}  
		/** 
		 *取声音通道  
		 * @param name 
		 * @return  
		 *  
		 */       
		public function getActiveChannel(name:String):SoundChannel  
		{  
			return activeSound[name];  
		}  
		/** 
		 * 设置声音位置 
		 *  
		 * @param name   名称 
		 * @param pan    声音位置，范围由-1到1         
		 */  
		public function setPan(name:String, pan:Number):void  
		{  
			var sc:SoundChannel = getActiveChannel(name);  
			if (sc)  
			{                 
				sc.soundTransform = new SoundTransform(sc.soundTransform.volume,pan);  
			}  
		}  
		
		/** 
		 * 声音是否正在播放 
		 *   
		 * @param name  名称 
		 *  
		 */   
		public function isPlaying(name:String):Boolean  
		{  
			return activeSound[name]!=null;  
		}  
		
		/** 
		 * 停止播放 
		 *   
		 * @param name  名称 
		 */   
		public function stop(name:String):void  
		{  
			var sc:SoundChannel = activeSound[name];  
			delete activeSound[name];  
			
			if (sc)  
			{  
				sc.stop();                
			}  
		}  
		/** 
		 * 停止播放所有正在播放的音乐  
		 *  
		 */    
		private var stopAllFlag:Boolean = false;//停止所有播放
		public function stopAll():void  
		{  
			stopAllFlag = true;
			setGlobalVolume(0);
//			SoundMixer.stopAll();  
		}  
		/**
		 * 开始播放背景音乐 
		 * 
		 */	
		public function startAll():void{
			stopAllFlag = false;
			setGlobalVolume(1);
//			if(SystemDataModel.isBattleStatusFlag){
//				//战斗背景音乐
//				myBattleSound.play(0,int.MAX_VALUE);
//			}else if(ProConst.MAX_CITY_ID >= SystemDataModel.placeId){
//				//城镇背景音乐
//				myCitySound.play(0,int.MAX_VALUE);
//			}else{
//				//副本背景音乐
//				myfubenSound.play(0,int.MAX_VALUE);
//			}
		}
		
		public function loadSound(name:String,startTime:Number=0, loop:int=1, volume:Number=-1):SoundChannel{
			var url:String;
			switch(name){
				case SoundConst.CITY_SOUND:
					url = 'assets/sound/city.mp3';
					break;
				case SoundConst.ATTACK_SOUND:
					url = 'assets/sound/battleAttack.mp3';
					break;
				case SoundConst.ATTACKED_SOUND:
					url = 'assets/sound/battleAttacked.mp3';
					break;
				case SoundConst.FUBEN_SOUND:
					url = 'assets/sound/fuben.mp3';
					break;
				case SoundConst.UI_SOUND:
					url = 'assets/sound/operUI.mp3';
					break;
				case SoundConst.BATTLE_SOUND:
					url = 'assets/sound/battleScene.mp3';
					break;
			}
			var request:URLRequest = new URLRequest(url);
			var soundFactory:Sound = new Sound();
			soundFactory.load(request);
			var song:SoundChannel = soundFactory.play(startTime, (loop != -1)?loop:int.MAX_VALUE);
			return song;
		}
		
		/** 
		 * 播放 
		 *   
		 * @param name  名称 
		 * @param loop  循环次数，-1为无限循环 
		 * @param volume    声音       
		 */       
		public function play(name:String,startTime:Number=0, loop:int=1, volume:Number=-1,panning:Number=0):void  
		{          
//			if(stopAllFlag)return;
			try  
			{  
				var _sc:SoundChannel=activeSound[name];  
				
				if (_sc)  
				{  
					_sc.soundTransform = new SoundTransform(1);  
					return;
				}  

				var channel:SoundChannel = loadSound(name,startTime,loop,volume);
//				switch(name){
//					case SoundConst.CITY_SOUND:
//						channel = myCitySound.play(startTime, (loop != -1)?loop:int.MAX_VALUE);
//						break;
//					case SoundConst.ATTACK_SOUND:
//						channel = myAttackSound.play(startTime, (loop != -1)?loop:int.MAX_VALUE);
//						break;
//					case SoundConst.ATTACKED_SOUND:
//						channel = myAttackedSound.play(startTime, (loop != -1)?loop:int.MAX_VALUE);
//						break;
//					case SoundConst.FUBEN_SOUND:
//						channel = myfubenSound.play(startTime, (loop != -1)?loop:int.MAX_VALUE);
//						break;
//					case SoundConst.UI_SOUND:
//						channel = myuiSound.play(startTime, (loop != -1)?loop:int.MAX_VALUE);
//						break;
//					case SoundConst.BATTLE_SOUND:
//						channel = myBattleSound.play(startTime, (loop != -1)?loop:int.MAX_VALUE);
//						break;
//				}
				  
				
				if (channel)  
				{  
					if (loop != 0 && loop != -1)  
						channel.addEventListener(Event.SOUND_COMPLETE, soundCompleteListener);  
					
					activeSound[name] = channel;                      
					channel.soundTransform = new SoundTransform((volume != -1) ? volume : defaultVolume,panning);     
					
//					if(!_soundOn&&name!=SoundConst.ATTACK_SOUND&&name!=SoundConst.ATTACKED_SOUND&&name!=SoundConst.CITY_SOUND&&name!=SoundConst.UI_SOUND&&name!=SoundConst.FUBEN_SOUND)//游戏音效关闭  
//					{  
//						channel.soundTransform = new SoundTransform(0);   
//					}  
//					
//					if(!_bgSoundOn&&(name==SoundConst.ATTACK_SOUND||name==SoundConst.BG1_SOUND))//背景音乐关闭  
//					{  
//						channel.soundTransform = new SoundTransform(0);   
//					}  
				}  
			}  
			catch(e:Error)  
			{  
			}     
		}  
		private function soundCompleteListener(evt:Event):void  
		{  
			evt.currentTarget.removeEventListener(Event.SOUND_COMPLETE, soundCompleteListener);  
			
			for (var key:* in activeSound)  
			{  
				if (activeSound[key] == evt.currentTarget)  
				{  
					delete activeSound[key];  
					return;  
				}     
			}  
			
		}  
		/** 
		 *取SoundManager对象  
		 * @return  
		 *  
		 */       
		public static function getInstance():SoundManager  
		{  
			if(_instance==null)  
				_instance=new SoundManager();  
			
			return _instance;  
		}  
		/** 
		 *是否关闭音乐  
		 * @return  
		 *  
		 */  
		public function get soundOn():Boolean  
		{  
			return _soundOn;  
		}          
		/** 
		 * 是否关闭游戏音效 
		 * @param value 
		 *  
		 */       
		public function set soundOn(value:Boolean):void  
		{  
			if(_soundOn!=value)  
			{  
				_soundOn = value;  
				
				for (var key:* in activeSound)  
				{  
					if (key != SoundConst.ATTACK_SOUND&&key != SoundConst.ATTACKED_SOUND&&key!=SoundConst.UI_SOUND)  
					{  
						var _sc:SoundChannel=activeSound[key];  
						
						if (_sc)  
						{  
							if(!_soundOn)  
								_sc.soundTransform = new SoundTransform(0);   
							else  
								_sc.soundTransform = new SoundTransform(1);   
						}  
					}     
				}                 
			}             
		}  
		
		/** 
		 *是否关闭背景音乐  
		 * @return  
		 *  
		 */       
		public function get bgSoundOn():Boolean  
		{  
			return _bgSoundOn;  
		}         
		/** 
		 * 是否关闭背景音乐  
		 * @param value 
		 *  
		 */       
		public function set bgSoundOn(value:Boolean):void  
		{  
			if(_bgSoundOn!=value)  
			{  
				_bgSoundOn = value;  
				
				if(!_bgSoundOn)  
				{  
					setVolume(SoundConst.UI_SOUND,0);  
					setVolume(SoundConst.FUBEN_SOUND,0);  
				}  
				else  
				{  
					setVolume(SoundConst.UI_SOUND,1);  
					setVolume(SoundConst.FUBEN_SOUND,1);  
				}  
			}  
		}       
	}
}