package;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxVector;
import flixel.math.FlxVelocity;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.input.gamepad.FlxGamepad;
import flixel.graphics.frames.FlxAtlasFrames;


class Player extends FlxSprite 
{
	var interacting:Bool;
	
	public function new(x:Float, y:Float):Void
	{
		super(x, y);
		
		var tex = FlxAtlasFrames.fromSparrow(AssetPaths.player__png, AssetPaths.player__xml);
		frames = tex;
        //setGraphicSize(0, 100);
        updateHitbox();
        antialiasing = true;

		animation.addByPrefix('idle', 'playerIdle', 24, true);
		
		//setFacingFlip(FlxObject.LEFT, true, false);
        //setFacingFlip(FlxObject.RIGHT, false, false);

		animation.play('idle');
		
		interacting = false;	

		FlxG.log.add("added player");
	}
		
	public function playerMovement():Void
	{
		
		if (FlxG.keys.anyPressed([W, A, S, D, "UP", "DOWN", "LEFT", "RIGHT"]))
		{
			//Depth, Scale Camera
			if (FlxG.keys.anyPressed(["S", "DOWN"]))
			{
				
			}
			
			if (FlxG.keys.anyPressed(["W", "UP"]))
			{
				
			}
			
			//Move Left and Right
			if (FlxG.keys.anyPressed(["A", "LEFT"]))
			{
				
			}
			
			if (FlxG.keys.anyPressed(["D", "RIGHT"]))
			{
				
			}
			
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		interacting = FlxG.keys.justPressed.SPACE;
	}
	
	
	private function gamepadControls(gamepad:FlxGamepad):Bool
	{
		interacting = gamepad.anyJustPressed(["A"]) || FlxG.keys.justPressed.SPACE;
			
		if (gamepad.anyPressed(["DOWN", "DPAD_DOWN", "LEFT_STICK_DIGITAL_DOWN", "UP", "DPAD_UP", "LEFT_STICK_DIGITAL_UP", "LEFT", "DPAD_LEFT", "LEFT_STICK_DIGITAL_LEFT", "RIGHT", "DPAD_RIGHT", "LEFT_STICK_DIGITAL_RIGHT"]))
		{
				
			if (gamepad.anyPressed(["DOWN", "DPAD_DOWN", "LEFT_STICK_DIGITAL_DOWN"]))
			{

			}
			if (gamepad.anyPressed(["UP", "DPAD_UP", "LEFT_STICK_DIGITAL_UP"]))
			{

			}
			if (gamepad.anyPressed(["LEFT", "DPAD_LEFT", "LEFT_STICK_DIGITAL_LEFT"]))
			{

			}
			if (gamepad.anyPressed(["RIGHT", "DPAD_RIGHT", "LEFT_STICK_DIGITAL_RIGHT"]))
			{

			}
			return true;
		}
		return false;
	}
	
	/*
	private function bobShit():Void
	{
		jumpBoost++;
		
		
		C = FlxMath.fastCos(8 * jumpBoost * FlxG.elapsed);
		
		if (C < 0)
		{
			if (!justStepped)
			{
				justStepped = true;
				if (stepSoundType != null)
					FlxG.sound.play("assets/sounds/walk_" + stepSoundType + FlxG.random.int(1, 3) + ".mp3", 0.2);
			}
			
			jumpBoost += 4;
			C = 0;
		}
		else
			justStepped = false;
		
		offset.y = (C * 1.3) + actualOffsetLOL;
		
		C *= speed;
	}
	
	public function showControls():Null<FlxSprite>
	{
		if (FlxG.onMobile)
			return null;
		
		controls = new FlxSprite();
		controls.loadGraphic("assets/images/ui/ftue_arrow_keys.png", true, 31, 19);
		controls.animation.add("anim", [0,1,0,2,0,3,0,4], 4);
		controls.animation.play("anim");
		controls.offset.y = controls.height + height;
		controls.scale.set();
		return controls;
	}
	
	public function giveKnife()
	{
		knife = new FlxSprite();
		knife.loadGraphic("assets/images/knifeAnim.png", true, 15, 2);
		knife.animation.add("stab", [0,1,2,3], 20, false);
		knife.visible = false;
		return knife;
	}
	*/
}