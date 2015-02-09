/**
 * Created by a.buryak on 08.02.15.
 */
package com.reversy.gui
{
	import com.reversy.gui.topPanel.TopPanel;
	import com.reversy.main.Preloader;

	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;

	public class View extends Sprite
	{
		private var _topPanel:TopPanel;
		private var _field:GameField;
		private var _bottomPanel:BottomPanel;
		private var _background:Sprite;

		public function View()
		{
			super();

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			initBackground();

			_topPanel = new TopPanel();
			addChild(_topPanel);

			_bottomPanel = new BottomPanel();
			_bottomPanel.y = stage.stageHeight - _bottomPanel.height;
			addChild(_bottomPanel);

			_field = new GameField();
			_field.x = (stage.stageWidth - _field.width) / 2;
			_field.y = _topPanel.height + ((_bottomPanel.y - _topPanel.height - _field.height) / 2);
			addChild(_field);


		}

		private function initBackground():void
		{
			var template:Sprite = new GameBackgroundMc();
			var bitmap:BitmapData = new BitmapData(template.width, template.height, true, 0x000000);
			bitmap.draw(template);

			if (_background == null)
			{
				_background = new Sprite();
			}

			_background.graphics.clear();
			_background.graphics.beginBitmapFill(bitmap, null, true, true);
			_background.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			_background.graphics.endFill();

			addChildAt(_background, 0);
		}
	}
}
