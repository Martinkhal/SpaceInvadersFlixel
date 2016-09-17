package;

import clases.Enjambre;
import clases.Shield;
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
	private var escudo:Shield;
	override public function create():Void
	{		
		super.create();
		
	
		
		escudo = new Shield(300, 400);
		add(escudo);
		player = new Navecita(300, 440); //posicion donde aparece NAVE del jugador
		add(player);		
		ufo = new UFO(player);
		add(ufo);
		
		enjambre = new Enjambre(player,escudo);
		enjambre.add();
	}	
	
	override public function update(elapsed:Float):Void
	{
		
		super.update(elapsed);
		
		
		if (!enjambre.Erradicated()) {
			
			enjambre.Update(elapsed);	
			
			//Bala de player vs Enemigos
			if (player.b.alive && enjambre.CollidePoint(player.b.getPosition()))
			{
				player.b.kill();
			}
			
			//Player vs Enemigos
			if (player.alive && enjambre.CollidePoint(player.getPosition()))
			{
				//player.kill();
				enjambre.ResetPosition();
			}
			
			//Balas de enemigos vs Player
			if (enjambre.CollideBulletsWithPlayer())
			{
				enjambre.ResetPosition();
				player.revive();
			}
			
			//Balas de enemigos vs Bala de player
			enjambre.CollideBulletsWithPlayerBullet();
			
			//Balas de enemigos vs Escudo
			enjambre.CollideBulletsWithShield();
			
			//Bala de player vs Escudo
			if (player.b.alive && escudo.CollidePoints(player.b.pointsDuringFrame()))
			{
				player.b.kill();
			}
			
			if (FlxG.keys.pressed.F) enjambre.ResetPosition();
			
		}else{
			FlxG.switchState(new MenuState());
		}
		
		
		//enemigos.colisionarConBala(player.b.getPosition());	
	}
}
