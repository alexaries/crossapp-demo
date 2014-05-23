package component
{
	import mx.controls.TextArea;
	
	import spark.filters.GlowFilter;

	public class CrotaBasicChatTextArea extends TextArea
	{
		public function CrotaBasicChatTextArea()
		{
			super();
			var growFilte:GlowFilter = new GlowFilter(0x000000,0.7,2,2,5);
			var arr:Array = new Array();
			arr.push(growFilte);
			this.filters = arr;
		}
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			
			if(verticalScrollBar){
				verticalScrollBar.x = 230;
			}
		}
		//每次刷新滚动条时调用一次setScrollProperties,设置pageSize为0
	   override protected function setScrollBarProperties(totalColumns:int, visibleColumns:int, totalRows:int, visibleRows:int): void  
	   {
			 super .setScrollBarProperties(totalColumns,visibleColumns,totalRows,visibleRows);
			 if (verticalScrollBar)verticalScrollBar.setScrollProperties( 28 ,verticalScrollBar.minScrollPosition,verticalScrollBar.maxScrollPosition, 0 );
       }
	}
}