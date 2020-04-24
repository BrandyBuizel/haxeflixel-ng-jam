package;

import flixel.FlxCamera;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxBasic;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.group.FlxGroup;

import flixel.text.FlxText;
import flixel.addons.text.FlxTypeText;
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
import flixel.tweens.FlxEase;

import flixel.graphics.frames.FlxAtlasFrames;


class PlayState extends FlxState
{
	// Demo arena boundaries
	static var LEVEL_MIN_X:Float;
	static var LEVEL_MAX_X:Float;
	static var LEVEL_MIN_Y:Float;
	static var LEVEL_MAX_Y:Float;
	
	//backgrounds go here
	var bgGroup:FlxGroup;
	var backdrop:FlxSprite;
	
	//Text Variables
	var curText:FlxTypeText;
	var curPlacement:Int = 0;
	var curDialogue:Array<Dynamic>;
	var blankDialogue:Array<Dynamic>;
	
	var isTalking:Bool;
	var isMoving:Bool;
	
	//player and camera
	var _player:Player;
	var effectTween:FlxTween;
	var cam = new FlxCamera();
	
	//characters
	var charGroup:FlxGroup;
	
	var _chez:FlxSprite;
	var _cickass:FlxSprite;
	var _digby:FlxSprite;
	var _ferdinand:FlxSprite;
	var _glottle:FlxSprite;
	var _gottsley:FlxSprite;
	var _hank:FlxSprite;
	var _ken:FlxSprite;
	var _oscar:FlxSprite;
	var _ramasama:FlxSprite;
	var _reggie:FlxSprite;
	var _sammy:FlxSprite;
	var _vernie:FlxSprite;
	
	//Character Dialogue Arrays
	var chezText:Array<Dynamic> = 
	[
		[
			""
		],
		[
			"Gimme Kiss"
		]
	];		
	
