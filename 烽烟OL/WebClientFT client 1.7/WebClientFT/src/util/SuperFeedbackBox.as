package util
{
	import flash.display.DisplayObject;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.containers.Box;
	import mx.controls.Image;
	import mx.controls.Text;
	import mx.core.Application;
	import mx.core.IFlexDisplayObject;
	import mx.effects.Tween;
	import mx.managers.PopUpManager;


	/**
	 * SuperFeedbackBox for display message or image at custom position.
	 *
	 */
	public class SuperFeedbackBox extends Box
	{

		public static var instances:ArrayCollection;
		private var feedback_txt:Text;
		private var tween:Tween;
		private var timeoutID:uint;
		private static var marginTop:int;
		private static var sleepTime:int;
		private var _image:Image;

		public function SuperFeedbackBox()
		{
			super();
			
			// close horizontal and vertical scroll both.
			verticalScrollPolicy="off";
			horizontalScrollPolicy="off";

			mouseEnabled=false;
			mouseFocusEnabled=false;
			mouseChildren=false;
		}


		/**
		 * Shows a Feedback Box with the message.
		 *
		 * @param object could be a string or a icon.
		 *
		 */
		public static function show(obj:Object, positionX:int, positionY:int):void
		{
			if (!instances)
			{
				instances=new ArrayCollection();
			}
			var box:SuperFeedbackBox=new SuperFeedbackBox();
			PopUpManager.addPopUp(box as IFlexDisplayObject, Application.application as DisplayObject, false);

			if (obj is String)
			{
				box.text=obj as String;

			}
			else if (obj is Class)
			{
				box.setImage(obj as Class);

			}
			else
			{
				throw new Error('param type error ');
			}


			PopUpManager.centerPopUp(box as IFlexDisplayObject);
			if (instances.length)
			{
				var cursor:IViewCursor=instances.createCursor();
				var instance:SuperFeedbackBox;
				while (!cursor.afterLast)
				{
					instance=cursor.current as SuperFeedbackBox;
					positionY=Math.max(positionY, instance.y + instance.height + 12);
					cursor.moveNext();
				}
			}

			// show text at specified position (topMargin)
			box.move(positionX, positionY);
			box.alpha=0;
			box.fadeIn();
			instances.addItem(box);
		}


		/**
		 * @set.
		 */
		protected function setImage(value:Class):void
		{
			_image.source=value;
		}
		
		
		/**
		 * @private
		 *
		 */
		private static function onFadeIn(instance:SuperFeedbackBox):void
		{
			instance.timeoutID=setTimeout(instance.fadeOut, sleepTime);

		}



		/**
		 * @private
		 *
		 */
		private static function onFadeOut(instance:SuperFeedbackBox):void
		{
			if (instance.timeoutID)
			{
				clearTimeout(instance.timeoutID);
			}
			instances.removeItemAt(instances.getItemIndex(instance));
			PopUpManager.removePopUp(instance);
		}



		/**
		 * The string that is displayed in the FeedbackBox.
		 *
		 * <p>You shouldn't have to set this directly. Use <code>FeedbackBox.show()</code> instead.</p>
		 *
		 * @return String
		 *
		 */
		protected function get text():String
		{
			return feedback_txt.text;
		}



		/**
		 * @private
		 *
		 */
		protected function set text(text:String):void
		{

			feedback_txt.text=text;

			// get style from configure file or some other way to fetch 
			// the style properties.
			marginTop=getStyle('topMargin');
			sleepTime=getStyle('sleep');

		}



		/**
		 * Causes the FeedbackBox to fade in.
		 *
		 * <p>You shouldn't have to call this directly. Use <code>FeedbackBox.show()</code> instead.</p>
		 *
		 */
		protected function fadeIn():void
		{
			if (tween)
			{
				tween.stop();
			}
			tween=new Tween(this, 0, 100, 500, -1, updateTween, endTween);
		}




		/**
		 * Causes the FeedbackBox to fade out.
		 *
		 * <p>You shouldn't have to call this directly. Use <code>FeedbackBox.show()</code> instead.</p>
		 *
		 */
		private function fadeOut():void
		{
			if (tween)
			{
				tween.stop();
			}
			tween=new Tween(this, 100, 0, 500, -1, updateTween, endTween);
		}



		/**
		 * @private
		 *
		 */
		private function updateTween(val:int):void
		{
			alpha=val / 100;
		}




		/**
		 * @private
		 *
		 */
		private function endTween(val:Object):void
		{
			tween=null;
			if (alpha)
			{
				onFadeIn(this);
			}
			else
			{
				onFadeOut(this);
			}
		}



		/**
		 * @inheritdoc.
		 *
		 */
		protected override function createChildren():void
		{
			super.createChildren();
			
			feedback_txt=new Text;
			feedback_txt.mouseEnabled=false;
			feedback_txt.mouseFocusEnabled=false;

			addChild(feedback_txt);
			
			_image=new Image();
			addChild(_image);
		}

	}
}