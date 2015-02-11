/**
 * Created by a.buryak on 10.02.15.
 */
package com.reversy.dataModels
{
	public class PotentialCell
	{
		private var _cellIndex:int = 0;
		private var _potential:int = 0;

		public function PotentialCell(cellIndex:int, potential:int)
		{
			_cellIndex = cellIndex;
			_potential = potential;
		}

		public function get cellIndex():int {return _cellIndex;}
		public function set cellIndex(value:int):void {_cellIndex = value;}

		public function get potential():int {return _potential;}
		public function set potential(value:int):void {_potential = value;}
	}
}
