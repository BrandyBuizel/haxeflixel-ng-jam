package;

import flixel.FlxSprite;
import flixel.system.FlxBasePreloader;
import flixel.FlxG;
import flash.display.*;
import flash.text.*;
import flash.Lib;
import flixel.text.FlxText;
import openfl.display.Sprite;
import openfl.display.BitmapData;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;

@:font() class CustomFont extends Font {}
@:bitmap("assets/images/preloaderArt.png") class LogoImage extends BitmapData { }

class Preloader extends FlxBasePreloader
{
	override public function new(MinDisplayTime:Float=4, ?AllowedURLs:Array<String>)
	{
		super(MinDisplayTime, AllowedURLs);
	}

	private var logo:Sprite;
	var text:TextField;
	private var _buffer:Sprite;
	private var _bmpBar:Bitmap;
	
	override private function create():Void
	{		
		this._width = Lib.current.stage.stageWidth;
		this._height = Lib.current.stage.stageHeight;
		
		var ratio:Float = this._width / 800; //This allows us to scale assets depending on the size of the screen.
		
		logo = new Sprite();
		logo.scaleY = 1;
		logo.addChild(new Bitmap(new LogoImage(0, 0))); //Sets the graphic of the sprite to a bitmap object, which uses our embedded bitmapData class
		addChild(logo);
		
		//UMM COFFEE
		//var milk = new FlxSprite();
		var milkFrame:Int = 0;
		
		_buffer = new Sprite();
		//_buffer.scaleX = _buffer.scaleY = 2;
		addChild(_buffer);
		
		_bmpBar = new Bitmap(new BitmapData(1, 14, false, 0x5f6aff));
		_bmpBar.x = 4;
		_bmpBar.y = _height - 17;
		//_buffer.addChild(_bmpBar);
		
		super.create();
	}
	
	override private function destroy():Void 
	{
		if (_buffer != null)	
		{
			removeChild(_buffer);
		}
		_buffer = null;
		_bmpBar = null;
		logo = null;
		
		super.destroy();
	}
	
	override public function update(Percent:Float):Void 
	{
		// sprite's graphic will be loaded from 'path/to/image.png' and is set to allow animations.
		/*
		if (milkFrame > 0){
			destroy(milk);
		}
		
		if (milkFrame > 9){
			@:milk("assets/images/milk/milk_" + milkFrame + ".png") { }
			milk.addChild(new Bitmap(new LogoImage(0, 0)));
			milkFrame += 1;
			//milk.loadGraphic('AssetPaths.milk_' + milkFrame + '__png', true);
		}else if (milkFrame == 32){
			milkFrame = 0;
		}else{
			@:milk("assets/images/milk/milk_0" + milkFrame + ".png") { }
			milk.addChild(new Bitmap(new LogoImage(0, 0)));
			milkFrame += 1;
			//milk.loadGraphic('AssetPaths.milk_0' + milkFrame + '__png', true);
		}		
		*/
		
		super.update(Percent);
		
		//logo.scaleY = Percent;
		_bmpBar.scaleX = Percent * (_width - 8);
	}
}