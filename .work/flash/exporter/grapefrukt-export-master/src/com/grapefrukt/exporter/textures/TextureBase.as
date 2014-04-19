/*
Copyright 2011 Martin Jonasson, grapefrukt games. All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are
permitted provided that the following conditions are met:

   1. Redistributions of source code must retain the above copyright notice, this list of
      conditions and the following disclaimer.

   2. Redistributions in binary form must reproduce the above copyright notice, this list
      of conditions and the following disclaimer in the documentation and/or other materials
      provided with the distribution.

THIS SOFTWARE IS PROVIDED BY grapefrukt games "AS IS" AND ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL grapefrukt games OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

The views and conclusions contained in the software and documentation are those of the
authors and should not be interpreted as representing official policies, either expressed
or implied, of grapefrukt games.
*/

package com.grapefrukt.exporter.textures {
	import com.grapefrukt.exporter.settings.Settings;
	/**
	 * ...
	 * @author Martin Jonasson, m@grapefrukt.com
	 */
	public class TextureBase {

		private var _name			:String;
		private var _sheet			:TextureSheet;
		private var _z_index		:int = 0;
		private var _is_mask		:Boolean = false;
		private var _extension		:String;
		
		public function TextureBase(name:String, zIndex:int, isMask:Boolean) {
			_name = name;
			_z_index = zIndex;
			_is_mask = isMask;
		}
		
		public function get name():String { return _name; }
		public function get isMask():Boolean { return _is_mask; }
		
		public function get filenameWithPath():String {
			return sheet.name + Settings.directorySeparator + name + extension;
		}
		
		public function get zIndex():int { return _z_index; }
		public function set zIndex(value:int):void {
			_z_index = value;
		}
		
		public function get sheet():TextureSheet { return _sheet; }
		public function set sheet(value:TextureSheet):void {
			_sheet = value;
		}
		
		public function get extension():String { return _extension; }
		public function set extension(value:String):void {
			_extension = value;
		}
	}

}