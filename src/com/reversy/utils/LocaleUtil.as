/**
 * Created by a.buryak on 09.02.15.
 */
package com.reversy.utils
{
	import com.reversy.common.IObservable;
	import com.reversy.common.IObserver;
	import com.reversy.gui.IView;

	import flash.events.ErrorEvent;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	public class LocaleUtil implements IObservable
	{
		private static const LOCALE_PATH:String = "locale/";

		public static const UNDEFINED:String = "Undefined";

		public static const LANGUAGE_EN:String = "en";
		public static const LANGUAGE_RU:String = "ru";
		public static const LANGUAGE_UA:String = "ua";

		private static var _instance:LocaleUtil;

		private var _observers:Vector.<IView>;
		private var _currentLanguage:String;
		private var _phrases:Dictionary;

		public function LocaleUtil()
		{
			if (_instance != null)
			{
				throw new Error("[ERROR] Engine | Singleton");
			}

			_observers = new Vector.<IView>();

			_instance = this;
		}

		//region static methods
		public static function get instance():LocaleUtil
		{
			if (_instance == null)
			{
				_instance = new LocaleUtil();
			}

			return _instance;
		}

		public static function getPhrase(localeTag:String):String
		{
			if (localeTag != null && localeTag.length > 0)
			{

				return instance.getLocalePhrase(localeTag);
			}
			else
			{
				return UNDEFINED;
			}
		}

		public static function setLanguage(value:String):void
		{
			if (value == LANGUAGE_EN || value == LANGUAGE_RU || value == LANGUAGE_UA)
			{
				instance.init(value);
			}
			else
			{
				throw new Error("[ERROR] LocaleUtil | set language | Unknown language identifier");
			}
		}
		//endregion

		//region public methods
		public function addObserver(observer:IObserver):void
		{
			var index:int = _observers.indexOf(observer);
			if (index == -1)
			{
				_observers.push(observer);
			}
		}

		public function removeObserver(observer:IObserver):void
		{
			var index:int = _observers.indexOf(observer);
			if (index != -1)
			{
				_observers.splice(index, 1);
			}
		}

		public function notifyObservers():void
		{
			for each (var observer:IView in _observers)
			{
				if (observer != null)
				{
					observer.updateLanguage();
				}
			}
		}

		public function get language():String {return _currentLanguage;}
		//endregion

		//region private methods
		private function init(language:String):void
		{
			_currentLanguage = language;

			var localeFileName:String = LOCALE_PATH + "locale_" + _currentLanguage + ".xml";
			loadLocale(localeFileName);
		}

		private function loadLocale(localeFileName:String):void
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			loader.addEventListener(Event.COMPLETE, onLoadComplete);
			loader.load(new URLRequest(localeFileName));
		}

		private function onError(event:ErrorEvent):void
		{
			var loader:URLLoader = event.target as URLLoader;
			if (loader != null)
			{
				loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
				loader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
				loader.removeEventListener(Event.COMPLETE, onLoadComplete);
			}

			throw new Error("[ERROR] LocaleUtil | loadLocale | Can not load locale xml");
		}

		private function onLoadComplete(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			if (loader != null)
			{
				loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
				loader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
				loader.removeEventListener(Event.COMPLETE, onLoadComplete);

				var xml:XML = XML(loader.data);
				if (xml != null)
				{
					_phrases = new Dictionary(true);
					parseLocale(xml);
					notifyObservers();
				}
			}
		}

		private function parseLocale(xml:XML, childName:String = ""):String
		{
			for each (var child:XML in xml.children())
			{
				if (child.hasSimpleContent())
				{
					_phrases[childName + child.name()] = child.toString();
				}
				else
				{
					parseLocale(child, childName + child.name() + ".");
				}
			}

			return childName;
		}

		private function getLocalePhrase(localeTag:String):String
		{
			if (_phrases != null)
			{
				var phrase:String = _phrases[localeTag];
				if (phrase != null)
				{
					return phrase;
				}
			}

			return UNDEFINED;
		}
		//endregion
	}
}
