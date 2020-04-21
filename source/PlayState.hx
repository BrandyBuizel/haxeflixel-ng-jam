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
	
	var curText = new FlxText();
	
	//Character Dialogue Arrays
	var chezText:Array<Dynamic> = 
	[
		[
			"Gimme Kiss"
		]
	];		
	
	var vernieText:Array<Dynamic> = 
	[
		[
			""
		]
	];		
	
	//a dog character upset about how many dogs there are in this game, they feel less special
	var digbyText:Array<Dynamic> = 
	[
		[
			""
		]
	];	
	
	//glutton
	var gleetusText:Array<Dynamic> = 
	[
		[
			"munch munch much"
		],
		[
			"munch munch much munch munch"
		],
		[
			"munch munch much munch munch much munch munch much",
			"munch munch much munch munch much munch munch much",
			"munch munch much munch munch much munch munch much"
		]
	];	
	
	var sammyText:Array<Dynamic> = 
	[
		[
			"Isn't being so happy All the time amazing?"
		],
		[
			"I just love smiling, they say if you smile more you'll start being happy again."
		],
		[
			"You're right, I'm actually quite depressed but i try to smile so that people dont have to worry about me and feel sorry for me"
		]
	];	
	
	var cickassText:Array<Dynamic> = 
	[
		[
			"Wanna fight bro?"
		],
		[
			"Nah man, i just love fighting. My dad bought me these gloves as a kitten, been fighting ever since. Can i try my gloves on your face?"
		],
		[
			"Only if you promise it'll hurt. Pain is just information that the mind can master!"
		]
	];		
	
	var kenText:Array<Dynamic> = 
	[
		[
			"You holding?"
		],
		[
			"Nah man, you got seed?"
		],
		[
			"Sunflower seeds, whats your favorite flavor?"
		],
		[
			"Man me too, aww bro. Nice nice. "
		],
		[
			"No problem"
		]
	];		
	
	//Artist whos been drawing 5 years hasn't gotten better
	var reggieText:Array<Dynamic> = 
	[
		[
			""
		]
	];	
	
	var ferdinandText:Array<Dynamic> = 
	[
		[
			"I hate taking baths"
		],
		[
			"No, like, I just prefer showers. I'm not dirty"
		],
		[
			"I showered just last night though!"
		],
		[
			"Do people really think I'm dirty?"
		],
		[
			"I even use mouthwash regularly"
		],
		[
			"I'll prove it doesnt, Kiss me!"
		]
	];
		
	//biker hank
	var hankText:Array<Dynamic> = 
	[
		[
			"Gotta get top speed. Win next week's race. Show biker troy who's boss"
		],
		[
			"Gotta go fast, beat my best time. Gotta keep moving"
		],
		[
			"What do you want. I cant stop right now, so close to my Personal record"
		],
		[
			"*heaves*"
		],
		[
			"*collapses*"
		]
	];
	
	//Yugioh fanaatic who seems like anaexhibistionist, tranchcoat owl
	var ramasamaText:Array<Dynamic> = 
	[
		[
			""
		]
	];	
	
	//hotdog dog selling hot dogs
	var oscarText:Array<Dynamic> = 
	[
		[
			""
		]
	];
	
	//a goat
	var gottsleyText:Array<Dynamic> = 
	[
		[
			"Wanna join my cult?"
		],
		[
			"We’ll spill the blood of virgins"
		],
		[
			"You also have to take a vow of silence, but i broke mine to speak with you"
		],
		[
			"I must be slaughtered now as per told by the scripture"
		],
		[
			"Give me the sweet kiss of death and seal my fate"
		]
	];
	
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
			if(cam.zoom < 4){
			cam.zoom += 0.01;
			}
		}
		
		if (FlxG.keys.anyPressed(["W", "UP"]))
		{
			if(cam.zoom > 0.01){
				cam.zoom -= 0.01;
			}
		}
	
		if (FlxG.keys.anyPressed(["A", "LEFT"]))
		{
			_player.x -= 20;
		}
			
		if (FlxG.keys.anyPressed(["D", "RIGHT"]))
		{
			_player.x += 20;
		}
		
		if (FlxG.keys.anyPressed(["SPACE"])){
			
		}
		
		curText.setPosition(_player.x + 10, _player.y - 40);
	}
}

