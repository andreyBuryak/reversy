/**
 * Created by a.buryak on 08.02.15.
 */
package com.reversy.main
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;

	[SWF(height="500", width="400", frameRate="60")]
	public class Preloader extends MovieClip
	{
		private static const APPLICATION_CLASS_NAME:String = "com.reversy.main::MainApp";
		private static const PRELOADER_MIN_SHOW_TIME:Number = 500;

		private static var _instance:Preloader;

		private var _mainApp:DisplayObject;
		private var _progressIndicator:MovieClip;
		private var _canDispose:Boolean;

		public function Preloader()
		{
			super();

			if (_instance != null)
			{
				throw new Error("[ERROR] Preloader | Singleton");
			}

			_canDispose = false;

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			stop();

			_instance = this;
		}

		//region static methods
		public static function dispose():void
		{
			if (_instance != null)
			{
				_instance.dispose();
			}
		}
		//endregion

		//region private methods
		private function onAddedToStage(event:Event):void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.color = 0x333333;

			addProgressIndicator();

			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onEnterFrame(event:Event):void
		{
			var bytesLoaded:int = root.loaderInfo.bytesLoaded;
			var bytesTotal:int  = root.loaderInfo.bytesTotal;

			if (bytesLoaded >= bytesTotal)
			{
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				setDisposeTimer();
				createMainApp();
			}
		}

		private function setDisposeTimer():void
		{
			var timer:Timer = new Timer(PRELOADER_MIN_SHOW_TIME, 1);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
		}

		private function onTimer(event:TimerEvent):void
		{
			var timer:Timer = event.currentTarget as Timer;
			if (timer != null)
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, onTimer);
			}

			dispose();
		}

		private function addProgressIndicator():void
		{
			if (_progressIndicator == null)
			{
				_progressIndicator = new ProgressBarMc();
				_progressIndicator.gotoAndStop(1);
			}

			_progressIndicator.x = (stage.stageWidth - _progressIndicator.width) / 2;
			_progressIndicator.y = (stage.stageHeight - _progressIndicator.height) / 2;

			addChild(_progressIndicator);
			_progressIndicator.play();

		}

		private function removeProgressIndicator():void
		{
			if (_progressIndicator != null)
			{
				removeChild(_progressIndicator);
				_progressIndicator = null;
			}
		}

		private function createMainApp():void
		{
			nextFrame();

			var mainClass:Class = getDefinitionByName(APPLICATION_CLASS_NAME) as Class;
			if (mainClass == null)
			{
				throw new Error("[ERROR] Preloader | createMainApp | Definition of " + APPLICATION_CLASS_NAME + " not found");
			}
			else
			{
				_mainApp = new mainClass();
				if (_mainApp == null)
				{
					throw new Error("[ERROR] Preloader | createMainApp | Could not create " + APPLICATION_CLASS_NAME);
				}
				else
				{
					_mainApp.visible = false;
					addChildAt(_mainApp, 0);
				}
			}
		}

		private function dispose():void
		{
			if (_canDispose)
			{
				removeProgressIndicator();

				if (_mainApp != null)
				{
					_mainApp.visible = true;
				}
			}

			_canDispose = true;
		}
		//endregion
	}
}
