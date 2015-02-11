/**
 * Created by a.buryak on 09.02.15.
 */
package com.reversy.dataModels
{
	public class Score
	{
		private var _scoreWhite:int;
		private var _scoreBlack:int;

		public function Score(scoreWhite:int = 0, scoreBlack:int = 0)
		{
			_scoreWhite = scoreWhite;
			_scoreBlack = scoreBlack;
		}

		public function get scoreWhite():int {return _scoreWhite;}
		public function set scoreWhite(value:int):void {_scoreWhite = value;}

		public function get scoreBlack():int {return _scoreBlack;}
		public function set scoreBlack(value:int):void {_scoreBlack = value;}
	}
}
