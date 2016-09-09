package;

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
	private var enemigos: FlxGroup = new FlxGroup(); 
	private var player:Navecita;
	private var timer:Float = 0;

	override public function create():Void
	{
		super.create();

		player = new Navecita(300, 440); //posicion donde aparece NAVE del jugador
		add(player);
		var e:Enemigo;
		for (i in 0...5)
		{
			e = new Enemigo(20 + i*50, 30);
			
			enemigos.add(e);
		}		
		add(enemigos);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		timer += elapsed;
		
		if (timer >= 1)
		{
			//enemigo.move(10);
			timer = 0;
		}
		
		//enemigos.colisionarConBala(player.b.getPosition());	
	}
}
