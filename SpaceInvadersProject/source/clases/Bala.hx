package sprites;

import flixel.FlxSprite;
import flixel.animation.FlxAnimation;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.animation.FlxAnimation;
import flixel.FlxG;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class Bala extends FlxSprite
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		makeGraphic (2, 4);
		color = FlxColor.WHITE;
		velocity.y -= 500;
	
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (x > FlxG.width || x < 0)
		destroy();
	}
	
}