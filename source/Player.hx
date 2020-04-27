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

		animation.addByPrefix('idleA', 'playerIdlea', 24, true);
		animation.addByPrefix('idleB', 'playerIdleb', 24, true);
		animation.addByPrefix('idleC', 'playerIdlec', 24, true);
		animation.addByPrefix('idleD', 'playerIdled', 24, true);
		animation.addByPrefix('idleE', 'playerIdlee', 24, true);
		animation.addByPrefix('idleF', 'playerIdlef', 24, true);

		FlxG.log.add("added player");
	}
}