package clases;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class RoguePixel extends FlxSprite
{

	public function new(?X:Float=0, ?Y:Float=0, ?color:Int) 
	{
		super(X, Y);
		pixelPerfectPosition = true;
		makeGraphic(1, 1, FlxColor.fromInt(color));
		velocity.x = Math.random() * 20 - 10;
		velocity.y = -Math.random() * 90;
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		velocity.y += 200 * elapsed;
		if (StageTools.FueraDePantalla(getPosition()))
		{
			destroy();
		}
	}
}