package clases;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.system.FlxAssets.FlxSoundAsset;

/**
 * ...
 * @author ...
 */
class DelayedNoteGroup extends FlxObject
{
	var sound:DelayedNote;
	var play:false;
	public function new(Sound:FlxSoundAsset,delay:Float) 
	{
		super(0, 0);
		sound = new DelayedNote(Sound);
		if (delay == 0)
		{
			sound.play();
		}
	}
	
	public function play(){		
		sound.play();		
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
	}

	
}