package clases;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class ScrollingBackground extends FlxObject
{
	var background:FlxSprite = new FlxSprite();
	var backgroundUp:FlxSprite = new FlxSprite();
	var backgroundDown:FlxSprite = new FlxSprite();
	public var speed:Float = 12;
	private var stageY:Float = 0;
	public function new(imageAsset:FlxGraphicAsset) 
	{
		super(0, 0, 0, 0);
		background.loadGraphic(imageAsset); 
		backgroundDown.loadGraphic(imageAsset); 
		backgroundUp.loadGraphic(imageAsset); 
		FlxG.state.add(background);
		FlxG.state.add(backgroundDown);
		FlxG.state.add(backgroundUp);
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		stageY += elapsed * speed;
		background.y = stageY % FlxG.height;
		backgroundUp.y = stageY % FlxG.height - FlxG.height;
		backgroundDown.y = stageY % FlxG.height + FlxG.height;
		if (FlxG.keys.pressed.W)
		{
			speed ++;
		}
		
		if (FlxG.keys.pressed.S)
		{
			speed --;
		}
	}
}