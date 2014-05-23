package util
{
	import flash.display.DisplayObject;
	import flash.utils.*;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.containers.Box;
	import mx.controls.Text;
	import mx.core.Application;
	import mx.core.FlexGlobals;
	import mx.core.IFlexDisplayObject;
	import mx.effects.Tween;
	import mx.managers.PopUpManager;

	/**
	 * Special the top margin of feedback box, this style property suggest be configured at
	 * CSS file, cause the this property effect all the feedback box.
	 *
	 */
	[Style(name="topMargin", type="int", inherit="no")]

	/**
	 * Special the top sleep time of each two feedback box displeard, this style property suggest be configured at
	 * CSS file, cause the this property effect all the feedback box.
	 *
	 */
	[Style(name="sleep", type="int", inherit="no")]



	/**
	 * FeedbackBox is a modal box with a simple notification message for non intrusive notification.
	 *
	 * <p>It is designed to display messages into information displays using modeless feedback.
	 * Modeless feedback allows you to integrate information into the user's flow without breaking her flow.</p>
	 *
	 * You could set the style using CSS configure.
	 * or you could just paste the following code onto your css config file
	 *
	 * <pre>
	 * 	FeedbackBox {
	 *  	backgroundAlpha: 0.5;
	 *		backgroundColor: #000000;
	 * 		borderColor: #FFFFFF;
	 *		borderStyle: solid;
	 *		borderThickness: 2;
	 *		color: #FFFFFF;
	 *		cornerRadius: 8;
	 *		paddingBottom: 6;
	 *		paddingLeft: 6;
	 *		paddingRight: 6;
	 *		paddingTop: 6;
	 *		font-size: 18;
	 *		dropShadowEnabled: true;
	 *		topMargin: 90;
	 * 		sleep: 1000;
	 *	}
	 * </pre> as your default FeedbackBox style.
	 *
	 *
	 */
	public class FeedbackBox extends Box
	{

		public static var instances:ArrayCollection;
		private var feedback_txt:Text;
		private var tween:Tween;
		private var timeoutID:uint;
		private static var marginTop:int;
		private static var sleepTime:int;


		/**
		 * Constructor.
		 *
		 */
		public function FeedbackBox()
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
		 * @param message String to display.
		 *
		 */
		public static function show(message:String):void
		{
			if (!instances)
			{
				instances=new ArrayCollection();
			}
			var box:FeedbackBox=new FeedbackBox();
			PopUpManager.addPopUp(box as IFlexDisplayObject, FlexGlobals.topLevelApplication as DisplayObject, false);
			box.text=message;
			PopUpManager.centerPopUp(box as IFlexDisplayObject);
			if (instances.length)
			{
				var cursor:IViewCursor=instances.createCursor();
				var instance:FeedbackBox;
				while (!cursor.afterLast)
				{
					instance=cursor.current as FeedbackBox;
					marginTop=Math.max(marginTop, instance.y + instance.height + 12);
					cursor.moveNext();
				}
			}

			// show text at specified position (topMargin)
			box.move(box.x, marginTop);
			box.alpha=0;
			box.fadeIn();
			instances.addItem(box);
		}



		/**
		 * @private
		 *
		 */
		private static function onFadeIn(instance:FeedbackBox):void
		{
			instance.timeoutID=setTimeout(instance.fadeOut, sleepTime);

		}



		/**
		 * @private
		 *
		 */
		private static function onFadeOut(instance:FeedbackBox):void
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
		 * @inheritDoc
		 *
		 */
		override protected function createChildren():void
		{
			super.createChildren();

			feedback_txt=new Text;
			feedback_txt.mouseEnabled=false;
			feedback_txt.mouseFocusEnabled=false;

			addChild(feedback_txt);
		}
	}
}