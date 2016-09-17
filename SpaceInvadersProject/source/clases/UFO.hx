package clases;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
/**
 * ...
 * @author ...
 */
class UFO extends FlxSprite
{
	public var player:Navecita;
	public function new(?X:Float=100, ?Y:Float=10, Player:Navecita) 
	{
		super(X, Y);		
		loadGraphic(AssetPaths.navejugador__png);
		setGraphicSize(32, 32);
		set_visible(false);
		player = Player;
	}
	
	public var spawnCooldown:Float = 0;
	public var spawnTime:Float = 10  ;
	override public function update(elapsed:Float):Void 
	{	
		if (!visible)
		{
			trace("UFO:"+spawnCooldown);
			super.update(elapsed);
			spawnCooldown -= elapsed;
			if (spawnCooldown<0) {
				spawn();
				spawnCooldown = spawnTime;				
			}
		}else {		
			
			if (player.b.alive){
				if (CollidePoint(player.b.getPosition()))
				{
					player.b.kill();
				}
			}			
			x -= elapsed*50;
			if (x < 0) {
				trace("UFO DOWN");
				set_visible(false);			
			}			
		}		
	}
	
	private function spawn()
	{
		set_visible(true);			
		x = FlxG.width;
	}
	
	public function CollidePoint(point:FlxPoint):Bool
	{
		if (!alive)
		{
			return false;
		}
		if (overlapsPoint(point))
		{			
			die();
			return true;
		}else{
			return false;
		}
	}
	public function die()
	{
		spawnCooldown = spawnTime;	
		set_visible(false);			
	}
}