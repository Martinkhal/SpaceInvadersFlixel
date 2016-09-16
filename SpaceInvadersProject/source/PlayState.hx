package;

import clases.Enjambre;
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
	private var currentMovement:FlxPoint = new FlxPoint(5,0);
	private var movementH:Float = 5;
	private var movementV:Float = 10;
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if(!enemigos.Erradicated()){
			timer += elapsed;		
			if (timer >= 0.015)
			{			
				
				if (enemigos.Move(currentMovement))
				{
					
					var dir:Int = enemigos.checkWall();
					if (dir != 0)
					{
						currentMovement = new FlxPoint(movementH * dir,movementV);
					}else{
						currentMovement =  new FlxPoint(currentMovement.x,0);
					}					
				}
				enemigos.LeftMostIndex();
				
				timer = 0;
			}
			if (player.b.alive && enemigos.checkAgainstBullet(player.b.getPosition()))
			{
				player.b.kill();
			}
			
		}else{
			FlxG.switchState(new MenuState());
		}
		
		
		//enemigos.colisionarConBala(player.b.getPosition());	
	}
}
