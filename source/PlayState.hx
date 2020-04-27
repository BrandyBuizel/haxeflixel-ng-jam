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
	var backdrop1:FlxSprite;
	var backdrop2:FlxSprite;
	var effectTween:FlxTween;
	
	//Text Variables
	var curText:FlxTypeText;
	var curPlacement:Int = 0;
	var curDialogue:Array<Dynamic>;
	var blankDialogue:Array<Dynamic>;
	var textSound:Array<FlxSound>;
	var debugText:FlxText;
	
	//player=
	var _player:Player;
	var _face:FlxSprite;
	var isTalking:Bool = false;
	
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
	
	var chezKissed:Bool = false;
	var cickassKissed:Bool = false;
	var digbyKissed:Bool = false;
	var ferdinandKissed:Bool = false;
	var glottisKissed:Bool = false;
	var gottsleyKissed:Bool = false;
	var hankKissed:Bool = false;
	var kenKissed:Bool = false;
	var oscarKissed:Bool = false;
	var ramasamaKissed:Bool = false;
	var reggieKissed:Bool = false;
	var sammyKissed:Bool = false;
	var vernieKissed:Bool = false;
	
	var worldScale:Float = 0.25;
	var tempScale:Float = 100;
	var level:Int = 1;
	var prevLevel:Int = 1;
	var hiveCount:Int = 0;
	
	var smallScale:Float;
	var middleScale:Float;
	var bigScale:Float;
	
	//Character Dialogue Arrays
	var chezText:Array<Dynamic> = 
	[
		[
			""
		],
		[
			"Gimme Kiss"
		],
		[
			">Kiss"
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
			">do I need to call the cops?"
		],
		[
			"Nah man, i just love fighting. My dad bought me these gloves as a kitten, been fighting ever since. Can i try my gloves on your face?"
		],
		[
			">can i try something on your face?"
		],
		[
			"Only if you promise it'll hurt. Pain is just information that the mind can master!"
		],
		[
			">You plant a fat one on the kitty"
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
			">that's pretty gross"
		],
		[
			"No, like, I just prefer showers. I'm not dirty"
		],
		[
			">you look pretty gross though"
		],
		[
			"I showered just last night though!"
		],
		[
			">you shouldn't lie..."
		],
		[
			"Do people really think I'm dirty?"
		],
		[
			">dood i wouldn't poke you with a 10 foot pole"
		],
		[
			"I even use mouthwash regularly"
		],
		[
			"I bet your breath still smells"
		],
		[
			"I'll prove it doesnt, Kiss me!"
		],
		[
			">kiss reluctantly"
		],
		[
			">Not bad"
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
			">whatcha eating..?"
		],
		[
			"munch munch much munch munch"
		],
		[
			">ya got a little somethin on your face"
		],
		[
			"munch munch munch munch munch munch munch munch munch\nmunch munch munch munch munch munch munch munch munch\nmunch munch munch munch munch munch munch munch munch"
		],
		[
			">let me get that for you"
		],
		[
			">kiss"
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
			"..."
		],
		[
			"Gotta go fast, beat my best time. Gotta keep moving"
		],
		[
			"..."
		],
		[
			"What do you want. I cant stop right now, so close to my Personal record"
		],
		[
			"..."
		],
		[
			"*heaves and collapses*"
		],
		[
			">kiss"
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
			">nothing in particular right now"
		],
		[
			"Nah man, you got seed? Sunflower seeds, whats your favorite flavor?"
		],
		[
			">i'm partial to barbeque"
		],
		[
			"Man me too, aww bro. Nice nice. "
		],
		[
			">i can share but i already got most of them in my mouth"
		],
		[
			"No problem"
		],
		[
			">get kiss, oh wow he's all up in your mouth for them seeds"
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
			">well it’s not the best tree i’ve ever seen"
		],
		[
			"...you can't tell it’s me at all. "
		],
		[
			">that's almost not true"
		],
		[
			"oh, well i actually spent the whole day on it. practice makes... perfect."
		],
		[
			">you should practice more"
		],
		[
			"I do every day! i want so badly to draw like i see people do on twitter!! i've been doing art for 5 years but im still no good"
		],
		[
			">it takes a lot of bad pieces to get to one you like"
		],
		[
			"Wow, you know, you're really nice."
		],
		[
			">stop being so hard on yourself "
		],
		[
			">kiss on cheek"
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
			">Sounds exhausting"
		],
		[
			"I just love smiling, they say if you smile more you'll start being happy again."
		],
		[
			">I dont believe you, you dont look happy at all to me"
		],
		[
			"You're right, I'm actually quite depressed but i try to smile so that people dont have to worry about me and feel sorry for me"
		],
		[
			">i get it. it's hard putting on a smile, youre brave for dling so but you dont need to hide how you really feel. We're all the same on the inside can can understand what you're going though if you let others in"
		],
		[
			">kiss"
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
		backdrop1 = new FlxSprite(0, 0, "assets/images/back.png");
		backdrop1.screenCenter();
		add(backdrop1);
		
		backdrop2 = new FlxSprite(0, 0, "assets/images/back2.png");
		backdrop2.screenCenter();
		add(backdrop2);
		
		var effect = new MosaicEffect();
		backdrop1.shader = effect.shader;
		backdrop2.shader = effect.shader;
		
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
		
		//Spawn NPCs
		add(_cickass);
		add(_ferdinand);
		add(_chez);
		
		add(_oscar);
		add(_ramasama);
		add(_glottis);
		
		add(_reggie);			
		add(_vernie);
		add(_sammy);
		
		add(_gottsley);
		add(_ken);
		add(_digby);
		
		_cickass.visible = false;
		_ferdinand.visible = false;
		_chez.visible = false;
		
		_oscar.visible = false;
		_ramasama.visible = false;
		_glottis.visible = false;
		
		_reggie.visible = false;
		_vernie.visible = false;
		_sammy.visible = false;
		
		_gottsley.visible = false;
		_ken.visible = false;
		_digby.visible = false;
		
		/*
		END OF CHARACTER CREATE
		*/
		
		//create player
		_player = new Player(0, 180);
		_player.screenCenter();
		_player.x -= 120;
		_player.animation.play('idle');
		add(_player);
		
		_face = new FlxSprite(770, 360);
		_face.frames = FlxAtlasFrames.fromSparrow(AssetPaths.playerFace__png, AssetPaths.playerFace__xml);
		_face.animation.addByPrefix('face', 'playerFace', 0, false);
		_face.animation.play('face');
		_face.antialiasing = true;
		_face.updateHitbox();
		add(_face);		
		
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
		
		if (hiveCount >= 13){
			_face.animation.frameIndex = 5;
		}else if (hiveCount >= 11){
			_face.animation.frameIndex = 4;
		}else if (hiveCount >= 9){
			_face.animation.frameIndex = 3;
		}else if (hiveCount >= 6){
			_face.animation.frameIndex = 2;
		}else if (hiveCount >= 3){
			_face.animation.frameIndex = 1;
		}else{
			_face.animation.frameIndex = 0;
			_player.animation.play('idle');
			
			if (cickassKissed == true){
				_cickass.animation.play('kissed');
			}
			if (ferdinandKissed == true){
				_ferdinand.animation.play('kissed');
			}
			if (chezKissed == true){
				_chez.animation.play('kissed');
			}
			if (oscarKissed == true){
				_oscar.animation.play('kissed');
			}
			if (ramasamaKissed == true){
				_ramasama.animation.play('kissed');
			}
			if (glottisKissed == true){
				_glottis.animation.play('kissed');
			}
			if (reggieKissed == true){
				_reggie.animation.play('kissed');
			}
			if (vernieKissed == true){
				_vernie.animation.play('kissed');
			}
			if (sammyKissed == true){
				_sammy.animation.play('kissed');
			}
			if (gottsleyKissed == true){
				_glottis.animation.play('kissed');
			}
			if (kenKissed == true){
				_ken.animation.play('kissed');
			}
			if (digbyKissed == true){
				_digby.animation.play('kissed');
			}
		}
			
		//Player Control
		if (!isTalking){
			curPlacement = 0;
			curText.text = "";
			curText.visible = false;

			//Movement
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
					if (level == 1){
						if (worldScale >= 0.3){
							worldScale -= 0.005;
						}
					}else{
						worldScale -= 0.005;
					}
				}
				
				tempScale -= 0.;
			}
			
			if (FlxG.keys.anyPressed(["W", "UP"])){
				worldScale += 0.005;
				
				tempScale += 0.1;
			}
			
			//Who ya talkin' too?
			if (FlxG.keys.justPressed.SPACE){
				//Level 1 Dialogue
				if (level == 1){
					if (debugText.text == "Chez Beaks"){
						isTalking = true;
						curDialogue = chezText;
						_chez.animation.play("talking");
					}else if (debugText.text == "Ferdinand"){
						isTalking = true;
						curDialogue = ferdinandText;
						_ferdinand.animation.play("talking");
					}else if (debugText.text == "Cickass Cat"){
						isTalking = true;
						curDialogue = cickassText;
						_cickass.animation.play("talking");
					}	
				}
				
				//Level 2 Dialogue
				if (level == 2){
					if (debugText.text == "Glottis is a Glutton"){
						isTalking = true;
						curDialogue = glottisText;
						_glottis.animation.play("talking");
					}else if (debugText.text == "Ramasama-kun"){
						isTalking = true;
						curDialogue = ramasamaText;
						_ramasama.animation.play("talking");
					}else if (debugText.text == "Oscar's Hot Hot Dogs"){
						isTalking = true;
						curDialogue = oscarText;
						_oscar.animation.play("talking");
					}	
				}
				
				//Level 3 Dialogue
				if (level == 3){
					if (debugText.text == "Reggie"){
						isTalking = true;
						curDialogue = reggieText;
						_glottis.animation.play("talking");
					}else if (debugText.text == "Vern 'Vernie' Varns"){
						isTalking = true;
						curDialogue = vernieText;
						_ramasama.animation.play("talking");
					}else if (debugText.text == "Sammy Schwimmer"){
						isTalking = true;
						curDialogue = sammyText;
						_oscar.animation.play("talking");
					}	
				}
				
				//Level 4 Dialogue
				if (level == 4){
					if (debugText.text == "Gottsley"){
						isTalking = true;
						curDialogue = gottsleyText;
						_glottis.animation.play("talking");
					}else if (debugText.text == "Ken, sup"){
						isTalking = true;
						curDialogue = kenText;
						_ramasama.animation.play("talking");
					}else if (debugText.text == "Digby"){
						isTalking = true;
						curDialogue = digbyText;
						_oscar.animation.play("talking");
					}
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
				
				//main dialogue
				if (curPlacement <= curDialogue.length){
					curText.text += curDialogue[curPlacement];
					curText.start();
				}
				
				if (curPlacement > (curDialogue.length - 2)){
					curText.color = FlxColor.YELLOW;
				}else if (FlxMath.isOdd(curPlacement)){
					curText.color = FlxColor.WHITE;
				}else{
					curText.color = FlxColor.YELLOW;
				}
				
				//end dialogue victory
				if (curPlacement > (curDialogue.length - 1)){
					curDialogue = blankDialogue;
					isTalking = false;
					
					if (debugText.text == "Chez Beaks"){
						if (!chezKissed){
							hiveCount += 1;
							chezKissed = true;
						}
					}
					if (debugText.text == "Ferdinand"){
						if (!chezKissed){
							hiveCount += 1;
							ferdinandKissed = true;
						}
					}
					if (debugText.text == "Cickass Cat"){
						if (!chezKissed){
							hiveCount += 1;
							cickassKissed = true;
						}
					}		
					if (debugText.text == "Glottis is a Glutton"){
						if (!chezKissed){
							hiveCount += 1;
							glottisKissed = true;
						}
					}	
					if (debugText.text == "Ramasama-kun"){
						if (!chezKissed){
							hiveCount += 1;
							ramasamaKissed = true;
						}
					}
					if (debugText.text == "Oscar's Hot Hot Dogs"){
						if (!chezKissed){
							hiveCount += 1;
							oscarKissed = true;
						}
					}	
					if (debugText.text == "Reggie"){
						if (!chezKissed){
							hiveCount += 1;
							reggieKissed = true;
						}
					}
					if (debugText.text == "Vern 'Vernie' Varns"){
						if (!chezKissed){
							hiveCount += 1;
							vernieKissed = true;
						}
					}
					if (debugText.text == "Sammy Schwimmer"){
						if (!chezKissed){
							hiveCount += 1;
							sammyKissed = true;
						}
					}
					if (debugText.text == "Gottsley"){
						if (!chezKissed){
							hiveCount += 1;
							gottsleyKissed = true;
						}
					}
					if (debugText.text == "Ken, sup"){
						if (!chezKissed){
							hiveCount += 1;
							kenKissed = true;
						}
					}
					if (debugText.text == "Digby"){
						if (!chezKissed){
							hiveCount += 1;
							digbyKissed = true;
						}
					}
				}
			}
		}
		
		//WORLD SCALE TWEENING	
		smallScale = (worldScale * worldScale * 50) + 480;
		middleScale = (100 / (worldScale / 2)) - 100;
		bigScale = (worldScale * worldScale * 150) + 480;
		
		//so it doesnt all suck
		_cickass.updateHitbox();
		_ferdinand.updateHitbox();
		_chez.updateHitbox();
		_oscar.updateHitbox();
		_glottis.updateHitbox();
		_ramasama.updateHitbox();
		_reggie.updateHitbox();
		_sammy.updateHitbox();
		_vernie.updateHitbox();
		_gottsley.updateHitbox();
		_digby.updateHitbox();
		
		//Backdrop sclaing
		FlxTween.tween(backdrop1.scale, { x: worldScale, y: worldScale },  0.1);
		FlxTween.tween(backdrop2.scale, { x: worldScale * 0.17, y: worldScale * 0.17 },  0.1);
		
		//Level Code
		if (prevLevel != level){
			worldScale = 0.25;
			prevLevel = level;
		}
		
		if (level == 1){
			_cickass.visible = true;
			_ferdinand.visible = true;
			_chez.visible = true;
			
			//position in level
			FlxTween.tween(_cickass.scale, { x: (tempScale/150) * (worldScale * worldScale), y: (tempScale/150) * (worldScale * worldScale) },  0.1);
			_cickass.x = smallScale;
			_cickass.y = (worldScale * -100) + 240;
			
			FlxTween.tween(_ferdinand.scale, { x: (tempScale / 75) * (worldScale * worldScale), y: (tempScale / 75) * (worldScale * worldScale) },  0.1);
			_ferdinand.x = middleScale;
			if (_ferdinand.x > 480){
				_ferdinand.alpha = 0;
			}
			_ferdinand.y = (worldScale * -100) + 225;
			
			FlxTween.tween(_chez.scale, { x: (tempScale/40) * (worldScale * worldScale), y: (tempScale/40) * (worldScale * worldScale) },  0.1);
			_chez.x = bigScale;
			_chez.y = (worldScale * -100) + 225;
			
			//Name popup bottom left and text color
			if (_player.overlaps(_chez) && _chez.scale.x > 0.6 && _chez.scale.x < 1.2){
				debugText.text = "Chez Beaks";
				debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(51, 51, 51, 255), 2);
				curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(51, 51, 51, 255), 2);
			}else if (_player.overlaps(_ferdinand) && _ferdinand.scale.x > 0.6 && _ferdinand.scale.x < 1.2){
				debugText.text = "Ferdinand";
				debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(61, 64, 106, 255), 2);
				curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(61, 64, 106, 255), 2);
			}else if (_player.overlaps(_cickass) && _cickass.scale.x > 0.6 && _cickass.scale.x < 1.2){
				debugText.text = "Cickass Cat";
				debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(255, 163, 5, 255), 2);
				curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(255, 163, 5, 255), 2);
			}else{
				debugText.text = "";
			}
		
			//level change
			if (worldScale >= 1.5){
				_cickass.visible = false;
				_ferdinand.visible = false;
				_chez.visible = false;
		
				level = 2;
			}
		}
		
		//Level 2
		if (level == 2){
			_oscar.visible = true;
			_ramasama.visible = true;
			_glottis.visible = true;
		
			//set position and scale
			FlxTween.tween(_oscar.scale, { x: (tempScale/150) * (worldScale * worldScale), y: (tempScale/150) * (worldScale * worldScale) },  0.1);
			_oscar.x = smallScale;
			_oscar.y = (worldScale * -100) + 240;
			
			FlxTween.tween(_ramasama.scale, { x: (tempScale/75) * (worldScale * worldScale), y: (tempScale/75) * (worldScale * worldScale) },  0.1);
			_ramasama.x = middleScale;
			if (_ramasama.x > 480){
				_ramasama.alpha = 0;
			}
			_ramasama.y = (worldScale * -100) + 240;
			
			FlxTween.tween(_glottis.scale, { x: (tempScale/40) * (worldScale * worldScale), y: (tempScale/40) * (worldScale * worldScale) },  0.1);
			_glottis.x = bigScale;
			_glottis.y = (worldScale * -100) + 240;
			
			//name in bottom left
			if (_player.overlaps(_glottis) && _glottis.scale.x > 0.6 && _glottis.scale.x < 1.2){
				debugText.text = "Glottis is a Glutton";
				debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(204, 115, 159, 255), 2);
				curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(204, 115, 159, 255), 2);
			}else if (_player.overlaps(_ramasama) && _ramasama.scale.x > 0.6 && _ramasama.scale.x < 1.2){
				debugText.text = "Ramasama-kun";
				debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(105, 11, 20, 255), 2);
				curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(105, 11, 20, 255), 2);
			}else if (_player.overlaps(_oscar) && _oscar.scale.x > 0.6 && _oscar.scale.x < 1.2){
				debugText.text = "Oscar's Hot Hot Dogs";
				debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(51, 153, 255, 255), 2);
				curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(51, 153, 255, 255), 2);
			}else{
				debugText.text = "";
			}
			
			//level change
			if (worldScale >= 1.5){
				_oscar.visible = false;
				_ramasama.visible = false;
				_glottis.visible = false;
		
				level = 3;
			}
			
			if (worldScale <= 0.5){
				_oscar.visible = false;
				_ramasama.visible = false;
				_glottis.visible = false;
				
				level = 1;
			}
		}
		
		//Level 3
		if (level == 3){
			_reggie.visible = true;
			_vernie.visible = true;
			_sammy.visible = true;
		
			//set position and scale
			FlxTween.tween(_sammy.scale, { x: (tempScale/150) * (worldScale * worldScale), y: (tempScale/150) * (worldScale * worldScale) },  0.1);
			_sammy.x = smallScale;
			_sammy.y = (worldScale * -100) + 240;
			
			FlxTween.tween(_vernie.scale, { x: (tempScale/75) * (worldScale * worldScale), y: (tempScale/75) * (worldScale * worldScale) },  0.1);
			_vernie.x = middleScale;
			if (_vernie.x > 480){
				_vernie.alpha = 0;
			}
			_vernie.y = (worldScale * -100) + 240;
			
			FlxTween.tween(_reggie.scale, { x: (tempScale/40) * (worldScale * worldScale), y: (tempScale/40) * (worldScale * worldScale) },  0.1);
			_reggie.x = bigScale;
			_reggie.y = (worldScale * -100) + 240;
			
			//change bottom left text and color
			if (_player.overlaps(_reggie) && _reggie.scale.x > 0.6 && _reggie.scale.x < 1.2){
				debugText.text = "Reggie";
				debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(0, 204, 153, 255), 2);
				curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(0, 204, 153, 255), 2);
			}else if (_player.overlaps(_vernie) && _vernie.scale.x > 0.6 && _vernie.scale.x < 1.2){
				debugText.text = "Vern 'Vernie' Varns";
				debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(0, 204, 153, 255), 2);
				curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(0, 204, 153, 255), 2);
			}else if (_player.overlaps(_sammy) && _sammy.scale.x > 0.6 && _sammy.scale.x < 1.2){
				debugText.text = "Sammy Schwimmer";
				debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(0, 204, 153, 255), 2);
				curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(0, 204, 153, 255), 2);
			}else{
				debugText.text = "";
			}
			
			//level change
			if (worldScale >= 1.5){
				_reggie.visible = false;
				_vernie.visible = false;
				_sammy.visible = false;
				
				level = 4;
			}			
			
			if (worldScale <= 0.5){
				_reggie.visible = false;
				_vernie.visible = false;
				_sammy.visible = false;
		
				level = 2;
			}
		}
		
		//Level 4
		if (level == 4){
			_gottsley.visible = false;
			_ken.visible = false;
			_digby.visible = false;
		
			//set position and scale
			FlxTween.tween(_digby.scale, { x: (tempScale/150) * (worldScale * worldScale), y: (tempScale/150) * (worldScale * worldScale) },  0.1);
			_digby.x = smallScale;
			_digby.y = (worldScale * -100) + 240;
			
			FlxTween.tween(_ken.scale, { x: (tempScale/75) * (worldScale * worldScale), y: (tempScale/75) * (worldScale * worldScale) },  0.1);
			_ken.x = middleScale;
			if (_ken.x > 480){
				_ken.alpha = 0;
			}
			_ken.y = (worldScale * -100) + 240;
			
			FlxTween.tween(_gottsley.scale, { x: (tempScale/40) * (worldScale * worldScale), y: (tempScale/40) * (worldScale * worldScale) },  0.1);
			_gottsley.x = bigScale;
			_gottsley.y = (worldScale * -100) + 240;
			
			//change bottom left text and color
			if (_player.overlaps(_gottsley) && _gottsley.scale.x > 0.6 && _gottsley.scale.x < 1.2){
				debugText.text = "Gottsley";
				debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(0, 204, 153, 255), 2);
				curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(0, 204, 153, 255), 2);
			}else if (_player.overlaps(_ken) && _ken.scale.x > 0.6 && _ken.scale.x < 1.2){
				debugText.text = "Ken, sup";
				debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(0, 204, 153, 255), 2);
				curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(0, 204, 153, 255), 2);
			}else if (_player.overlaps(_digby) && _digby.scale.x > 0.6 && _digby.scale.x < 1.2){
				debugText.text = "Digby";
				debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(0, 204, 153, 255), 2);
				curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(0, 204, 153, 255), 2);
			}else{
				debugText.text = "";
			}
			
			//level chnage
			if (worldScale <= 0.5){
				_gottsley.visible = false;
				_ken.visible = false;
				_digby.visible = false;
		
				level = 3;
			}			
		}
		
		/*
		MISC EXTRA BITS
		*/
		
		//FADE OUT AND POP IN LOGIC
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
		
		if (_ferdinand.scale.x >= 1.45 || _ferdinand.scale.x <= 0.24){
			FlxTween.tween(_ferdinand, { alpha: 0 }, 1, { ease: FlxEase.expoOut } );
		}
		if(_ferdinand.alpha != 1){
			if (_ferdinand.scale.x < 1.45 && _ferdinand.scale.x > 0.21){
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
			
		if (_sammy.scale.x >= 1.45 || _sammy.scale.x <= 0.18){
			FlxTween.tween(_sammy, { alpha: 0 }, 1, { ease: FlxEase.expoOut } );
		}
		if(_sammy.alpha != 1){
			if (_sammy.scale.x < 1.45 && _sammy.scale.x > 0.18){
				_sammy.alpha = 1;
			}
		}
		
		//default bottom left text
		if (debugText.text == ""){
			debugText.text = "OBJECTIVE: Get Kisses, Assimilate";
			debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.CYAN, 2);
		}
	}
}