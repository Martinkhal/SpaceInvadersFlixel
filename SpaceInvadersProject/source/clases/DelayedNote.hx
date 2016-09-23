package clases;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.system.FlxAssets.FlxSoundAsset;

/**
 * ...
 * @author ...
 */
class DelayedNote extends FlxObject
{
	var sound:FlxSoundAsset;
	var delay:Float = 0;
	var delayCooldown:Float = 0;
	var playLater:Bool = false;
	public var timeUnit:Float = 1;
	public function new(Sound:FlxSoundAsset, Delay:Float) 
	{
		super(0, 0);
		sound = Sound;		
		delay = Delay;
	}
	
	public function play(){	
		if (delay <= 0)
		{
			FlxG.sound.play(sound,0.3);	
		}else{
			playLater = true;
			delayCooldown = delay*timeUnit;
		}
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (playLater)
		{
			delayCooldown -= elapsed;
			if (delayCooldown <= 0)
			{
				FlxG.sound.play(sound,0.3);	
				playLater = false;
			}
		}
	}
}