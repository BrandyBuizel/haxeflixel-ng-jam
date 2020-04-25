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
	public function new(x:Float, y:Float):Void
	{
		super(x, y);
		
		var tex = FlxAtlasFrames.fromSparrow(AssetPaths.player__png, AssetPaths.player__xml);
		frames = tex;
        updateHitbox();
        antialiasing = true;

		animation.addByPrefix('idle', 'playerIdle', 24, true);

		FlxG.log.add("added player");
	}
	
	private function gamepadControls(gamepad:FlxGamepad):Bool
	{
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
}