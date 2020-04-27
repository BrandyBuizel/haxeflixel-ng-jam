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

import flixel.input.gamepad.FlxGamepad;
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
	
	//var gamepad:FlxGamepad = FlxG.gamepads.lastActive;
	
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
			">Really?"
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
			""
		],
		[
			"Have you talked to the other dog yet?"
		],
		[
			">Seems friendly aside from the cannibal stuff"
		],
		[
			"The wha--"
		],
		[
			">Nothing, what were you saying before?"
		],
		[
			"Oh, well why there gotta be two dogs in this game? There's no other duplicate species here! It certainly doesn't make me feel special."
		],
		[
			">Maybe I can help with that."
		],
		[
			"You can, how?"
		],
		[
			">smooch"
		],
		[
			">I mean kiss"
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
			"munch munch munch munch munch munch\nmunch munch munch munch munch munch munch\nmunch munch munch munch munch munch munch"
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
			">That's strangely upfront, what are some of the activities?"
		],
		[
			"We’ll spill the blood of virgins"
		],
		[
			">right on. right on."
		],
		[
			"You also have to take a vow of silence, but i broke mine to speak with you"
		],
		[
			">oof"
		],
		[
			"I must be slaughtered now as per told by the scripture. Give me the sweet kiss of death and seal my fate"
		],
		[
			">Kiss?"
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
			">..."
		],
		[
			"Gotta go fast, beat my best time. Gotta keep moving"
		],
		[
			">..."
		],
		[
			"What do you want. I cant stop right now, so close to my Personal record"
		],
		[
			">..."
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
			">???"
		],
		[
			"Well yes sir, what you like!"
		],
		[
			">I wou--"
		],
		[
			"Go on, I'm listening!"
		],
		[
			">I would like a--"
		],
		[
			"Can I recommend the... "
		],
		[
			">Can I just--"
		],
		[
			"Want to try our brand new beef--"
		],
		[
			">THERE'S ONLY ONE HOT DOG I WANT IN MY MOUTH, c'mere"
		],
		[
			">Kiss the fool who wouldn't shut up"
		]
	];
	
	//Yugioh fanaatic who seems like anaexhibistionist, tranchcoat owl
	var ramasamaText:Array<Dynamic> = 
	[
		[
			""
		],
		[
			"Check this out nerd!"
		],
		[
			">That's pretty rude"
		],
		[
			"No, see I'm also a nerd, like you! Don't you wanna see my Yu-gi-oh cards?"
		],
		[
			">Hell yea, do you play synchos?"
		],
		[
			"Not really, I'm more a fan of yugioh classic"
		],
		[
			">I'm in love"
		],
		[
			"THis iS GoiNg tOO fASt!!"
		],
		[
			">close those eyes"
		],
		[
			">kiss"
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
			">i get it. it's hard putting on a smile, you're brave for doing so but you don't need to hide how you really feel. We're all the same on the inside and can understand what you're going through if you let others in"
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
			"Please keep 6ft away from me sir!"
		],
		[
			">Why?"
		],
		[
			"You unknowingly carry germs and vicious diseases that can spread in mere breaths! You need to take heavy precautions to avoid them"
		],
		[
			">So you're just screening everyone then?"
		],
		[
			"Yep, can't be too sure, even with friends!"
		],
		[
			">So you're like the TSA, but germs are your terrorists"
		],
		[
			"How do you figure?"
		],
		[
			">well they're mostly invisible and they're such an uncommon threat in reality but you let fear control you and police those around you"
		],
		[
			"..."
		],
		[
			">I don't like get sick either"
		],
		[
			"You get me don't you?"
		],
		[
			">you give them mono"
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
		backdrop1 = new FlxSprite(0, 0, "assets/images/background.png");
		backdrop1.screenCenter();
		backdrop1.antialiasing = true;
		add(backdrop1);
		
		backdrop2 = new FlxSprite(0, 0, "assets/images/back2.png");
		backdrop2.screenCenter();
		backdrop2.antialiasing = true;
		//add(backdrop2);
		
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
		_chez.animation.addByPrefix('kisseda', 'chezKisseda', 24, true);
		_chez.animation.addByPrefix('kissedb', 'chezKissedb', 24, true);
		_chez.animation.addByPrefix('kissedc', 'chezKissedc', 24, true);
		_chez.animation.addByPrefix('kissedd', 'chezKissedd', 24, true);
		_chez.animation.addByPrefix('kissede', 'chezKissede', 24, true);
		_chez.animation.addByPrefix('kissedf', 'chezKissedf', 24, true);
		_chez.animation.addByPrefix('talking', 'chezTalking', 24, true);
		
		//Cickass Cat
		_cickass = new FlxSprite(0, 200);
		_cickass.frames = FlxAtlasFrames.fromSparrow(AssetPaths.cickass__png, AssetPaths.cickass__xml);
		_cickass.updateHitbox();
        _cickass.antialiasing = true;

		_cickass.animation.addByPrefix('idle', 'cickassIdle', 24, true);
		_cickass.animation.addByPrefix('kisseda', 'cickassKisseda', 24, true);
		_cickass.animation.addByPrefix('kissedb', 'cickassKissedb', 24, true);
		_cickass.animation.addByPrefix('kissedc', 'cickassKissedc', 24, true);
		_cickass.animation.addByPrefix('kissedd', 'cickassKissedd', 24, true);
		_cickass.animation.addByPrefix('kissede', 'cickassKissede', 24, true);
		_cickass.animation.addByPrefix('kissedf', 'cickassKissedf', 24, true);
		_cickass.animation.addByPrefix('talking', 'cickassTalking', 24, true);
		
		//Digby
		_digby = new FlxSprite(0, 200);
		_digby.frames = FlxAtlasFrames.fromSparrow(AssetPaths.digby__png, AssetPaths.digby__xml);
		_digby.updateHitbox();
        _digby.antialiasing = true;

		_digby.animation.addByPrefix('idle', 'digbyIdle', 24, true);
		_digby.animation.addByPrefix('kisseda', 'digbyKisseda', 24, true);
		_digby.animation.addByPrefix('kissedb', 'digbyKissedb', 24, true);
		_digby.animation.addByPrefix('kissedc', 'digbyKissedc', 24, true);
		_digby.animation.addByPrefix('kissedd', 'digbyKissedd', 24, true);
		_digby.animation.addByPrefix('kissede', 'digbyKissede', 24, true);
		_digby.animation.addByPrefix('kissedf', 'digbyKissedf', 24, true);
		_digby.animation.addByPrefix('talking', 'digbyTalking', 24, true);
				
		//Ferdinand
		_ferdinand = new FlxSprite(0, 200);
		_ferdinand.frames = FlxAtlasFrames.fromSparrow(AssetPaths.ferdinand__png, AssetPaths.ferdinand__xml);
		_ferdinand.updateHitbox();
        _ferdinand.antialiasing = true;

		_ferdinand.animation.addByPrefix('idle', 'ferdinandIdle', 24, true);
		_ferdinand.animation.addByPrefix('kisseda', 'ferdinandKisseda', 24, true);
		_ferdinand.animation.addByPrefix('kissedb', 'ferdinandKissedb', 24, true);
		_ferdinand.animation.addByPrefix('kissedc', 'ferdinandKissedc', 24, true);
		_ferdinand.animation.addByPrefix('kissedd', 'ferdinandKissedd', 24, true);
		_ferdinand.animation.addByPrefix('kissede', 'ferdinandKissede', 24, true);
		_ferdinand.animation.addByPrefix('kissedf', 'ferdinandKissedf', 24, true);
		_ferdinand.animation.addByPrefix('talking', 'ferdinandTalking', 24, true);
		
		//glottis
		_glottis = new FlxSprite(0, 200);
		_glottis.frames = FlxAtlasFrames.fromSparrow(AssetPaths.glottis__png, AssetPaths.glottis__xml);
		_glottis.updateHitbox();
        _glottis.antialiasing = true;

		_glottis.animation.addByPrefix('idle', 'glottisIdle', 24, true);
		_glottis.animation.addByPrefix('kisseda', 'glottisKisseda', 24, true);
		_glottis.animation.addByPrefix('kissedb', 'glottisKissedb', 24, true);
		_glottis.animation.addByPrefix('kissedc', 'glottisKissedc', 24, true);
		_glottis.animation.addByPrefix('kissedd', 'glottisKissedd', 24, true);
		_glottis.animation.addByPrefix('kissede', 'glottisKissede', 24, true);
		_glottis.animation.addByPrefix('kissedf', 'glottisKissedf', 24, true);
		_glottis.animation.addByPrefix('talking', 'glottisTalking', 24, true);
			
		//Gottsley
		_gottsley = new FlxSprite(0, 200);
		_gottsley.frames = FlxAtlasFrames.fromSparrow(AssetPaths.gottsley__png, AssetPaths.gottsley__xml);
		_gottsley.updateHitbox();
        _gottsley.antialiasing = true;

		_gottsley.animation.addByPrefix('idle', 'gottsleyIdle', 24, true);
		_gottsley.animation.addByPrefix('kisseda', 'gottsleyKisseda', 24, true);
		_gottsley.animation.addByPrefix('kissedb', 'gottsleyKissedb', 24, true);
		_gottsley.animation.addByPrefix('kissedc', 'gottsleyKissedc', 24, true);
		_gottsley.animation.addByPrefix('kissedd', 'gottsleyKissedd', 24, true);
		_gottsley.animation.addByPrefix('kissede', 'gottsleyKissede', 24, true);
		_gottsley.animation.addByPrefix('kissedf', 'gottsleyKissedf', 24, true);
		_gottsley.animation.addByPrefix('talking', 'gottsleyTalking', 24, true);
		
		//Hank
		_hank = new FlxSprite(0, 200);
		_hank.frames = FlxAtlasFrames.fromSparrow(AssetPaths.hank__png, AssetPaths.hank__xml);
		_hank.updateHitbox();
        _hank.antialiasing = true;

		_hank.animation.addByPrefix('idle', 'hankIdle', 24, true);
		_hank.animation.addByPrefix('kisseda', 'hankKisseda', 24, true);
		_hank.animation.addByPrefix('kissedb', 'hankKissedb', 24, true);
		_hank.animation.addByPrefix('kissedc', 'hankKissedc', 24, true);
		_hank.animation.addByPrefix('kissedd', 'hankKissedd', 24, true);
		_hank.animation.addByPrefix('kissede', 'hankKissede', 24, true);
		_hank.animation.addByPrefix('kissedf', 'hankKissedf', 24, true);
		_hank.animation.addByPrefix('talking', 'hankTalking', 24, true);
		
		//Ken
		_ken = new FlxSprite(0, 200);
		_ken.frames = FlxAtlasFrames.fromSparrow(AssetPaths.ken__png, AssetPaths.ken__xml);
		_ken.updateHitbox();
        _ken.antialiasing = true;

		_ken.animation.addByPrefix('idle', 'kenIdle', 24, true);
		_ken.animation.addByPrefix('kisseda', 'kenKisseda', 24, true);
		_ken.animation.addByPrefix('kissedb', 'kenKissedb', 24, true);
		_ken.animation.addByPrefix('kissedc', 'kenKissedc', 24, true);
		_ken.animation.addByPrefix('kissedd', 'kenKissedd', 24, true);
		_ken.animation.addByPrefix('kissede', 'kenKissede', 24, true);
		_ken.animation.addByPrefix('kissedf', 'kenKissedf', 24, true);
		_ken.animation.addByPrefix('talking', 'kenTalking', 24, true);
		
		//Oscar
		_oscar = new FlxSprite(0, 200);
		_oscar.frames = FlxAtlasFrames.fromSparrow(AssetPaths.oscar__png, AssetPaths.oscar__xml);
		_oscar.updateHitbox();
        _oscar.antialiasing = true;

		_oscar.animation.addByPrefix('idle', 'oscarIdle', 24, true);
		_oscar.animation.addByPrefix('kisseda', 'oscarKisseda', 24, true);
		_oscar.animation.addByPrefix('kissedb', 'oscarKissedb', 24, true);
		_oscar.animation.addByPrefix('kissedc', 'oscarKissedc', 24, true);
		_oscar.animation.addByPrefix('kissedd', 'oscarKissedd', 24, true);
		_oscar.animation.addByPrefix('kissede', 'oscarKissede', 24, true);
		_oscar.animation.addByPrefix('kissedf', 'oscarKissedf', 24, true);
		_oscar.animation.addByPrefix('talking', 'oscarTalking', 24, true);
		
		//Ramasama
		_ramasama = new FlxSprite(0, 200);
		_ramasama.frames = FlxAtlasFrames.fromSparrow(AssetPaths.ramasama__png, AssetPaths.ramasama__xml);
		_ramasama.updateHitbox();
        _ramasama.antialiasing = true;

		_ramasama.animation.addByPrefix('idle', 'ramasamaIdle', 24, true);
		_ramasama.animation.addByPrefix('kisseda', 'ramasamaKisseda', 24, true);
		_ramasama.animation.addByPrefix('kissedb', 'ramasamaKissedb', 24, true);
		_ramasama.animation.addByPrefix('kissedc', 'ramasamaKissedc', 24, true);
		_ramasama.animation.addByPrefix('kissedd', 'ramasamaKissedd', 24, true);
		_ramasama.animation.addByPrefix('kissede', 'ramasamaKissede', 24, true);
		_ramasama.animation.addByPrefix('kissedf', 'ramasamaKissedf', 24, true);
		_ramasama.animation.addByPrefix('talking', 'ramasamaTalking', 24, true);
				
		//Reggie
		_reggie = new FlxSprite(0, 200);
		_reggie.frames = FlxAtlasFrames.fromSparrow(AssetPaths.reggie__png, AssetPaths.reggie__xml);
		_reggie.updateHitbox();
        _reggie.antialiasing = true;

		_reggie.animation.addByPrefix('idle', 'reggieIdle', 24, true);
		_reggie.animation.addByPrefix('kisseda', 'reggieKisseda', 24, true);
		_reggie.animation.addByPrefix('kissedb', 'reggieKissedb', 24, true);
		_reggie.animation.addByPrefix('kissedc', 'reggieKissedc', 24, true);
		_reggie.animation.addByPrefix('kissedd', 'reggieKissedd', 24, true);
		_reggie.animation.addByPrefix('kissede', 'reggieKissede', 24, true);
		_reggie.animation.addByPrefix('kissedf', 'reggieKissedf', 24, true);
		_reggie.animation.addByPrefix('talking', 'reggieTalking', 24, true);
		
		//Sammy the Otter
		_sammy = new FlxSprite(0, 200);
		_sammy.frames = FlxAtlasFrames.fromSparrow(AssetPaths.sammy__png, AssetPaths.sammy__xml);
		_sammy.updateHitbox();
        _sammy.antialiasing = true;

		_sammy.animation.addByPrefix('idle', 'sammyIdle', 24, true);
		_sammy.animation.addByPrefix('kisseda', 'sammyKisseda', 24, true);
		_sammy.animation.addByPrefix('kissedb', 'sammyKissedb', 24, true);
		_sammy.animation.addByPrefix('kissedc', 'sammyKissedc', 24, true);
		_sammy.animation.addByPrefix('kissedd', 'sammyKissedd', 24, true);
		_sammy.animation.addByPrefix('kissede', 'sammyKissede', 24, true);
		_sammy.animation.addByPrefix('kissedf', 'sammyKissedf', 24, true);
		_sammy.animation.addByPrefix('talking', 'sammyTalking', 24, true);
		
		//Vernie
		_vernie = new FlxSprite(0, 200);
		_vernie.frames = FlxAtlasFrames.fromSparrow(AssetPaths.vernie__png, AssetPaths.vernie__xml);
		_vernie.updateHitbox();
        _vernie.antialiasing = true;

		_vernie.animation.addByPrefix('idle', 'vernieIdle', 24, true);
		_vernie.animation.addByPrefix('kisseda', 'vernieKisseda', 24, true);
		_vernie.animation.addByPrefix('kissedb', 'vernieKissedb', 24, true);
		_vernie.animation.addByPrefix('kissedc', 'vernieKissedc', 24, true);
		_vernie.animation.addByPrefix('kissedd', 'vernieKissedd', 24, true);
		_vernie.animation.addByPrefix('kissede', 'vernieKissede', 24, true);
		_vernie.animation.addByPrefix('kissedf', 'vernieKissedf', 24, true);
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
		
		add(_vernie);
		add(_sammy);
		add(_reggie);		
		
		add(_digby);
		add(_ken);
		add(_gottsley);
		
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
		
		//Hank is special
		//add(_hank);
		_hank.visible = true;
		_hank.screenCenter();
		_hank.animation.play("idle");
		
		/*
		END OF CHARACTER CREATE
		*/
		
		//create player
		_player = new Player(0, 180);
		_player.screenCenter();
		_player.x -= 120;
		_player.animation.play('idleA');
		add(_player);
		
		_face = new FlxSprite(770, 360);
		_face.frames = FlxAtlasFrames.fromSparrow(AssetPaths.playerFace__png, AssetPaths.playerFace__xml);
		_face.animation.addByPrefix('face', 'playerFace', 0, false);
		_face.animation.play('face');
		_face.antialiasing = true;
		_face.updateHitbox();
		//add(_face);		
		
		/*
		CREATE TEXT 
		*/
		
		// create a new FlxText
		curText = new FlxTypeText(0, 0, 720, "");
		curText.setFormat("assets/fonts/SeaHorses.ttf");
		curText.color = FlxColor.WHITE; // set the color to cyan
		curText.size = 36; // set the text's size to 32px
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
		
		if (hiveCount >= 12){
			_face.animation.frameIndex = 5;
			_player.animation.play('idlef');
			
			isTalking = true;
			curText.alpha = 0;
			curText.text = "[>I met a lot of great people today and socializing with them made me feel a little less alone, but now that they're A PART of me...\n\nI'm just as alone...]\n\n\n\nthanks for playing, be safe in quarantine\n\n-brandon";
			curText.color = FlxColor.YELLOW;
			
			if (FlxG.keys.justPressed.SPACE){
				FlxG.resetGame();
			}
			
			if (cickassKissed == true){
				_cickass.animation.play('kissedf');
			}
			if (ferdinandKissed == true){
				_ferdinand.animation.play('kissedf');
			}
			if (chezKissed == true){
				_chez.animation.play('kissedf');
			}
			if (oscarKissed == true){
				_oscar.animation.play('kissedf');
			}
			if (ramasamaKissed == true){
				_ramasama.animation.play('kissedf');
			}
			if (glottisKissed == true){
				_glottis.animation.play('kissedf');
			}
			if (reggieKissed == true){
				_reggie.animation.play('kissedf');
			}
			if (vernieKissed == true){
				_vernie.animation.play('kissedf');
			}
			if (sammyKissed == true){
				_sammy.animation.play('kissedf');
			}
			if (gottsleyKissed == true){
				_glottis.animation.play('kissedf');
			}
			if (kenKissed == true){
				_ken.animation.play('kissedf');
			}
			if (digbyKissed == true){
				_digby.animation.play('kissedf');
			}
			if (hankKissed == true){
				_hank.animation.play('kissedf');
			}
		}else if (hiveCount >= 11){
			_face.animation.frameIndex = 4;
			_player.animation.play('idlee');
			
			if (cickassKissed == true){
				_cickass.animation.play('kissede');
			}
			if (ferdinandKissed == true){
				_ferdinand.animation.play('kissede');
			}
			if (chezKissed == true){
				_chez.animation.play('kissede');
			}
			if (oscarKissed == true){
				_oscar.animation.play('kissede');
			}
			if (ramasamaKissed == true){
				_ramasama.animation.play('kissede');
			}
			if (glottisKissed == true){
				_glottis.animation.play('kissede');
			}
			if (reggieKissed == true){
				_reggie.animation.play('kissede');
			}
			if (vernieKissed == true){
				_vernie.animation.play('kissede');
			}
			if (sammyKissed == true){
				_sammy.animation.play('kissede');
			}
			if (gottsleyKissed == true){
				_glottis.animation.play('kissede');
			}
			if (kenKissed == true){
				_ken.animation.play('kissede');
			}
			if (digbyKissed == true){
				_digby.animation.play('kissede');
			}
			if (hankKissed == true){
				_hank.animation.play('kissede');
			}
		}else if (hiveCount >= 9){
			_face.animation.frameIndex = 3;
			_player.animation.play('idled');
			
			if (cickassKissed == true){
				_cickass.animation.play('kissedd');
			}
			if (ferdinandKissed == true){
				_ferdinand.animation.play('kissedd');
			}
			if (chezKissed == true){
				_chez.animation.play('kissedd');
			}
			if (oscarKissed == true){
				_oscar.animation.play('kissedd');
			}
			if (ramasamaKissed == true){
				_ramasama.animation.play('kissedd');
			}
			if (glottisKissed == true){
				_glottis.animation.play('kissedd');
			}
			if (reggieKissed == true){
				_reggie.animation.play('kissedd');
			}
			if (vernieKissed == true){
				_vernie.animation.play('kissedd');
			}
			if (sammyKissed == true){
				_sammy.animation.play('kissedd');
			}
			if (gottsleyKissed == true){
				_glottis.animation.play('kissedd');
			}
			if (kenKissed == true){
				_ken.animation.play('kissedd');
			}
			if (digbyKissed == true){
				_digby.animation.play('kissedd');
			}
			if (hankKissed == true){
				_hank.animation.play('kissedd');
			}
		}else if (hiveCount >= 6){
			_face.animation.frameIndex = 2;
			_player.animation.play('idlec');
			
			if (cickassKissed == true){
				_cickass.animation.play('kissedc');
			}
			if (ferdinandKissed == true){
				_ferdinand.animation.play('kissedc');
			}
			if (chezKissed == true){
				_chez.animation.play('kissedc');
			}
			if (oscarKissed == true){
				_oscar.animation.play('kissedc');
			}
			if (ramasamaKissed == true){
				_ramasama.animation.play('kissedc');
			}
			if (glottisKissed == true){
				_glottis.animation.play('kissedc');
			}
			if (reggieKissed == true){
				_reggie.animation.play('kissedc');
			}
			if (vernieKissed == true){
				_vernie.animation.play('kissedc');
			}
			if (sammyKissed == true){
				_sammy.animation.play('kissedc');
			}
			if (gottsleyKissed == true){
				_glottis.animation.play('kissedc');
			}
			if (kenKissed == true){
				_ken.animation.play('kissedc');
			}
			if (digbyKissed == true){
				_digby.animation.play('kissedc');
			}
			if (hankKissed == true){
				_hank.animation.play('kissedc');
			}
		}else if (hiveCount >= 3){
			_face.animation.frameIndex = 1;
			_player.animation.play('idleb');
			
			if (cickassKissed == true){
				_cickass.animation.play('kissedb');
			}
			if (ferdinandKissed == true){
				_ferdinand.animation.play('kissedb');
			}
			if (chezKissed == true){
				_chez.animation.play('kissedb');
			}
			if (oscarKissed == true){
				_oscar.animation.play('kissedb');
			}
			if (ramasamaKissed == true){
				_ramasama.animation.play('kissedb');
			}
			if (glottisKissed == true){
				_glottis.animation.play('kissedb');
			}
			if (reggieKissed == true){
				_reggie.animation.play('kissedb');
			}
			if (vernieKissed == true){
				_vernie.animation.play('kissedb');
			}
			if (sammyKissed == true){
				_sammy.animation.play('kissedb');
			}
			if (gottsleyKissed == true){
				_glottis.animation.play('kissedb');
			}
			if (kenKissed == true){
				_ken.animation.play('kissedb');
			}
			if (digbyKissed == true){
				_digby.animation.play('kissedb');
			}
			if (hankKissed == true){
				_hank.animation.play('kissedb');
			}
		}else{
			_face.animation.frameIndex = 0;
			_player.animation.play('idlea');
			
			if (cickassKissed == true){
				_cickass.animation.play('kisseda');
			}
			if (ferdinandKissed == true){
				_ferdinand.animation.play('kisseda');
			}
			if (chezKissed == true){
				_chez.animation.play('kisseda');
			}
			if (oscarKissed == true){
				_oscar.animation.play('kisseda');
			}
			if (ramasamaKissed == true){
				_ramasama.animation.play('kisseda');
			}
			if (glottisKissed == true){
				_glottis.animation.play('kisseda');
			}
			if (reggieKissed == true){
				_reggie.animation.play('kisseda');
			}
			if (vernieKissed == true){
				_vernie.animation.play('kisseda');
			}
			if (sammyKissed == true){
				_sammy.animation.play('kisseda');
			}
			if (gottsleyKissed == true){
				_glottis.animation.play('kisseda');
			}
			if (kenKissed == true){
				_ken.animation.play('kisseda');
			}
			if (digbyKissed == true){
				_digby.animation.play('kisseda');
			}
			if (hankKissed == true){
				_hank.animation.play('kisseda');
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
				if(_player.x < 320){
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
				if (level == 4){
					if (worldScale < 1.4){
						worldScale += 0.005;
					}
				}else{
					worldScale += 0.005;
				}
				
				tempScale += 0.1;
			}
			
			//Who ya talkin' too?
			if (FlxG.keys.justPressed.SPACE){
				if (debugText.text == "Biker Hank" && !hankKissed){
					isTalking = true;
					curDialogue = hankText;
					_hank.animation.play("talking");
				}
				
				//Level 1 Dialogue
				if (level == 1){
					if (debugText.text == "Chez Beaks" && !chezKissed){
						isTalking = true;
						curDialogue = chezText;
						_chez.animation.play("talking");
					}else if (debugText.text == "Ferdinand" && !ferdinandKissed){
						isTalking = true;
						curDialogue = ferdinandText;
						_ferdinand.animation.play("talking");
					}else if (debugText.text == "Cickass Cat" && !cickassKissed){
						isTalking = true;
						curDialogue = cickassText;
						_cickass.animation.play("talking");
					}	
				}
					
				//Level 2 Dialogue
				if (level == 2){
					if (debugText.text == "Glottis is a Glutton" && !glottisKissed){
						isTalking = true;
						curDialogue = glottisText;
						_glottis.animation.play("talking");
					}else if (debugText.text == "Ramasama-kun" && !ramasamaKissed){
						isTalking = true;
						curDialogue = ramasamaText;
						_ramasama.animation.play("talking");
					}else if (debugText.text == "Oscar's Hot Hot Dogs" && !oscarKissed){
						isTalking = true;
						curDialogue = oscarText;
						_oscar.animation.play("talking");
					}	
				}
					
				//Level 3 Dialogue
				if (level == 3){
					if (debugText.text == "Reggie" && !reggieKissed){
						isTalking = true;
						curDialogue = reggieText;
						_glottis.animation.play("talking");
					}else if (debugText.text == "Vern 'Vernie' Varns" && !vernieKissed){
						isTalking = true;
						curDialogue = vernieText;
						_ramasama.animation.play("talking");
					}else if (debugText.text == "Sammy Schwimmer" && !sammyKissed){
						isTalking = true;
						curDialogue = sammyText;
						_oscar.animation.play("talking");
					}	
				}
					
				//Level 4 Dialogue
				if (level == 4){
					if (debugText.text == "Gottsley" && !gottsleyKissed){
						isTalking = true;
						curDialogue = gottsleyText;
						_glottis.animation.play("talking");
					}else if (debugText.text == "Ken, sup" && !kenKissed){
						isTalking = true;
						curDialogue = kenText;
						_ramasama.animation.play("talking");
					}else if (debugText.text == "Digby" && !digbyKissed){
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
						if (!ferdinandKissed){
							hiveCount += 1;
							ferdinandKissed = true;
						}
					}
					if (debugText.text == "Cickass Cat"){
						if (!cickassKissed){
							hiveCount += 1;
							cickassKissed = true;
						}
					}		
					if (debugText.text == "Glottis is a Glutton"){
						if (!glottisKissed){
							hiveCount += 1;
							glottisKissed = true;
						}
					}	
					if (debugText.text == "Ramasama-kun"){
						if (!ramasamaKissed){
							hiveCount += 1;
							ramasamaKissed = true;
						}
					}
					if (debugText.text == "Oscar's Hot Hot Dogs"){
						if (!oscarKissed){
							hiveCount += 1;
							oscarKissed = true;
						}
					}	
					if (debugText.text == "Reggie"){
						if (!reggieKissed){
							hiveCount += 1;
							reggieKissed = true;
						}
					}
					if (debugText.text == "Vern 'Vernie' Varns"){
						if (!vernieKissed){
							hiveCount += 1;
							vernieKissed = true;
						}
					}
					if (debugText.text == "Sammy Schwimmer"){
						if (!sammyKissed){
							hiveCount += 1;
							sammyKissed = true;
						}
					}
					if (debugText.text == "Gottsley"){
						if (!gottsleyKissed){
							hiveCount += 1;
							gottsleyKissed = true;
						}
					}
					if (debugText.text == "Ken, sup"){
						if (!kenKissed){
							hiveCount += 1;
							kenKissed = true;
						}
					}
					if (debugText.text == "Digby"){
						if (!digbyKissed){
							hiveCount += 1;
							digbyKissed = true;
						}
					}
					if (debugText.text == "Biker Hank"){
						if (!hankKissed){
							hiveCount += 1;
							hankKissed = true;
						}
					}
				}
			}
		}
		
		//WORLD SCALE TWEENING	
		smallScale = (worldScale * worldScale * 50) + 450;
		middleScale = (100 / (worldScale / 2)) - 100;
		bigScale = (worldScale * worldScale * 150) + 450;
		
		//so it doesnt all suck
		_cickass.updateHitbox();
		_ferdinand.updateHitbox();
		_chez.updateHitbox();
		_oscar.updateHitbox();
		_glottis.updateHitbox();
		_ramasama.updateHitbox();
		_sammy.updateHitbox();
		_reggie.updateHitbox();
		_vernie.updateHitbox();
		_gottsley.updateHitbox();
		_digby.updateHitbox();
		
		//Backdrop sclaing
		FlxTween.tween(backdrop1.scale, { x: worldScale, y: worldScale },  0.001);
		FlxTween.tween(backdrop2.scale, { x: worldScale * 0.17, y: worldScale * 0.17 },  0.001);
		
		//Level Code
		if (prevLevel != level){
			if (worldScale > 1.5){ worldScale = 0.25; }
			if (worldScale < 0.25){ worldScale = 1.5; }

			prevLevel = level;
		}
		
		if (level < 1){ level = 1; }
		if (level > 4){ level = 4; }
		
		if (worldScale > 1.5){	level += 1;	}
		if (worldScale < 0.25){	level -= 1;	}
			
		if (level == 1){
			_cickass.visible = true;
			_ferdinand.visible = true;
			_chez.visible = true;
			
			//position in level
			FlxTween.tween(_cickass.scale, { x: (tempScale/150) * (worldScale * worldScale), y: (tempScale/150) * (worldScale * worldScale) },  0.1);
			_cickass.x = smallScale;
			_cickass.y = (worldScale * -100) + 270;
			
			FlxTween.tween(_ferdinand.scale, { x: (tempScale / 75) * (worldScale * worldScale), y: (tempScale / 75) * (worldScale * worldScale) },  0.1);
			_ferdinand.x = middleScale;
			if (_ferdinand.x > 480){
				_ferdinand.alpha = 0;
			}
			_ferdinand.y = (worldScale * -100) + 270;
			
			FlxTween.tween(_chez.scale, { x: (tempScale/40) * (worldScale * worldScale), y: (tempScale/40) * (worldScale * worldScale) },  0.1);
			_chez.x = bigScale;
			_chez.y = (worldScale * -100) + 240;
			
			//Name popup bottom left and text color
			if (_player.overlaps(_chez) && _chez.scale.x > 0.6 && _chez.scale.x < 1.2){
				debugText.text = "Chez Beaks";
				debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(51, 51, 51, 255), 3);
				curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(51, 51, 51, 255), 3);
			}else if (_player.overlaps(_ferdinand) && _ferdinand.scale.x > 0.6 && _ferdinand.scale.x < 1.2){
				debugText.text = "Ferdinand";
				debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(61, 64, 106, 255), 3);
				curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(61, 64, 106, 255), 3);
			}else if (_player.overlaps(_cickass) && _cickass.scale.x > 0.6 && _cickass.scale.x < 1.2){
				debugText.text = "Cickass Cat";
				debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(255, 163, 5, 255), 3);
				curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(255, 163, 5, 255), 3);
			}else{
				debugText.text = "";
			}
		}else{
			_cickass.visible = false;
			_ferdinand.visible = false;
			_chez.visible = false;
		}
		
		//Level 2
		if (level == 2){
			_oscar.visible = true;
			_ramasama.visible = true;
			_glottis.visible = true;
		
			//set position and scale
			FlxTween.tween(_oscar.scale, { x: (tempScale/150) * (worldScale * worldScale), y: (tempScale/150) * (worldScale * worldScale) },  0.1);
			_oscar.x = smallScale;
			_oscar.y = (worldScale * -100) + 225;
			
			FlxTween.tween(_ramasama.scale, { x: (tempScale/75) * (worldScale * worldScale), y: (tempScale/75) * (worldScale * worldScale) },  0.1);
			_ramasama.x = middleScale;
			if (_ramasama.x > 480){
				_ramasama.alpha = 0;
			}
			_ramasama.y = (worldScale * -100) + 225;
			
			FlxTween.tween(_glottis.scale, { x: (tempScale/40) * (worldScale * worldScale), y: (tempScale/40) * (worldScale * worldScale) },  0.1);
			_glottis.x = bigScale;
			_glottis.y = (worldScale * -100) + 240;
			
			//name in bottom left
			if (_player.overlaps(_glottis) && _glottis.scale.x > 0.6 && _glottis.scale.x < 1.2){
				debugText.text = "Glottis is a Glutton";
				debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(204, 115, 159, 255), 3);
				curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(204, 115, 159, 255), 3);
			}else if (_player.overlaps(_ramasama) && _ramasama.scale.x > 0.6 && _ramasama.scale.x < 1.2){
				debugText.text = "Ramasama-kun";
				debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(105, 11, 20, 255), 3);
				curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(105, 11, 20, 255), 3);
			}else if (_player.overlaps(_oscar) && _oscar.scale.x > 0.6 && _oscar.scale.x < 1.2){
				debugText.text = "Oscar's Hot Hot Dogs";
				debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(51, 153, 255, 255), 3);
				curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(51, 153, 255, 255), 3);
			}else{
				debugText.text = "";
			}
		}else{
			_oscar.visible = false;
			_ramasama.visible = false;
			_glottis.visible = false;
		}		
		
		//Level 3
		if (level == 3){
			_reggie.visible = true;
			_vernie.visible = true;
			_sammy.visible = true;
		
			//set position and scale
			FlxTween.tween(_vernie.scale, { x: (tempScale/150) * (worldScale * worldScale), y: (tempScale/150) * (worldScale * worldScale) },  0.1);
			_vernie.x = smallScale;
			_vernie.y = (worldScale * -100) + 240;
			
			FlxTween.tween(_sammy.scale, { x: (tempScale/75) * (worldScale * worldScale), y: (tempScale/75) * (worldScale * worldScale) },  0.1);
			_sammy.x = middleScale;
			if (_sammy.x > 480){
				_sammy.alpha = 0;
			}
			_sammy.y = (worldScale * -100) + 180;
			
			FlxTween.tween(_reggie.scale, { x: (tempScale/40) * (worldScale * worldScale), y: (tempScale/40) * (worldScale * worldScale) },  0.1);
			_reggie.x = bigScale;
			_reggie.y = (worldScale * -100) + 240;
			
			//change bottom left text and color
			if (_player.overlaps(_reggie) && _reggie.scale.x > 0.6 && _reggie.scale.x < 1.2){
				debugText.text = "Reggie";
				debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(0, 204, 153, 255), 3);
				curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(0, 204, 153, 255), 3);
			}else if (_player.overlaps(_sammy) && _sammy.scale.x > 0.6 && _sammy.scale.x < 1.2){
				debugText.text = "Sammy Schwimmer";
				debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(232, 229, 118, 255), 3);
				curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(232, 229, 118, 255), 3);
			}else if (_player.overlaps(_vernie) && _vernie.scale.x > 0.6 && _vernie.scale.x < 1.2){
				debugText.text = "Vern 'Vernie' Varns";
				debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(79, 54, 126, 255), 3);
				curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(79, 54, 126, 255), 3);
			}else{
				debugText.text = "";
			}
		}else{
			_reggie.visible = false;
			_vernie.visible = false;
			_sammy.visible = false;
		}
		
		//Level 4
		if (level == 4){
			_gottsley.visible = true;
			_ken.visible = true;
			_digby.visible = true;
		
			//set position and scale
			FlxTween.tween(_digby.scale, { x: (tempScale/150) * (worldScale * worldScale), y: (tempScale/150) * (worldScale * worldScale) },  0.1);
			_digby.x = smallScale;
			_digby.y = (worldScale * -100) + 270;
			
			FlxTween.tween(_ken.scale, { x: (tempScale/100) * (worldScale * worldScale), y: (tempScale/100) * (worldScale * worldScale) },  0.1);
			_ken.x = middleScale - 120;
			if (_ken.x > 480){
				_ken.alpha = 0;
			}
			_ken.y = (worldScale * -100) + 150;
			
			FlxTween.tween(_gottsley.scale, { x: (tempScale/40) * (worldScale * worldScale), y: (tempScale/40) * (worldScale * worldScale) },  0.1);
			_gottsley.x = bigScale;
			_gottsley.y = (worldScale * -100) + 225;
			
			//change bottom left text and color
			if (_player.overlaps(_gottsley) && _gottsley.scale.x > 0.6 && _gottsley.scale.x < 1.2){
				debugText.text = "Gottsley";
				debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(171, 61, 61, 255), 3);
				curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(171, 61, 61, 255), 3);
			}else if (_player.overlaps(_ken) && _ken.scale.x > 0.6 && _ken.scale.x < 1.2){
				debugText.text = "Ken, sup";
				debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(97, 129, 97, 255), 3);
				curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(97, 129, 97, 255), 3);
			}else if (_player.overlaps(_digby) && _digby.scale.x > 0.6 && _digby.scale.x < 1.2){
				debugText.text = "Digby";
				debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(87, 130, 151, 255), 3);
				curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(87, 130, 151, 255), 3);
			}else{
				debugText.text = "";
			}		
		}else{
			_gottsley.visible = false;
			_ken.visible = false;
			_digby.visible = false;
		}
		
		/*
		MISC EXTRA BITS
		*/
		
		//FADE OUT AND POP IN LOGIC
		if (_chez.scale.x >= 1.35 || _chez.scale.x <= 0.18){
			FlxTween.tween(_chez, { alpha: 0 }, 1, { ease: FlxEase.expoOut } );
		}
		if(_chez.alpha != 1){
			if (_chez.scale.x < 1.35 && _chez.scale.x > 0.18){
				_chez.alpha = 1;
			}
		}
		
		if (_ferdinand.scale.x >= 1.35 || _ferdinand.scale.x <= 0.24){
			FlxTween.tween(_ferdinand, { alpha: 0 }, 1, { ease: FlxEase.expoOut } );
		}
		if(_ferdinand.alpha != 1){
			if (_ferdinand.scale.x < 1.35 && _ferdinand.scale.x > 0.21){
				_ferdinand.alpha = 1;
			}
		}	
		
		if (_cickass.scale.x >= 1.35 || _cickass.scale.x <= 0.18){
			FlxTween.tween(_cickass, { alpha: 0 }, 1, { ease: FlxEase.expoOut } );
		}
		if(_cickass.alpha != 1){
			if (_cickass.scale.x < 1.35 && _cickass.scale.x > 0.18){
				_cickass.alpha = 1;
			}
		}	
		
		if (_glottis.scale.x >= 1.35 || _glottis.scale.x <= 0.18){
			FlxTween.tween(_glottis, { alpha: 0 }, 1, { ease: FlxEase.expoOut } );
		}
		if(_glottis.alpha != 1){
			if (_glottis.scale.x < 1.35 && _glottis.scale.x > 0.18){
				_glottis.alpha = 1;
			}
		}	
			
		if (_ramasama.scale.x >= 1.35 || _ramasama.scale.x <= 0.18){
			FlxTween.tween(_ramasama, { alpha: 0 }, 1, { ease: FlxEase.expoOut } );
		}
		if(_ramasama.alpha != 1){
			if (_ramasama.scale.x < 1.35 && _ramasama.scale.x > 0.18){
				_ramasama.alpha = 1;
			}
		}
		
		if (_oscar.scale.x >= 1.35 || _oscar.scale.x <= 0.18){
			FlxTween.tween(_oscar, { alpha: 0 }, 1, { ease: FlxEase.expoOut } );
		}
		if(_oscar.alpha != 1){
			if (_oscar.scale.x < 1.35 && _oscar.scale.x > 0.18){
				_oscar.alpha = 1;
			}
		}
		
		if (_reggie.scale.x >= 1.35 || _reggie.scale.x <= 0.18){
			FlxTween.tween(_reggie, { alpha: 0 }, 1, { ease: FlxEase.expoOut } );
		}
		if(_reggie.alpha != 1){
			if (_reggie.scale.x < 1.35 && _reggie.scale.x > 0.18){
				_reggie.alpha = 1;
			}
		}
			
		if (_sammy.scale.x >= 1.35 || _sammy.scale.x <= 0.18){
			FlxTween.tween(_sammy, { alpha: 0 }, 1, { ease: FlxEase.expoOut } );
		}
		if(_sammy.alpha != 1){
			if (_sammy.scale.x < 1.35 && _sammy.scale.x > 0.18){
				_sammy.alpha = 1;
			}
		}
		
		if (_vernie.scale.x >= 1.35 || _vernie.scale.x <= 0.18){
			FlxTween.tween(_vernie, { alpha: 0 }, 1, { ease: FlxEase.expoOut } );
		}
		if(_vernie.alpha != 1){
			if (_vernie.scale.x < 1.35 && _vernie.scale.x > 0.18){
				_vernie.alpha = 1;
			}
		}
		
		if (_gottsley.scale.x >= 1.35 || _gottsley.scale.x <= 0.18){
			FlxTween.tween(_gottsley, { alpha: 0 }, 1, { ease: FlxEase.expoOut } );
		}
		if(_gottsley.alpha != 1){
			if (_gottsley.scale.x < 1.35 && _gottsley.scale.x > 0.18){
				_gottsley.alpha = 1;
			}
		}
			
		if (_ken.scale.x >= 1 || _ken.scale.x <= 0.18){
			FlxTween.tween(_ken, { alpha: 0 }, 1, { ease: FlxEase.expoOut } );
		}
		if(_ken.alpha != 1){
			if (_ken.scale.x < 1 && _ken.scale.x > 0.18){
				_ken.alpha = 1;
			}
		}
		
		if (_digby.scale.x >= 1.35 || _digby.scale.x <= 0.18){
			FlxTween.tween(_digby, { alpha: 0 }, 1, { ease: FlxEase.expoOut } );
		}
		if(_digby.alpha != 1){
			if (_digby.scale.x < 1.35 && _digby.scale.x > 0.18){
				_digby.alpha = 1;
			}
		}
		
		//Hank
		FlxTween.tween(_hank.scale, { x: (worldScale * worldScale), y: (worldScale * worldScale) },  0.1);
		
		if (!isTalking && debugText.text != "Biker Hank" && !hankKissed){
			_hank.x -= worldScale * 12;
		}
		
		_hank.y = (worldScale * -100) + 120;
		
		if (_hank.scale.x >= 1 || _hank.scale.x <= 0.7){
			FlxTween.tween(_hank, { alpha: 0 }, 1, { ease: FlxEase.expoOut } );
		}
		if(_hank.alpha != 1){
			if (_hank.scale.x < 1.35 && _hank.scale.x > 0.18){
				_hank.alpha = 1;
			}
		}
		/*
		if (_player.overlaps(_hank) && _hank.scale.x > 0.6 && _hank.scale.x < 1){
			debugText.text = "Biker Hank";
			debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(255, 102, 153, 255), 3);
			curText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.fromRGB(255, 102, 153, 255), 3);
		}else{
			debugText.text = "";
		}
		*/
		if (_hank.x < -1080){
			_hank.x = 1920;
		}
		
		//default bottom left text
		if (debugText.text == ""){
			debugText.text = "OBJECTIVE: Get Kisses, Assimilate";
			debugText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.CYAN, 3);
		}
	}
}