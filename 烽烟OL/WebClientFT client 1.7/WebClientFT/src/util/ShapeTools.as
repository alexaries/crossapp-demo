package util
{
	import flash.display.Graphics;
	import flash.geom.Point;

	/**
	 * 普通形状的绘制类，包括三角形，圆形，五角星形等
	 * @author  Yaolx
	 */
	public final class ShapeTools
	{
		public function ShapeTools()
		{
		}

		/**
		 * 绘制三角形  等边三角形
		 * @param graphics 要绘制的目标graphics
		 * @param color,绘制的颜色
		 * @param size 等边三角形的边长
		 * @param lineThickness 三角形边线的宽
		 * @param alpha 透明度
		 * @param startPoint 起始点的位置。
		 */
		public static function drawTriangle(graphics:Graphics, color:uint, size:Number=8, lineThickness:int=1, alpha:Number=0.8, startPoint:Point=null):void
		{
			var startX:Number=0;
			var startY:Number=0;
			if (startPoint != null)
			{
				startX=startPoint.x;
				startY=startPoint.y;
			}
			// size*size -(0.5*size)*(0.5*size)
			var hight:Number=Math.sqrt(3 * size * size / 4)
			//绘制三角形
			graphics.beginFill(color, alpha);
			graphics.lineStyle(lineThickness, color, alpha);
			graphics.moveTo(startX + size * 0.5, startY);
			graphics.lineTo(startX, startY + hight);
			graphics.lineTo(startX + size, startY + hight);
			graphics.lineTo(startX + size * 0.5, startY);
			graphics.endFill();
		}

		/**
		 * 绘制正菱形
		 * @param graphics 要绘制的目标graphics
		 * @param color,绘制的颜色
		 * @param size 等边菱形的边长
		 * @param lineThickness 菱形边线的宽
		 * @param alpha 透明度
		 * @param startPoint 起始点的位置。
		 */
		public static function drawRhombus(graphics:Graphics, color:uint, size:Number=8, lineThickness:int=1, alpha:Number=0.8, startPoint:Point=null):void
		{

			var startX:Number=0;
			var startY:Number=0;
			if (startPoint != null)
			{
				startX=startPoint.x;
				startY=startPoint.y;
			}
			//绘制菱形
			graphics.beginFill(color, alpha);
			graphics.lineStyle(lineThickness, color, alpha);
			graphics.moveTo(startX + size * 0.5, startY);
			graphics.lineTo(startX, startY + size * 0.5);
			graphics.lineTo(startX + size * 0.5, startY + size);
			graphics.lineTo(startX + size, startY + size * 0.5);
			graphics.lineTo(startX + size * 0.5, startY);
			graphics.endFill();
		}

		/**
		 * 绘制星形
		 * @param graphics 要绘制的目标graphics
		 * @param color,绘制的颜色
		 * @param points 星数，即几角星形
		 * @param innerRadius 星形内半径
		 * @param outerRadius 星形外半径
		 * @param centerPoint 星形的中心点位置。
		 * @param angle 星形起始角度
		 * @param lineThickness 星形边线的宽
		 * @param alpha 透明度
		 */
		public static function drawStar(graphics:Graphics, color:uint, points:int=5, innerRadius:Number=5, outerRadius:Number=10, centerPoint:Point=null, angle:Number=0, lineThickness:int=1, alpha:Number=0.8):void
		{
			//默认为中心点为外半径的值
			var x:Number=outerRadius;
			var y:Number=outerRadius;
			if (centerPoint != null)
			{
				x=centerPoint.x;
				y=centerPoint.y;
			}
			var count:Number=Math.abs(points);
			graphics.lineStyle(lineThickness, color, alpha);

			//开始填色
			graphics.beginFill(color, alpha);
			if (count > 2)
			{
				// init vars
				var step:Number, halfStep:Number, start:Number, n:int, dx:Number, dy:Number;
				//计算两点之间距离
				step=(Math.PI * 2) / points;
				halfStep=step / 2;
				//起始角度
				start=(angle / 180) * Math.PI;
				graphics.moveTo(x + (Math.cos(start) * outerRadius), y - (Math.sin(start) * outerRadius));
				//画星状图的边
				for (n=1; n <= count; n++)
				{
					dx=x + Math.cos(start + (step * n) - halfStep) * innerRadius;
					dy=y - Math.sin(start + (step * n) - halfStep) * innerRadius;
					graphics.lineTo(dx, dy);
					dx=x + Math.cos(start + (step * n)) * outerRadius;
					dy=y - Math.sin(start + (step * n)) * outerRadius;
					graphics.lineTo(dx, dy);
				}
			}
			graphics.endFill();
		}

		/**
		 * 绘制正方形
		 * @param graphics 要绘制的目标graphics
		 * @param color,绘制的颜色
		 * @param size 正方形的边长
		 * @param alpha 透明度
		 * @param startPoint 起始点的位置。
		 */
		public static function drawSquare(graphics:Graphics, color:uint, size:Number=8, alpha:Number=0.8, startPoint:Point=null):void
		{
			if (startPoint == null)
			{
				startPoint=new Point(0, 0);
			}
			graphics.beginFill(color, alpha);
			graphics.drawRect(startPoint.x, startPoint.y, size, size);
			graphics.endFill();
		}

		/**
		 * 绘制圆形
		 * @param graphics 要绘制的目标graphics
		 * @param color,绘制的颜色
		 * @param centerPoint 圆形中心点位置
		 * @param radius 圆形半径
		 * @param alpha 透明度
		 */
		public static function drawCircle(graphics:Graphics, color:uint, centerPoint:Point, radius:Number, alpha:Number=0.8):void
		{
			graphics.beginFill(color, alpha);
			graphics.drawCircle(centerPoint.x, centerPoint.y, radius);
			graphics.endFill();
		}

		/**
		 *绘制阴影区域
		 *@param percent时间进度的百分比，用小数表示
		 */

		public static function drawing(graphics:Graphics, percent:Number, halfSideLength:int):void
		{
			/**
			 *绘制阴影区域的颜色(默认为灰色)
			 */
			var coolColor:uint=0;
			/**
			 *绘制阴影区域的透明度
			 */
			var coolAlpha:Number=0.5;

			var lineColor:uint=0x000000;
			var lineBorder:uint=0;
			//边长的一半
			var s:int=halfSideLength;
			//起点横坐标
			var startX:int=s;
			//起点副坐标
			var startY:int=s;
			//角的弧度
			var radian:Number;
			var endX:int;
			var endY:int;
			//绘制灰暗区域
			graphics.lineStyle(lineBorder, lineColor);
			graphics.clear();
			graphics.moveTo(startX, startY);
			graphics.beginFill(coolColor, coolAlpha);
			if (percent <= 0.125)
			{
				radian=2 * Math.PI * percent;
				endX=Math.tan(radian) * s + s;
				endY=2 * s;
				graphics.lineTo(s, 2 * s);
				graphics.lineTo(0, 2 * s);
				graphics.lineTo(0, s);
				graphics.lineTo(0, 0);
				graphics.lineTo(s, 0);
				graphics.lineTo(2 * s, 0);
				graphics.lineTo(2 * s, s);
				graphics.lineTo(2 * s, 2 * s);
				graphics.lineTo(endX, endY);

			}
			else if (percent <= 0.25)
			{
				radian=Math.PI * (0.5 - 2 * percent);
				endX=2 * s;
				endY=Math.tan(radian) * s + s;
				graphics.lineTo(s, 2 * s);
				graphics.lineTo(0, 2 * s);
				graphics.lineTo(0, s);
				graphics.lineTo(0, 0);
				graphics.lineTo(s, 0);
				graphics.lineTo(2 * s, 0);
				graphics.lineTo(2 * s, s);
				graphics.lineTo(endX, endY);
			}
			else if (percent <= 0.375)
			{
				radian=Math.PI * (2 * percent - 0.5);
				endX=2 * s;
				endY=s - Math.tan(radian) * s;
				graphics.lineTo(s, 2 * s);
				graphics.lineTo(0, 2 * s);
				graphics.lineTo(0, s);
				graphics.lineTo(0, 0);
				graphics.lineTo(s, 0);
				graphics.lineTo(2 * s, 0);
				graphics.lineTo(endX, endY);
			}
			else if (percent <= 0.5)
			{
				radian=Math.PI * (1 - 2 * percent);
				endX=s + Math.tan(radian) * s;
				endY=0;
				graphics.lineTo(s, 2 * s);
				graphics.lineTo(0, 2 * s);
				graphics.lineTo(0, s);
				graphics.lineTo(0, 0);
				graphics.lineTo(s, 0);
				graphics.lineTo(endX, endY);
			}
			else if (percent <= 0.625)
			{
				radian=Math.PI * (2 * percent - 1);
				endX=s - Math.tan(radian) * s;
				endY=0;
				graphics.lineTo(s, 2 * s);
				graphics.lineTo(0, 2 * s);
				graphics.lineTo(0, s);
				graphics.lineTo(0, 0);
				graphics.lineTo(endX, endY);
			}
			else if (percent <= 0.75)
			{
				radian=Math.PI * (1.5 - 2 * percent);
				endX=0;
				endY=s - Math.tan(radian) * s;
				graphics.lineTo(s, 2 * s);
				graphics.lineTo(0, 2 * s);
				graphics.lineTo(0, s);
				graphics.lineTo(endX, endY);
			}
			else if (percent <= 0.875)
			{
				radian=Math.PI * (2 * percent - 1.5);
				endX=0;
				endY=s + Math.tan(radian) * s;
				graphics.lineTo(s, 2 * s);
				graphics.lineTo(0, 2 * s);
				graphics.lineTo(endX, endY);
			}
			else if (percent <= 1)
			{
				radian=Math.PI * (2 - 2 * percent);
				endX=s - Math.tan(radian) * s;
				endY=2 * s;
				graphics.lineTo(s, 2 * s);
				graphics.lineTo(endX, endY);
			}
			graphics.endFill();
		}

	}
}