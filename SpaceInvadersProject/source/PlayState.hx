package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import clases.Navecita;
import clases.Enemigo;
import clases.Bala;
import flixel.util.FlxCollision;

class PlayState extends FlxState
{
	private var enemigo: Enemigo; 
	private var player:Navecita;
	private var timer:Float = 0;
	
	override public function create():Void
	{
		super.create();
		
		enemigo = new Enemigo(300, 30); //posicion donde aparece ENEMIGO
		enemigo.velocity.x = 100;
		enemigo.velocity.x -= 100;
		
		player = new Navecita(300, 440); //posicion donde aparece NAVE del jugador
		
		add(player);
		add(enemigo);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		timer += elapsed;
		
		if (timer >= 1)
		{
			enemigo.move(10);
			timer = 0;
		}
		
		if (enemigo.overlapsPoint(player.b.getPosition()))
		{
			trace("AAAAAAAAAAAAAAAAAAAAAA");
		}		
	}
}
