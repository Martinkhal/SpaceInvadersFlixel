package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import sprites.Player;
import sprites.Enemigo;
import sprites.Balas;

class PlayState extends FlxState
{
	private var enemigo: Enemigo; 
	private var player:Player;
	private var timer:Float = 0;
	private var balas: Balas;
	
	override public function create():Void
	{
		super.create();
		
		enemigo = new Enemigo(300, 30); //posicion donde aparece ENEMIGO
		enemigo.velocity.x = 100;
		enemigo.velocity.x -= 100;
		
		player = new Player(300, 440); //posicion donde aparece NAVE del jugador
		
		add(player);
		add(enemigo);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		timer += elapsed;
		
		if (timer >= 3)
		{
			trace("hola");
			timer = 0;
		}
		
		
		if (FlxG.collide(enemigo, balas))
		FlxG.switchState(new PlayState());
		
		
		
	}
}
