package clases;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class LittleExplosion extends FlxSprite
{
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.littleExplosion__png, true, 20, 17);
		x -= width/2;
		y -= height/2;
		FlxG.state.add(this);
		animation.add("boom", [0,1,0,1], 16, false);
		animation.play("boom");		
		animation.finishCallback = complete;
	}
	
	private function complete(name:String)
	{
		destroy();
	}
	
}