package clases;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Points extends FlxSprite
{
	public function new(?X:Float=0, ?Y:Float=0, ?score:Int=1, ?player:Bool=false) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.points__png, true, 28, 25);
		x -= width/2;
		y -= height/2;
		FlxG.state.add(this);
		animation.add("player", [0, 1, 2, 2], 18,false);
		animation.add("score100", [0, 1, 2, 3, 4, 5, 4], 18,false);
		animation.add("score200", [6,7,8,9,10,11,10], 18, false);
		animation.add("score300", [12,13,14,15,16,17,16], 18, false);
		animation.add("score500", [18, 19, 20, 21, 22, 23, 22], 18, false);
		if (!player)
		{
			animation.play("score"+ Std.string(score));		
		}else{
			animation.play("player");		
		}
		
		animation.finishCallback = complete;
	}
	
	private function complete(name:String)
	{
		destroy();
	}
	
}