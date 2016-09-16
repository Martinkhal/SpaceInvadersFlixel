package;

import clases.Enjambre;
import clases.UFO;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import clases.Navecita;
import clases.Enemigo;
import clases.Bala;
import flixel.util.FlxCollision;

class PlayState extends FlxState
{
	private var enjambre:Enjambre; 
	private var player:Navecita;
	private var ufo:UFO;
	
	override public function create():Void
	{
		
		super.create();

		player = new Navecita(300, 440); //posicion donde aparece NAVE del jugador
		add(player);
		enjambre = new Enjambre(player);
		enjambre.add();
		ufo = new UFO();
		add(ufo);
	}	
	
	override public function update(elapsed:Float):Void
	{
		
		super.update(elapsed);
		
		
		if (!enjambre.Erradicated()) {
			
			enjambre.Update(elapsed);			
			
			if (player.b.alive && enjambre.CollidePoint(player.b.getPosition()))
			{
				player.b.kill();
			}
			
			if (player.alive && enjambre.CollidePoint(player.getPosition()))
			{
				//player.kill();
				enjambre.ResetPosition();
			}
			if (player.alive && enjambre.CollidePoint(player.getPosition()))
			{
				//player.kill();
				enjambre.ResetPosition();
			}
			
			if (player.alive && enjambre.CollidePoint(player.getPosition()))
			{
				//player.kill();
				enjambre.ResetPosition();
			}
			if (enjambre.CollideBulletsWithPlayer())
			{
				enjambre.ResetPosition();
				player.revive();
			}
			enjambre.CollideBulletsWithPlayerBullet();
			if (FlxG.keys.pressed.F) enjambre.ResetPosition();
			
		}else{
			FlxG.switchState(new MenuState());
		}
		
		
		//enemigos.colisionarConBala(player.b.getPosition());	
	}
}
