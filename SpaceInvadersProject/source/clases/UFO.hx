package clases;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
/**
 * ...
 * @author ...
 */
class UFO extends FlxSprite
{

	public function new(?X:Float=100, ?Y:Float=100) 
	{
		super(X, Y);		
		loadGraphic(AssetPaths.navejugador__png);
		setGraphicSize(32, 32); //tamaño de la imagen
	}
	public var spawnCooldown:Float = 0;
	public var spawnTime:Float = 1;
	override public function update(elapsed:Float):Void 
	{
		
		if (!alive)
		{
			super.update(elapsed);
			spawnCooldown -= elapsed;
			if (spawnCooldown<0) {
				spawn();
				spawnCooldown = spawnTime;
			}
		}else {
			
			x -= elapsed*50;
			if (x < 0) {
				kill();				
			}
		}
		
	}
	private function spawn()
	{
		revive();		
		x = FlxG.width;
	}
}