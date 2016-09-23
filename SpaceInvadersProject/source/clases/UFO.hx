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
	public function new(?X:Float=0, ?Y:Float=0, Player:Navecita) 
	{
		super(X, Y);		
		loadGraphic(AssetPaths.UFO__png, true, 19, 15);		
		animation.add("moving", [0, 1], 12,true);		
		animation.play("moving");
		
		set_visible(false);
		player = Player;
	}
	
	public var spawnCooldown:Float = 0;
	public var spawnTime:Float = 10  ;	
	override public function update(elapsed:Float):Void 
	{	
		super.update(elapsed);
		if (!visible)
		{
			
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
			if (x+width < 0) {				
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
		FlxG.sound.play(AssetPaths.yes2__wav, 0.5);	
		StageTools.scorre += 500;
		var p:Points = new Points(x+width/2, y+height/2, 500);
		spawnCooldown = spawnTime;	
		set_visible(false);			
	}
}