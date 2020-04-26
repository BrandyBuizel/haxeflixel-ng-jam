package;

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
import flixel.system.FlxSound;

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
	var effectTween:FlxTween;
	
	//Text Variables
	var curText:FlxTypeText;
	var curPlacement:Int = 0;
	var curDialogue:Array<Dynamic>;
	var blankDialogue:Array<Dynamic>;
	var textSound:Array<FlxSound>;
	var debugText:FlxText;
	
	var isTalking:Bool = false;
	
	//player=
	var _player:Player;
	
	//characters
	var _chez:FlxSprite;
	var _cickass:FlxSprite;
	var _digby:FlxSprite;
	var _ferdinand:FlxSprite;
	var _glottis:FlxSprite;
	var _gottsley:FlxSprite;
	var _hank:FlxSprite;
	var _ken:FlxSprite;
	var _oscar:FlxSprite;
	var _ramasama:FlxSprite;
	var _reggie:FlxSprite;
	var _sammy:FlxSprite;
	var _vernie:FlxSprite;
	
	var worldScale:Float = 1;
	
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
			"Have you talked to the other dog yet?"
		],
		[
			"Why there gotta be two dogs in this game? There's no other duplicate species here!"
		],
		[
			"It certainly doesn't make me feel special."
		],
		[
			"You can, how?"
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
	var glottisText:Array<Dynamic> = 
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
			"munch munch munch munch munch munch munch munch munch\nmunch munch munch munch munch munch munch munch munch\nmunch munch munch munch munch munch munch munch munch"
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
			"My great great great great grandpappy, pupsworth the cannibal created our family recipe that we continue to sell to this day. They’re barking delicious"
		],
		[
			"Well yes sir, what you like!"
		],
		[
			"Can I recommend the... "
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
			"I just finished this neat sketch, do you like it?"
		],
		[
			"...you can't tell it’s me at all. "
		],
		[
			"oh, well i actually spent the whole day on it. practice makes... perfect."
		],
		[
			"I do every day! i want so badly to draw like i see people do on twitter!! i've been doing art for 5 years but im still no good"
		],
		[
			"Wow, you know, you're really nice."
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
		
		//setup backdrop
		backdrop = new FlxSprite(0, 0, "assets/images/back.png");
		backdrop.screenCenter();
		add(backdrop);		
		
		var effect = new MosaicEffect();
		backdrop.shader = effect.shader;
		
		effectTween = FlxTween.num(MosaicEffect.DEFAULT_STRENGTH, 16, 1.2, {type: BACKWARD}, function(v){effect.setStrength(v, v);});
		
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
		
		//Cickass Cat
		_cickass = new FlxSprite(0, 200);
		_cickass.frames = FlxAtlasFrames.fromSparrow(AssetPaths.cickass__png, AssetPaths.cickass__xml);
		_cickass.updateHitbox();
        _cickass.antialiasing = true;

		_cickass.animation.addByPrefix('idle', 'cickassIdle', 24, true);
		_cickass.animation.addByPrefix('kissed', 'cickassKissed', 24, true);
		_cickass.animation.addByPrefix('talking', 'cickassTalking', 24, true);
		
		//Digby
		_digby = new FlxSprite(0, 200);
		_digby.frames = FlxAtlasFrames.fromSparrow(AssetPaths.digby__png, AssetPaths.digby__xml);
		_digby.updateHitbox();
        _digby.antialiasing = true;

		_digby.animation.addByPrefix('idle', 'digbyIdle', 24, true);
		_digby.animation.addByPrefix('kissed', 'digbyKissed', 24, true);
		_digby.animation.addByPrefix('talking', 'digbyTalking', 24, true);
				
		//Ferdinand
		_ferdinand = new FlxSprite(0, 200);
		_ferdinand.frames = FlxAtlasFrames.fromSparrow(AssetPaths.ferdinand__png, AssetPaths.ferdinand__xml);
		_ferdinand.updateHitbox();
        _ferdinand.antialiasing = true;

		_ferdinand.animation.addByPrefix('idle', 'ferdinandIdle', 24, true);
		_ferdinand.animation.addByPrefix('kissed', 'ferdinandKissed', 24, true);
		_ferdinand.animation.addByPrefix('talking', 'ferdinandTalking', 24, true);
		
		//glottis
		_glottis = new FlxSprite(0, 200);
		_glottis.frames = FlxAtlasFrames.fromSparrow(AssetPaths.glottis__png, AssetPaths.glottis__xml);
		_glottis.updateHitbox();
        _glottis.antialiasing = true;

		_glottis.animation.addByPrefix('idle', 'glottisIdle', 24, true);
		_glottis.animation.addByPrefix('kissed', 'glottisKissed', 24, true);
		_glottis.animation.addByPrefix('talking', 'glottisTalking', 24, true);
			
		//Gottsley
		_gottsley = new FlxSprite(0, 200);
		_gottsley.frames = FlxAtlasFrames.fromSparrow(AssetPaths.gottsley__png, AssetPaths.gottsley__xml);
		_gottsley.updateHitbox();
        _gottsley.antialiasing = true;

		_gottsley.animation.addByPrefix('idle', 'gottsleyIdle', 24, true);
		_gottsley.animation.addByPrefix('kissed', 'gottsleyKissed', 24, true);
		_gottsley.animation.addByPrefix('talking', 'gottsleyTalking', 24, true);
		
		//Hank
		_hank = new FlxSprite(0, 200);
		_hank.frames = FlxAtlasFrames.fromSparrow(AssetPaths.hank__png, AssetPaths.hank__xml);
		_hank.updateHitbox();
        _hank.antialiasing = true;

		_hank.animation.addByPrefix('idle', 'hankIdle', 24, true);
		_hank.animation.addByPrefix('kissed', 'hankKissed', 24, true);
		_hank.animation.addByPrefix('talking', 'hankTalking', 24, true);
		
		//Ken
		_ken = new FlxSprite(0, 200);
		_ken.frames = FlxAtlasFrames.fromSparrow(AssetPaths.ken__png, AssetPaths.ken__xml);
		_ken.updateHitbox();
        _ken.antialiasing = true;

		_ken.animation.addByPrefix('idle', 'kenIdle', 24, true);
		_ken.animation.addByPrefix('kissed', 'kenKissed', 24, true);
		_ken.animation.addByPrefix('talking', 'kenTalking', 24, true);
		
		//Oscar
		_oscar = new FlxSprite(0, 200);
		_oscar.frames = FlxAtlasFrames.fromSparrow(AssetPaths.oscar__png, AssetPaths.oscar__xml);
		_oscar.updateHitbox();
        _oscar.antialiasing = true;

		_oscar.animation.addByPrefix('idle', 'oscarIdle', 24, true);
		_oscar.animation.addByPrefix('kissed', 'oscarKissed', 24, true);
		_oscar.animation.addByPrefix('talking', 'oscarTalking', 24, true);
		
		//Ramasama
		_ramasama = new FlxSprite(0, 200);
		_ramasama.frames = FlxAtlasFrames.fromSparrow(AssetPaths.ramasama__png, AssetPaths.ramasama__xml);
		_ramasama.updateHitbox();
        _ramasama.antialiasing = true;

		_ramasama.animation.addByPrefix('idle', 'ramasamaIdle', 24, true);
		_ramasama.animation.addByPrefix('kissed', 'ramasamaKissed', 24, true);
		_ramasama.animation.addByPrefix('talking', 'ramasamaTalking', 24, true);
				
		//Reggie
		_reggie = new FlxSprite(0, 200);
		_reggie.frames = FlxAtlasFrames.fromSparrow(AssetPaths.reggie__png, AssetPaths.reggie__xml);
		_reggie.updateHitbox();
        _reggie.antialiasing = true;

		_reggie.animation.addByPrefix('idle', 'reggieIdle', 24, true);
		_reggie.animation.addByPrefix('kissed', 'reggieKissed', 24, true);
		_reggie.animation.addByPrefix('talking', 'reggieTalking', 24, true);
		
		//Sammy the Otter
		_sammy = new FlxSprite(0, 200);
		_sammy.frames = FlxAtlasFrames.fromSparrow(AssetPaths.sammy__png, AssetPaths.sammy__xml);
		_sammy.updateHitbox();
        _sammy.antialiasing = true;

		_sammy.animation.addByPrefix('idle', 'sammyIdle', 24, true);
		_sammy.animation.addByPrefix('kissed', 'sammyKissed', 24, true);
		_sammy.animation.addByPrefix('talking', 'sammyTalking', 24, true);
		
		//Vernie
		_vernie = new FlxSprite(0, 200);
		_vernie.frames = FlxAtlasFrames.fromSparrow(AssetPaths.vernie__png, AssetPaths.vernie__xml);
		_vernie.updateHitbox();
        _vernie.antialiasing = true;

		_vernie.animation.addByPrefix('idle', 'vernieIdle', 24, true);
		_vernie.animation.addByPrefix('kissed', 'vernieKissed', 24, true);
		_vernie.animation.addByPrefix('talking', 'vernieTalking', 24, true);
		
		/*
		SPAWN NPCs to talk to
		*/
		
		_chez.screenCenter();
		_chez.animation.play("idle");
	
		_cickass.screenCenter();
		_cickass.animation.play("idle");	
		
		_digby.screenCenter();
		_digby.animation.play("idle");
		
		_ferdinand.screenCenter();
		_ferdinand.animation.play("idle");
		
		_glottis.screenCenter();
		_glottis.animation.play("idle");
		
		_gottsley.screenCenter();
		_gottsley.animation.play("idle");
		
		_ken.screenCenter();
		_ken.animation.play("idle");
		
		_oscar.screenCenter();
		_oscar.animation.play("idle");
		
		_ramasama.screenCenter();
		_ramasama.animation.play("idle");
		
		_reggie.screenCenter();
		_reggie.animation.play("idle");
		
		_sammy.screenCenter();
		_sammy.animation.play("idle");
		
		_vernie.screenCenter();
		_vernie.animation.play("idle");
		
		/*
		SPAWN ORDER BACK TO FRONT 
		*/
		
		add(_oscar);
		add(_ferdinand);
		add(_reggie);
		add(_cickass);
		add(_chez);
		add(_glottis);
		add(_ramasama);
		
		//add(_digby);
		//add(_vernie);
		//add(_sammy);
		//add(_ken);
		//add(_gottsley);
		
		/*
		END OF CHARACTER CREATE
		*/
		
		//create player
		_player = new Player(0, 180);
		add(_player);
		_player.screenCenter();
		_player.animation.play('idle');
		
		
		/*
		CREATE TEXT 
		*/
		
		// create a new FlxText
		curText = new FlxTypeText(0, 0, 640, "");
		curText.setFormat("assets/fonts/SeaHorses.ttf");
		curText.color = FlxColor.WHITE; // set the color to cyan
		curText.size = 32; // set the text's size to 32px
		curText.alignment = FlxTextAlign.CENTER; // center the text
		curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.CYAN, 2); // give the text a 2-pixel deep, cyan shadow
		curText.screenCenter();
		curText.y = 40;
		curText.delay = 2;
		add(curText);
		
		//create a new FlxText
		debugText = new FlxText(20, 480, 640, "");
		debugText.setFormat("assets/fonts/SeaHorses.ttf");
		debugText.color = FlxColor.WHITE; // set the color to cyan
		debugText.size = 42; // set the text's size to 32px
		debugText.alignment = FlxTextAlign.LEFT; // center the text
		debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.CYAN, 2); // give the text a 2-pixel deep, cyan shadow
		add(debugText);
		
		/*
		END TEXT 
		*/
		
		FlxG.sound.playMusic("assets/music/921812_Morning.mp3", 1, true);
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (!isTalking){
			curPlacement = 0;
			curText.text = "";
			curText.visible = false;

			if (FlxG.keys.anyPressed(["S", "DOWN", "W", "UP", "A", "LEFT", "D", "RIGHT"])){
				if(_player.y <= 200){
					_player.y += 2.4;
				}else if (_player.y > 100){
					_player.y -= 32;
				}
			}else{
				_player.y = 180;
			}
			
			if (FlxG.keys.anyPressed(["A", "LEFT"])){
				if(_player.x > 60){
					_player.x -= 20;
				}
			}
				
			if (FlxG.keys.anyPressed(["D", "RIGHT"])){
				if(_player.x < 560){
					_player.x += 20;
				}
			}
			
			//Zoom in and out
			if (FlxG.keys.anyPressed(["S", "DOWN"])){
				if(worldScale > 0){
					worldScale -= 0.01;
				}
			}
			
			if (FlxG.keys.anyPressed(["W", "UP"])){
				worldScale += 0.01;
			}
			
			if(FlxG.keys.justPressed.SPACE){	
				if (_player.overlaps(_chez)){
					isTalking = true;
					curDialogue = chezText;
					_chez.animation.play("talking");
				}
				
				if (_player.overlaps(_cickass) && _cickass.alpha != 0){
					isTalking = true;
					curDialogue = cickassText;
					_cickass.animation.play("talking");
				}
				
				if (_player.overlaps(_ferdinand) && _ferdinand.alpha != 0){
					isTalking = true;
					curDialogue = ferdinandText;
					_ferdinand.animation.play("talking");
				}
				
				if (_player.overlaps(_glottis) && _glottis.alpha != 0){
					isTalking = true;
					curDialogue = glottisText;
					_glottis.animation.play("talking");
				}
				
				if (_player.overlaps(_oscar) && _oscar.alpha != 0){
					isTalking = true;
					curDialogue = oscarText;
					_oscar.animation.play("talking");
				}
				
				if (_player.overlaps(_ramasama) && _ramasama.alpha != 0){
					isTalking = true;
					curDialogue = oscarText;
					_ramasama.animation.play("talking");
				}
				
				if (_player.overlaps(_reggie) && _reggie.alpha != 0){
					isTalking = true;
					curDialogue = reggieText;
					_reggie.animation.play("talking");
				}
			}
		}
		
		//DIALOGUE CODE
		if (isTalking){
			curText.visible = true;
			
			if(FlxG.keys.justPressed.SPACE){
				curText.text = "";
				curPlacement += 1;
				
				FlxG.sound.play("assets/sounds/menuDown.mp3");
				
				if (curPlacement <= curDialogue.length){
					curText.text += curDialogue[curPlacement];
					curText.start();
				}
				
				//end dialogue
				if (curPlacement > (curDialogue.length - 1)){
					curDialogue = blankDialogue;
					isTalking = false;
				}
			}
		}
		
		//WORLD SCALE TWEENING
		FlxTween.tween(backdrop.scale, { x: worldScale, y: worldScale },  0.1);
		
		FlxTween.tween(_chez.scale, { x: worldScale * worldScale, y: worldScale * worldScale },  0.1);
		_chez.x = (worldScale * 150) + 480;
		_chez.y = (worldScale * -100) + 240;
		_chez.updateHitbox();
		
		FlxTween.tween(_cickass.scale, { x: worldScale * worldScale, y: worldScale * worldScale },  0.1);
		_cickass.x = (worldScale * 10) + 480;
		_cickass.y = (worldScale * -100) + 240;
		_cickass.updateHitbox();
		
		FlxTween.tween(_ferdinand.scale, { x: worldScale * worldScale, y: worldScale * worldScale },  0.1);
		_ferdinand.x = (worldScale * 150) + 480;
		_ferdinand.y = (worldScale * -100) + 240;
		_ferdinand.updateHitbox();	
				
		FlxTween.tween(_glottis.scale, { x: worldScale * worldScale, y: worldScale * worldScale },  0.1);
		_glottis.x = (worldScale * 150) + 480;
		_glottis.y = (worldScale * -100) + 240;
		_glottis.updateHitbox();
		
		FlxTween.tween(_oscar.scale, { x: worldScale * worldScale, y: worldScale * worldScale },  0.1);
		_oscar.x = (worldScale * 150) + 480;
		_oscar.y = (worldScale * -100) + 240;
		_oscar.updateHitbox();
		
		FlxTween.tween(_ramasama.scale, { x: worldScale * worldScale, y: worldScale * worldScale },  0.1);
		_ramasama.x = (worldScale * 150) + 480;
		_ramasama.y = (worldScale * -100) + 240;
		_ramasama.updateHitbox();

		FlxTween.tween(_reggie.scale, { x:  worldScale * worldScale, y:  worldScale * worldScale },  0.1);
		_reggie.x = (worldScale * 150) + 480;
		_reggie.y = (worldScale * -100) + 240;
		_reggie.updateHitbox();
		
		
		//FADE OUT AND POP IN
		if (_chez.scale.x >= 1.45 || _chez.scale.x <= 0.18){
			FlxTween.tween(_chez, { alpha: 0 }, 1, { ease: FlxEase.expoOut } );
		}
		if(_chez.alpha != 1){
			if (_chez.scale.x < 1.45 && _chez.scale.x > 0.18){
				_chez.alpha = 1;
			}
		}
		
		if (_cickass.scale.x >= 1.45 || _cickass.scale.x <= 0.18){
			FlxTween.tween(_cickass, { alpha: 0 }, 1, { ease: FlxEase.expoOut } );
		}
		if(_cickass.alpha != 1){
			if (_cickass.scale.x < 1.45 && _cickass.scale.x > 0.18){
				_cickass.alpha = 1;
			}
		}		
		
		if (_ferdinand.scale.x >= 1.45 || _ferdinand.scale.x <= 0.18){
			FlxTween.tween(_ferdinand, { alpha: 0 }, 1, { ease: FlxEase.expoOut } );
		}
		if(_ferdinand.alpha != 1){
			if (_ferdinand.scale.x < 1.45 && _ferdinand.scale.x > 0.18){
				_ferdinand.alpha = 1;
			}
		}	
		
		if (_glottis.scale.x >= 1.45 || _glottis.scale.x <= 0.18){
			FlxTween.tween(_glottis, { alpha: 0 }, 1, { ease: FlxEase.expoOut } );
		}
		if(_glottis.alpha != 1){
			if (_glottis.scale.x < 1.45 && _glottis.scale.x > 0.18){
				_glottis.alpha = 1;
			}
		}	
		
		if (_oscar.scale.x >= 1.45 || _oscar.scale.x <= 0.18){
			FlxTween.tween(_oscar, { alpha: 0 }, 1, { ease: FlxEase.expoOut } );
		}
		if(_oscar.alpha != 1){
			if (_oscar.scale.x < 1.45 && _oscar.scale.x > 0.18){
				_oscar.alpha = 1;
			}
		}
		
		if (_ramasama.scale.x >= 1.45 || _ramasama.scale.x <= 0.18){
			FlxTween.tween(_ramasama, { alpha: 0 }, 1, { ease: FlxEase.expoOut } );
		}
		if(_ramasama.alpha != 1){
			if (_ramasama.scale.x < 1.45 && _ramasama.scale.x > 0.18){
				_ramasama.alpha = 1;
			}
		}
		
		if (_reggie.scale.x >= 1.45 || _reggie.scale.x <= 0.18){
			FlxTween.tween(_reggie, { alpha: 0 }, 1, { ease: FlxEase.expoOut } );
		}
		if(_reggie.alpha != 1){
			if (_reggie.scale.x < 1.45 && _reggie.scale.x > 0.18){
				_reggie.alpha = 1;
			}
		}
	
		//Name popup bottom left and text color
		if (_player.overlaps(_chez) && _chez.scale.x > 0.6 && _chez.scale.x < 1.2){
			debugText.text = "Chez Beaks";
			debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(51, 51, 51, 255), 2);
			curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(51, 51, 51, 255), 2);
		}else{debugText.text = ""; }
		
		if (_player.overlaps(_cickass) && _cickass.scale.x > 0.6 && _cickass.scale.x < 1.2){
			debugText.text = "Cickass Cat";
			debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(255, 163, 5, 255), 2);
			curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(255, 163, 5, 255), 2);
		}else{debugText.text = ""; }
		
		if (_player.overlaps(_ferdinand) && _ferdinand.scale.x > 0.6 && _ferdinand.scale.x < 1.2){
			debugText.text = "Ferdinand";
			debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(61, 64, 106, 255), 2);
			curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(61, 64, 106, 255), 2);
		}else{debugText.text = ""; }
		
		if (_player.overlaps(_glottis) && _glottis.scale.x > 0.6 && _glottis.scale.x < 1.2){
			debugText.text = "Glottis is a Glutton";
			debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(204, 115, 159, 255), 2);
			curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(204, 115, 159, 255), 2);
		}else{debugText.text = ""; }
				
		if (_player.overlaps(_oscar) && _oscar.scale.x > 0.6 && _oscar.scale.x < 1.2){
			debugText.text = "Oscar's Hot Hot Dogs";
			debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(51, 153, 255, 255), 2);
			curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(51, 153, 255, 255), 2);
		}else{debugText.text = ""; }
		
		if (_player.overlaps(_ramasama) && _ramasama.scale.x > 0.6 && _ramasama.scale.x < 1.2){
			debugText.text = "Ramasama-kun";
			debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(105, 11, 20, 255), 2);
			curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(105, 11, 20, 255), 2);
		}else{debugText.text = ""; }
		
		if (_player.overlaps(_reggie) && _reggie.scale.x > 0.6 && _reggie.scale.x < 1.2){
			debugText.text = "Reggie";
			debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(0, 204, 153, 255), 2);
			curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(0, 204, 153, 255), 2);
		}else{debugText.text = ""; }
		
		if (debugText.text == ""){
			debugText.text = "OBJECTIVE: Get Kisses, Assimilate";
			debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.CYAN, 2);
		}
	}
}