package;

import flixel.FlxCamera;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;

import flixel.text.FlxText;
import flixel.util.FlxColor;

import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.addons.util.PNGEncoder;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.system.replay.FlxReplay;

import openfl.display.BitmapData;
import openfl.utils.ByteArray;
import openfl.utils.Object;

import flixel.tweens.FlxTween;


class PlayState extends FlxState
{
	var _player:Player;
	var effectTween:FlxTween;
	var cam = new FlxCamera();
	
	// Demo arena boundaries
	static var LEVEL_MIN_X:Float;
	static var LEVEL_MAX_X:Float;
	static var LEVEL_MIN_Y:Float;
	static var LEVEL_MAX_Y:Float;
	
	override public function create():Void 
	{
		//screen size
		LEVEL_MIN_X = -FlxG.stage.stageWidth / 2;
		LEVEL_MAX_X = FlxG.stage.stageWidth * 1.5;
		LEVEL_MIN_Y = -FlxG.stage.stageHeight / 2;
		LEVEL_MAX_Y = FlxG.stage.stageHeight * 1.5;

		//Camera settings
		cam.zoom = 1; // For 1/2 zoom out.
		FlxG.cameras.add(cam);
		
		//setup backdrop
		var backdrop = new FlxSprite(0, 0, "assets/images/backdrop.png");
		backdrop.screenCenter();
		add(backdrop);		
		
		var effect = new MosaicEffect();
		backdrop.shader = effect.shader;
		
		
		//create player
		_player = new Player(100, 200);
		add(_player);
		
		
		effectTween = FlxTween.num(MosaicEffect.DEFAULT_STRENGTH, 16, 1.2, {type: BACKWARD}, function(v)
		{
			effect.setStrength(v, v);
		});
		
		
		// create a new FlxText
		var curText = new FlxText();
		
		curText.setFormat("assets/fonts/SeaHorses.ttf");
		curText.color = FlxColor.WHITE; // set the color to cyan
		curText.size = 32; // set the text's size to 32px
		curText.alignment = FlxTextAlign.CENTER; // center the text
		curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.CYAN, 2); // give the text a 2-pixel deep, cyan shadow
		curText.setPosition(_player.x + 10, _player.y - 40);
		
		curText.text = "Get Kisses, Assimilate"; // set text's text to say "Hello, World!"
		add(curText);
		
		FlxG.sound.playMusic("assets/music/921812_Morning.mp3", 1, true);
		
		
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		//Depth, Scale Camera
			if (FlxG.keys.anyPressed(["S", "DOWN"]))
			{
				cam.zoom += 0.01;
			}
			
			if (FlxG.keys.anyPressed(["W", "UP"]))
			{
				cam.zoom -= 0.01;
			}
		
		if (FlxG.keys.anyPressed(["A", "LEFT"]))
			{
				_player.x -= 20;
			}
			
			if (FlxG.keys.anyPressed(["D", "RIGHT"]))
			{
				_player.x += 20;
			}
	}
}

