package util
{

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BevelFilter;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.net.FileFilter;
	import flash.utils.Timer;

	/**
	 * 	滤镜工具类
	 	斜角滤镜（BevelFilter 类） 
		模糊滤镜（BlurFilter 类） 
		投影滤镜（DropShadowFilter 类） 
		发光滤镜（GlowFilter 类） 
		渐变斜角滤镜（GradientBevelFilter 类） 
		渐变发光滤镜（GradientGlowFilter 类） 
		颜色矩阵滤镜（ColorMatrixFilter 类） 
		卷积滤镜（ConvolutionFilter 类） 
		置换图滤镜（DisplacementMapFilter 类）*/	
	public class FilterTool extends Sprite
	{
		private var _sprite:DisplayObject;	//保存传入DisplayObject对象sprite
		private var strength:Number = 0;	//强度值
		private var add:Number = 0;			//增量
		private var _index:Number = 0;		//保存传入index标记滤镜效果选择
		private var _flashTimer:Timer;		//闪动timer
		private var _overFlashTimer:Timer;	//鼠标经过timer
		private var _firstOverflg:Boolean = true;	//判断鼠标是否第一次经过

		    			
		public function FilterTool($sprite:DisplayObject,$index:Number)
		{	
			this._sprite = $sprite;
			this._index  = $index;
			if(_index<10){//小于10的滤镜为鼠标经过发光滤镜,大于则为闪动滤镜
				_sprite.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
				_sprite.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
			}else{
				add = 0.1;		//修改增量值可改变闪动的速度
				_flashTimer = new Timer(0.04,0);				
				_flashTimer.addEventListener(TimerEvent.TIMER,enFlash);
				_flashTimer.start();
			}			
		}		
		
		//闪动停止
		public function stopFlash():void{
			_flashTimer.stop();
			_flashTimer.removeEventListener(TimerEvent.TIMER,enFlash);
			_sprite.filters = [];
		}
		
		//鼠标经过
		private function onMouseOver(e:MouseEvent):void{				
			add = 0.5;
			if(_firstOverflg == true){
				_firstOverflg = false;
				_overFlashTimer = new Timer(0.04,0);				
				_overFlashTimer.addEventListener(TimerEvent.TIMER,enOverFlash);	
				_overFlashTimer.start();
			}		
		}
		
		//鼠标离开
		private function onMouseOut(e:MouseEvent):void{
			add = -0.5;			
		}
		
		//鼠标经过改变strength参数
		private function enOverFlash(e:Event):void{
			strength += add;
			if(strength>5||strength<0){
				strength = strength>5?5:0;	
			}
			_sprite.filters = this["filter"+_index];
		}
		
		//闪动滤镜改变strength
		private function enFlash(e:Event):void{
			strength += add;
			if(strength>3||strength<-2){	//此处strength小于的负数越小.无颜色的时间越长
				strength = strength>3?3:0;	
				add = -add;
			}
			_sprite.filters = this["filter"+_index];
		}
//==============================================================================================================
//鼠标经过滤镜效果
		//较粗蓝色滤镜
		public function get filter1():Array{
			//边缘颜色，alpha,横向模糊度，纵向模糊度，边缘强度，应用滤镜次数,内侧是否发光,是否挖空 				
			var _filter:GlowFilter = new GlowFilter(0x15C6D6,1,20,15,strength,1,true,false);
			return [_filter];
		}
		//较粗红色滤镜
		public function get filter2():Array{
			//边缘颜色，alpha,横向模糊度，纵向模糊度，边缘强度，应用滤镜次数,内侧是否发光,是否挖空 
			var _filter:GlowFilter = new GlowFilter(0xff0000,1,20,15,strength,1,true,false);
			return [_filter];
		}
		//细边蓝色滤镜
		public function get filter3():Array{
			//边缘颜色，alpha,横向模糊度，纵向模糊度，边缘强度，应用滤镜次数,内侧是否发光,是否挖空 
			var _filter:GlowFilter = new GlowFilter(0x15C6D6,1,4,4,strength,1,true,false);
			return [_filter];
		}
//===================================================================================================================
//闪动滤镜效果
		//外侧红色闪动滤镜
		public function get filter11():Array{
			//边缘颜色，alpha,横向模糊度，纵向模糊度，边缘强度，应用滤镜次数,内侧是否发光(false为外侧发光),是否挖空 
			var _filter:GlowFilter = new GlowFilter(0xff0000,1,20,15,strength,1,false,false);
			return [_filter];
		}
		//内侧蓝色闪动滤镜
		public function get filter12():Array{
			//边缘颜色，alpha,横向模糊度，纵向模糊度，边缘强度，应用滤镜次数,内侧是否发光(false为外侧发光),是否挖空 
			var _filter:GlowFilter = new GlowFilter(0x15C6D6,1,30,20,strength,1,true,false);
			return [_filter];
		}

		
//====================================================================================================================
//静态效果
		/**
		 * 使用 ColorTransform 类调整显示对象的颜色值。 可以将颜色调整或颜色转换应用于所有四种通道：红色、绿色、蓝色和 Alpha 透明度 
		 * 
		 */	
		public static function colorTransform(			$redMultiplier:Number = 1,			
														$greenMultiplier:Number = 1,
														$blueMultiplier:Number = 1,
														$alphaMultiplier:Number=1,
														$redOffset:Number=255,		
														$greenOffset:Number=0,
														$blueOffset:Number=0,
														$alphaOffset:Number=0			):ColorTransform{		
			//新x值 = (旧x值 * xMultiplier) + xOffset
			//xMultiplier为1时保留原有通道颜色,为0时则移除原通道颜色.xOffset为相应通道偏移量
			var _colorTransform:ColorTransform = new ColorTransform($redMultiplier,$greenMultiplier,$blueMultiplier,$alphaMultiplier,$redOffset,$greenOffset,$blueOffset,$alphaOffset);
			return _colorTransform;
		}
		/**
		 * 使用 ColorMatrixFilter 类可以将 4 x 5 矩阵转换应用于输入图像上的每个像素的 RGBA 颜色和 Alpha 值，
		 * 以生成具有一组新的 RGBA 颜色和 Alpha 值的结果。 该类允许饱和度更改、色相旋转、亮度为 Alpha 以及各种其它效果。  
		 */		
		public static function colorMatrixFilter():Array{
			var _matrix:Array = [];
			_matrix = _matrix.concat([0, 0, 0, 0, 0]); // red
			_matrix = _matrix.concat([0, 1, 0, 0, 0]); // green
			_matrix = _matrix.concat([0, 0, 0, 0, 0]); // blue
			_matrix = _matrix.concat([0, 0, 0, 1, 0]); // alpha
			var _filter:ColorMatrixFilter=new ColorMatrixFilter(_matrix);
			return [_filter];
		}	
		/**
		 * 使用 GlowFilter 类可以对显示对象应用发光效果。 有多个用于发光样式的选项，包括内侧发光或外侧发光以及挖空模式。
		 * 
		 */		
		public static function glowFilter(			$color:uint = 0x0000ff, 
													$alpha:Number = 1.0, 
													$blurX:Number = 30.0, 
													$blurY:Number = 30.0, 
													$strength:Number = 5, 
													$quality:int = 1, 
													$inner:Boolean = true, 
													$knockout:Boolean = false			):Array{
			//边缘颜色，alpha,横向模糊度，纵向模糊度，边缘强度，应用滤镜次数,内侧是否发光,是否挖空 
			var _filter:GlowFilter=new GlowFilter($color,$alpha,$blurX,$blurY,$strength,$quality,$inner,$knockout);
			return [_filter];
		}
		/**
		 * 使用 BevelFilter 类对显示对象添加斜角效果。 斜角效果使对象（如按钮）具有三维外观。 
		 * 
		 */		
		public static function bevelFilter():Array
		{
			//斜角偏移距离，斜角的角度，斜角的加亮颜色，加亮颜色的透明度值，斜角的阴影颜色，阴影颜色的透明度值，水平模糊量，垂直模糊量，强度，应用滤镜的次数，斜角在对象上的位置，是否挖空 
			var _filter:BevelFilter = new BevelFilter(30,15,0xff0000,1,0x00ff00,1,40,40,1,1,"inner",false);
			return [_filter];	
		}
		/**
		 * 使用 BlurFilter 类将模糊视觉效果应用于显示对象。 模糊效果可以柔化图像的细节。
		 * 
		 */		
		public static function blurFilter($blurX:Number = 0, $blurY:Number = 0, $quality:int = 1):Array
		{
			//水平模糊量，垂直模糊量，应用滤镜次数（执行模糊次数）
			var _filter:BlurFilter = new BlurFilter($blurX,$blurY,$quality);
			return [_filter];		
		}
		
		//字体阴影滤镜		
		public static function dropShadowFilter():Array{
			var filter:DropShadowFilter = new DropShadowFilter();     //字体阴影滤镜			
			return [filter];		
		}		
		
		//矩阵控制偏移缩放
		public static function matrix(a:Number = 1,b:Number = 0,c:Number = 0,d:Number = 1,tx:Number = 0,ty:Number = 0):Matrix{			
			var _matrix:Matrix = new Matrix(a,b,c,d,tx,ty);
			return _matrix;
		}


		
	}
}