	var cickassText:Array<Dynamic> = 
	[
		[
			""
		],
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
	
	//a dog character upset about how many dogs there are in this game, they feel less special
	var digbyText:Array<Dynamic> = 
	[
		[
			""
		],
		[
			""
		]
	];	
	
	var ferdinandText:Array<Dynamic> = 
	[
		[
			""
		],
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
	
	//glutton
	var glottleText:Array<Dynamic> = 
	[
		[
			""
		],
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
	
	//a goat
	var gottsleyText:Array<Dynamic> = 
	[
		[
			""
		],
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
	
	//biker hank
	var hankText:Array<Dynamic> = 
	[
		[
			""
		],
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
	
	var kenText:Array<Dynamic> = 
	[
		[
			""
		],
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
	
	//hotdog dog selling hot dogs
	var oscarText:Array<Dynamic> = 
	[
		[
			""
		],
		[
			""
		]
	];
	
	//Yugioh fanaatic who seems like anaexhibistionist, tranchcoat owl
	var ramasamaText:Array<Dynamic> = 
	[
		[
			""
		],
		[
			""
		]
	];
	
	//Artist whos been drawing 5 years hasn't gotten better
	var reggieText:Array<Dynamic> = 
	[
		[
			""
		],
		[
			""
		]
	];	
	
	var sammyText:Array<Dynamic> = 
	[
		[
			""
		],
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
	
	var vernieText:Array<Dynamic> = 
	[
		[
			""
		],
		[
			""
		]
	];	
	
	//create event
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
		backdrop = new FlxSprite(0, 0, "assets/images/backdrop.png");
		backdrop.screenCenter();
		add(backdrop);		
		
		/*
		var effect = new MosaicEffect();
		backdrop.shader = effect.shader;
		
		effectTween = FlxTween.num(MosaicEffect.DEFAULT_STRENGTH, 16, 1.2, {type: BACKWARD}, function(v)
		{
			effect.setStrength(v, v);
		});
		*/
		
		//create player
		_player = new Player(100, 200);
		add(_player);
		
		// prevents the sprite to scroll with the camera
		_player.scrollFactor.set(0, 0);
			
		/*
		CREATE NPC CHARACTERS TO TALK TO 
		*/
		
		//Chez the Crow
		_chez = new FlxSprite(0, 200);
		_chez.frames = FlxAtlasFrames.fromSparrow(AssetPaths.chez__png, AssetPaths.chez__xml);
		_chez.updateHitbox();
        _chez.antialiasing = true;

		_chez.animation.addByPrefix('idle', 'chezIdle', 24, true);
		_chez.animation.addByPrefix('kissed', 'chezKissed', 24, true);
		_chez.animation.addByPrefix('talking', 'chezTalking', 24, true);
		
		add(_chez);
		_chez.animation.play("idle");
		
		//Cickass Cat
		_cickass = new FlxSprite(0, 200);
		_cickass.frames = FlxAtlasFrames.fromSparrow(AssetPaths.cickass__png, AssetPaths.cickass__xml);
		_cickass.updateHitbox();
        _cickass.antialiasing = true;

		_cickass.animation.addByPrefix('idle', 'cickassIdle', 24, true);
		_cickass.animation.addByPrefix('kissed', 'cickassKissed', 24, true);
		_cickass.animation.addByPrefix('talking', 'cickassTalking', 24, true);
		
		add(_cickass);
		_cickass.animation.play("idle");
		
		//Digby
		_digby = new FlxSprite(0, 200);
		_digby.frames = FlxAtlasFrames.fromSparrow(AssetPaths.digby__png, AssetPaths.digby__xml);
		_digby.updateHitbox();
        _digby.antialiasing = true;

		_digby.animation.addByPrefix('idle', 'digbyIdle', 24, true);
		_digby.animation.addByPrefix('kissed', 'digbyKissed', 24, true);
		_digby.animation.addByPrefix('talking', 'digbyTalking', 24, true);
		
		add(_digby);
		_digby.animation.play("idle");
				
		//Ferdinand
		_ferdinand = new FlxSprite(0, 200);
		_ferdinand.frames = FlxAtlasFrames.fromSparrow(AssetPaths.digby__png, AssetPaths.digby__xml);
		_ferdinand.updateHitbox();
        _ferdinand.antialiasing = true;

		_ferdinand.animation.addByPrefix('idle', 'digbyIdle', 24, true);
		_ferdinand.animation.addByPrefix('kissed', 'digbyKissed', 24, true);
		_ferdinand.animation.addByPrefix('talking', 'digbyTalking', 24, true);
		
		add(_ferdinand);
		_ferdinand.animation.play("idle");
		
		//Glottle
		_glottle = new FlxSprite(0, 200);
		_glottle.frames = FlxAtlasFrames.fromSparrow(AssetPaths.glottle__png, AssetPaths.glottle__xml);
		_glottle.updateHitbox();
        _glottle.antialiasing = true;

		_glottle.animation.addByPrefix('idle', 'glottleIdle', 24, true);
		_glottle.animation.addByPrefix('kissed', 'glottleKissed', 24, true);
		_glottle.animation.addByPrefix('talking', 'glottleTalking', 24, true);
		
		add(_glottle);
		_glottle.animation.play("idle");
		
		//Gottsley
		_gottsley = new FlxSprite(0, 200);
		_gottsley.frames = FlxAtlasFrames.fromSparrow(AssetPaths.gottsley__png, AssetPaths.gottsley__xml);
		_gottsley.updateHitbox();
        _gottsley.antialiasing = true;

		_gottsley.animation.addByPrefix('idle', 'gottsleyIdle', 24, true);
		_gottsley.animation.addByPrefix('kissed', 'gottsleyKissed', 24, true);
		_gottsley.animation.addByPrefix('talking', 'gottsleyTalking', 24, true);
		
		add(_gottsley);
		_gottsley.animation.play("idle");
		
		//Hank
		_hank = new FlxSprite(0, 200);
		_hank.frames = FlxAtlasFrames.fromSparrow(AssetPaths.hank__png, AssetPaths.hank__xml);
		_hank.updateHitbox();
        _hank.antialiasing = true;

		_hank.animation.addByPrefix('idle', 'hankIdle', 24, true);
		_hank.animation.addByPrefix('kissed', 'hankKissed', 24, true);
		_hank.animation.addByPrefix('talking', 'hankTalking', 24, true);
		
		add(_hank);
		_hank.animation.play("idle");
		
		//Ken
		_ken = new FlxSprite(0, 200);
		_ken.frames = FlxAtlasFrames.fromSparrow(AssetPaths.ken__png, AssetPaths.ken__xml);
		_ken.updateHitbox();
        _ken.antialiasing = true;

		_ken.animation.addByPrefix('idle', 'kenIdle', 24, true);
		_ken.animation.addByPrefix('kissed', 'kenKissed', 24, true);
		_ken.animation.addByPrefix('talking', 'kenTalking', 24, true);
		
		add(_ken);
		_ken.animation.play("idle");
		
		//Oscar
		_oscar = new FlxSprite(0, 200);
		_oscar.frames = FlxAtlasFrames.fromSparrow(AssetPaths.oscar__png, AssetPaths.oscar__xml);
		_oscar.updateHitbox();
        _oscar.antialiasing = true;

		_oscar.animation.addByPrefix('idle', 'oscarIdle', 24, true);
		_oscar.animation.addByPrefix('kissed', 'oscarKissed', 24, true);
		_oscar.animation.addByPrefix('talking', 'oscarTalking', 24, true);
		
		add(_oscar);
		_oscar.animation.play("idle");
		
		//Ramasama
		_ramasama = new FlxSprite(0, 200);
		_ramasama.frames = FlxAtlasFrames.fromSparrow(AssetPaths.ramasama__png, AssetPaths.ramasama__xml);
		_ramasama.updateHitbox();
        _ramasama.antialiasing = true;

		_ramasama.animation.addByPrefix('idle', 'ramasamaIdle', 24, true);
		_ramasama.animation.addByPrefix('kissed', 'ramasamaKissed', 24, true);
		_ramasama.animation.addByPrefix('talking', 'ramasamaTalking', 24, true);
		
		add(_ramasama);
		_ramasama.animation.play("idle");
		
		//Reggie
		_reggie = new FlxSprite(0, 200);
		_reggie.frames = FlxAtlasFrames.fromSparrow(AssetPaths.reggie__png, AssetPaths.reggie__xml);
		_reggie.updateHitbox();
        _reggie.antialiasing = true;

		_reggie.animation.addByPrefix('idle', 'reggieIdle', 24, true);
		_reggie.animation.addByPrefix('kissed', 'reggieKissed', 24, true);
		_reggie.animation.addByPrefix('talking', 'reggieTalking', 24, true);
		
		add(_reggie);
		_reggie.animation.play("idle");
		
		//Sammy the Otter
		_sammy = new FlxSprite(0, 200);
		_sammy.frames = FlxAtlasFrames.fromSparrow(AssetPaths.sammy__png, AssetPaths.sammy__xml);
		_sammy.updateHitbox();
        _sammy.antialiasing = true;

		_sammy.animation.addByPrefix('idle', 'sammyIdle', 24, true);
		_sammy.animation.addByPrefix('kissed', 'sammyKissed', 24, true);
		_sammy.animation.addByPrefix('talking', 'sammyTalking', 24, true);
		
		add(_sammy);
		_sammy.animation.play("idle");
		
		//Vernie
		_vernie = new FlxSprite(0, 200);
		_vernie.frames = FlxAtlasFrames.fromSparrow(AssetPaths.vernie__png, AssetPaths.vernie__xml);
		_vernie.updateHitbox();
        _vernie.antialiasing = true;

		_vernie.animation.addByPrefix('idle', 'vernieIdle', 24, true);
		_vernie.animation.addByPrefix('kissed', 'vernieKissed', 24, true);
		_vernie.animation.addByPrefix('talking', 'vernieTalking', 24, true);
		
		add(_vernie);
		_vernie.animation.play("idle");
		
		/*
		charGroup.add(_chez);
		charGroup.add(_vernie);
		charGroup.add(_digby);
		charGroup.add(_gleetus);
		charGroup.add(_sammy);
		charGroup.add(_cickass);
		charGroup.add(_ken);
		charGroup.add(_reggie);
		charGroup.add(_ferdinand);
		charGroup.add(_hank);
		charGroup.add(_ramasama);
		charGroup.add(_oscar);
		charGroup.add(_gottsley);
		var _chez:FlxSprite;	
		*/
		
		// create a new FlxText
		curText = new FlxTypeText(0, 0, 640, "", 32);
		curText.setFormat("assets/fonts/SeaHorses.ttf");
		curText.color = FlxColor.WHITE; // set the color to cyan
		curText.size = 32; // set the text's size to 32px
		curText.alignment = FlxTextAlign.CENTER; // center the text
		curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.CYAN, 2); // give the text a 2-pixel deep, cyan shadow
		
		curText.screenCenter();
		curText.y = 40;
		
		curText.delay = 0.2;
		//curText.sounds[] = "assets/sounds/menuConfirm.mp3";
		
		curText.text = "Get Kisses, Assimilate"; // set text's text to say "Hello, World!"
		add(curText);
		
		isTalking = false;
		
		FlxG.sound.playMusic("assets/music/921812_Morning.mp3", 1, true);
		
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (!isTalking){
			curPlacement = 0;
			
			if (FlxG.keys.anyPressed(["S", "DOWN", "W", "UP", "A", "LEFT", "D", "RIGHT"])){
				isMoving = true;
				
				if(_player.y <= 200){
					_player.y += 2.4;
				}else if (_player.y > 100){
					_player.y -= 32;
				}
			}else{
				isMoving = false;
				_player.y = 200;
			}
			
			//Depth, Scale Camera
			if (FlxG.keys.anyPressed(["S", "DOWN"]))
			{
				if(cam.zoom < 4){
					cam.zoom -= 0.007;
				}
			}
			
			if (FlxG.keys.anyPressed(["W", "UP"]))
			{
				if(cam.zoom > 0.01){
					cam.zoom += 0.01;
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
		}
		
		//set character to talk to on overlap
		if (FlxG.keys.justPressed.SPACE && !isTalking){			
			if (_player.overlaps(_chez)){
				isTalking = true;
				
				curDialogue = chezText;
				_chez.animation.play("talking");
			}
			if (_player.overlaps(_cickass)){
				isTalking = true;
				
				curDialogue = cickassText;
				_cickass.animation.play("talking");
			}
			
		}
		
		if (FlxG.keys.justPressed.SPACE && isTalking){
			
			curText.text = "";
			curPlacement += 1;
			
			//Text process dialogue tree
			for (i in 0...curDialogue[curPlacement].length){
				curText.text += curDialogue[curPlacement][i] + "\n";
				curText.skip();
				curText.start();
			}
			
			//end dialogue
			if (curPlacement >= curDialogue.length){
				curDialogue = blankDialogue;
				curText.text = "";
				
				isTalking = false;
			}
		}		
	}
}

