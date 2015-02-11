/**
 * Created by a.buryak on 10.02.15.
 */
package com.reversy.utils
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;

	import starling.textures.Texture;

	import starling.textures.TextureAtlas;

	public class Assets
	{
		public static const ATLAS_TEXTURES_NAME:String = "textures";
		public static const ATLAS_BUTTONS_NAME:String = "buttons";
		public static const ATLAS_POPUPS_NAME:String = "popups";

		public static const POPUP_BACKGROUND_TEXTURE_NAME:String = "popupBackgroundMc0000";
		public static const POPUP_CHIP_WHITE_TEXTURE_NAME:String = "chipWhiteMc0000";
		public static const POPUP_CHIP_BLACK_TEXTURE_NAME:String = "chipBlackMc0000";
		public static const POPUP_FLAG_EN_TEXTURE_NAME:String = "flagENMc0000";
		public static const POPUP_FLAG_UA_TEXTURE_NAME:String = "flagUAMc0000";
		public static const POPUP_FLAG_RU_TEXTURE_NAME:String = "flagRUMc0000";

		public static const TOP_PANEL_BG_TEXTURE_NAME:String = "topPanelBgMc0000";
		public static const SCORE_PANEL_BG_TEXTURE_NAME:String = "scorePanelBgMc0000";
		public static const CHIP_PLACEHOLDER_TEXTURE_NAME:String = "chipPlaceholderMc0000";

		public static const CELL_TEXTURE_NAME:String = "cellMc0000";
		public static const CHIP_WHITE_TEXTURE_NAME:String = "chipWhiteMc0000";
		public static const CHIP_BLACK_TEXTURE_NAME:String = "chipBlackMc0000";

		public static const BOTTOM_PANEL_BG_TEXTURE_NAME:String = "bottomPanelBgMc0000";
		public static const BUTTON_BG_TEXTURE_NAME:String = "buttonMc000";
		public static const PLAY_BUTTON_BG_TEXTURE_NAME:String = "playButtonMc000";

		private static var _textures:Dictionary = new Dictionary();
		private static var _textureAtlases:Dictionary = new Dictionary();

		[Embed(source="../../../../assets/textures/textures.xml", mimeType="application/octet-stream")]
		public static const textures_xml:Class;

		[Embed(source="../../../../assets/textures/textures.png")]
		public static const textures:Class;

		[Embed(source="../../../../assets/textures/buttons.xml", mimeType="application/octet-stream")]
		public static const buttons_xml:Class;

		[Embed(source="../../../../assets/textures/buttons.png")]
		public static const buttons:Class;

		[Embed(source="../../../../assets/textures/popups.xml", mimeType="application/octet-stream")]
		public static const popups_xml:Class;

		[Embed(source="../../../../assets/textures/popups.png")]
		public static const popups:Class;

		[Embed(source="../../../../assets/fonts/hoog05_55cyr2.ttf", fontFamily="hooge 05_55 Cyr2")]
		public static const Font_Hooge_05_55:Class;

		public static function getTexture(textureName:String, atlasName:String = null):Texture
		{
			if (atlasName != null)
			{
				return getAtlas(atlasName).getTexture(textureName);
			}
			else
			{
				if (_textures[textureName] == undefined)
				{
					var bitmap:Bitmap = new Assets[textureName]();
					_textures[textureName] = Texture.fromBitmap(bitmap);
				}

				return _textures[textureName];
			}
		}

		public static function getAtlas(atlasName:String):TextureAtlas
		{
			if (_textureAtlases[atlasName] == undefined)
			{
				var texture:Texture = getTexture(atlasName);
				_textureAtlases[atlasName] = new TextureAtlas(texture, XML(new Assets[atlasName + "_xml"]()));
			}

			return _textureAtlases[atlasName];
		}
	}
}
