package clases;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.system.FlxAssets.FlxSoundAsset;

/**
 * ...
 * @author ...
 */
class EnjambreMusic extends FlxObject
{
	var notes:Array<DelayedNote> = [];
	var noteCount:Array<Int> = [];
	var index:Int = 0;
	var partituraIndex:Int = 0;
	var timeUnit:Float = 1;
	public function new(){
		FlxG.watch.add(this, "index");
		super(0, 0);
		loadNotes();
		
	}
	function loadNotes(){		
		notes.push(new DelayedNote(AssetPaths.M1__ogg, 0));
		noteCount.push(1);
		
		notes.push(new DelayedNote(AssetPaths.M2__ogg,0));
		noteCount.push(1);
		
		notes.push(new DelayedNote(AssetPaths.M3__ogg, 0));
		noteCount.push(1);
		
		notes.push(new DelayedNote(AssetPaths.M4__ogg,0));
		noteCount.push(1);
		
		notes.push(new DelayedNote(AssetPaths.M1__ogg, 0));
		notes.push(new DelayedNote(AssetPaths.Ma__ogg, 0));
		noteCount.push(2);
		
		notes.push(new DelayedNote(AssetPaths.M2__ogg, 0));
		notes.push(new DelayedNote(AssetPaths.Ma__ogg, 0));
		notes.push(new DelayedNote(AssetPaths.Mb__ogg, 0));
		noteCount.push(3);
		
		notes.push(new DelayedNote(AssetPaths.M3__ogg, 0));
		notes.push(new DelayedNote(AssetPaths.Ma2__ogg, 0));
		notes.push(new DelayedNote(AssetPaths.Mb__ogg, 0));
		
		notes.push(new DelayedNote(AssetPaths.Ma2__ogg, 0.25));
		
		notes.push(new DelayedNote(AssetPaths.Ma2__ogg, 0.5));
		notes.push(new DelayedNote(AssetPaths.Mb__ogg, 0.5));
		noteCount.push(6);
		
		notes.push(new DelayedNote(AssetPaths.M4__ogg, 0));
		notes.push(new DelayedNote(AssetPaths.Ma__ogg, 0));
		notes.push(new DelayedNote(AssetPaths.Mb__ogg, 0));
		noteCount.push(3);
		/*
		notes.push(new DelayedNote(AssetPaths.SpaceInvadersMusic1_5__wav,0));
		noteCount.push(1);		
		notes.push(new DelayedNote(AssetPaths.SpaceInvadersMusic1_6__wav,0));
		noteCount.push(1);
		notes.push(new DelayedNote(AssetPaths.SpaceInvadersMusic1_7__wav,0));
		notes.push(new DelayedNote(AssetPaths.SpaceInvadersMusic1_8__wav,0.25));
		notes.push(new DelayedNote(AssetPaths.SpaceInvadersMusic1_9__wav,0.5));
		noteCount.push(3);
		notes.push(new DelayedNote(AssetPaths.SpaceInvadersMusic1_10__wav, 0));
		noteCount.push(1);
		*/
		for (i in 0...notes.length)
		{
			FlxG.state.add(notes[i]);
		}
	}
	public function setTimeUnit(TimeUnit:Float)
	{
		timeUnit = TimeUnit;
		for (i in 0...notes.length)
		{
			notes[i].timeUnit = timeUnit;
		}
	}
	public function play(){			
		for (noteNumber in 0...noteCount[partituraIndex])
		{
			notes[index].play();
			index ++;			
		}
		partituraIndex++;	
		if (partituraIndex >= noteCount.length)
		{
			index = 0;
			partituraIndex = 0;
		}	
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
	}
}