package clases;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import clases.Bala;
/**
 * ...
 * @author ...
 */
class Enemigo extends FlxSprite
{	
	public var restFrame:Int = 0;
	var enemyType:Int;
	public function celebrate()
	{
		animation.play("celebrate1-"+Std.string(enemyType));
	}
	public function restAnimation()
	{
		animation.play("resting0-"+Std.string(enemyType));
	}
	public function new(EnemyType:Int) 
	{
		super(0, 0);	
		enemyType = EnemyType;
			
		//PARA CREAR ENEMIGO/imagen
		loadGraphic(AssetPaths.Enemy2__png, true, 12, 14); 
		
		animation.add("resting0-0", [0], 1, true);
		animation.add("resting1-0", [1], 1, true);
		animation.add("celebrate1-0", [0,1], 6, true);
		animation.add("fire-0", [2], 2, false);
		animation.add("resting0-1", [3], 1, true);
		animation.add("resting1-1", [4], 1, true);
		animation.add("celebrate1-1", [3,4], 6, true);
		animation.add("fire-1", [5], 2, false);
		animation.add("resting0-2", [6], 1, true);
		animation.add("resting1-2", [7], 1, true);
		animation.add("celebrate1-2", [6,7], 6, true);
		animation.add("fire-2", [8], 2, false);
		switchRestFrame();
		setGraphicSize(12, 14); //tamaño de la imagen		
	}

	private function switchRestFrame()
	{
		restFrame = 1 - restFrame;
		if (animation.curAnim == null || animation.curAnim.name != "fire-"+Std.string(enemyType))
		{
			animation.play("resting"+restFrame+"-"+Std.string(enemyType));
		}		
	}
	
	override public function update (elapsed:Float):Void
	{
		super.update(elapsed);	
		if (chargedShot != null && chargedShot.exists && chargedShot.waiting)
		{
			chargedShot.setPosition(x + width / 2, y + height);	
			if (Math.abs(x - StageTools.player.x) < 10)
			{
					animation.play("fire-"+Std.string(enemyType));
					animation.finishCallback = Anim;
					chargedShot.setWaiting(false);
			}	
		}
	}
	
	public function move(movement:FlxPoint)
	{
		switchRestFrame();
		x += movement.x;
		y += movement.y;
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
		StageTools.scorre += (enemyType+1)*100;
		FlxG.sound.play(AssetPaths.explode1__wav, 0.5);	
		var p:Points = new Points(x+width/2, y+height/2, (enemyType+1)*100);		
		if (chargedShot != null && chargedShot.exists && chargedShot.waiting)
		{
			chargedShot.destroy();
		}
		kill();
	}
	var chargedShot:Bala;
	public function Disparar(hold:Bool):Bala
	{		
		if (hold)
		{
			if (chargedShot != null && chargedShot.exists)
			{
				//Already on play				
			}else{	
				
				chargedShot = new Bala(x + width / 2, y + height , true, 100); 	
				FlxG.state.add(chargedShot);	
				chargedShot.setWaiting(true);				
			}
			
			return chargedShot;
		}else{
			var b:Bala = new Bala(x + width / 2, y + height , true, 100); 		
			FlxG.state.add(b);		
			animation.play("fire-"+Std.string(enemyType));
			animation.finishCallback = Anim;
			return b;
		}
		
	}
	private function Anim(name:String)
	{
		animation.play("resting"+restFrame+"-"+Std.string(enemyType));
	}
	
}