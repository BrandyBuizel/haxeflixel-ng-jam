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

		animation.addByPrefix('idlea', 'playerIdlea', 24, true);
		animation.addByPrefix('idleb', 'playerIdleb', 24, true);
		animation.addByPrefix('idlec', 'playerIdlec', 24, true);
		animation.addByPrefix('idled', 'playerIdled', 24, true);
		animation.addByPrefix('idlee', 'playerIdlee', 24, true);
		animation.addByPrefix('idlef', 'playerIdlef', 24, true);

		FlxG.log.add("added player");
	}
}