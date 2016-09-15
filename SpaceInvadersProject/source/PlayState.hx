package;

import clases.Enjambre;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import clases.Navecita;
import clases.Enemigo;
import clases.Bala;
import flixel.util.FlxCollision;

class PlayState extends FlxState
{
	private var enemigos:Enjambre; 
	private var player:Navecita;
	private var timer:Float = 0;

	override public function create():Void
	{
		super.create();

		player = new Navecita(300, 440); //posicion donde aparece NAVE del jugador
		add(player);
		enemigos = new Enjambre();
		enemigos.add();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		timer += elapsed;
		
		if (timer >= 1)
		{
			//enemigo.move(10);
			//enemigos.checkAliveColumns();
			enemigos.checkLeftMost();
			timer = 0;
		}
		if (enemigos.checkAgainstBullet(player.b.getPosition()))
		{
			player.b.kill();
		}
		
		//enemigos.colisionarConBala(player.b.getPosition());	
	}
}
