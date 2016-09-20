package;

import clases.Digitalizer;
import clases.Enjambre;
import clases.ScrollingBackground;
import clases.Shield;
import clases.UFO;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxPoint;
import flixel.system.scaleModes.PixelPerfectScaleMode;
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
	private var escudos:Array<Shield> = [];
	
	var background:FlxSprite = new FlxSprite();
	var background2:FlxSprite = new FlxSprite();
	var b:ScrollingBackground;
	var score:Digitalizer;
	override public function create():Void
	{		
		super.create();
		//FlxG.fullscreen = !FlxG.fullscreen;
		FlxG.resizeWindow(FlxG.initialWidth * 3, FlxG.initialHeight * 3);

		FlxG.scaleMode = new PixelPerfectScaleMode();
		b = new ScrollingBackground(AssetPaths.bg1__png); 
		add(b);
		//background.loadGraphic(AssetPaths.bg1__png); 
		//background2.loadGraphic(AssetPaths.bg1__png); 
		//background.makeGraphic(FlxG.width, FlxG.height, 0xFF081214);
		//add(background);
		//add(background2);
		
		var escudo1:Shield = new Shield(30, 104);		
		add(escudo1);
		escudos.push(escudo1);
		var escudo2:Shield = new Shield(100, 104);		
		add(escudo2);
		escudos.push(escudo2);
		
		player = new Navecita(50, 124); //posicion donde aparece NAVE del jugador
		add(player);		
		FlxG.player = player;
		
		enjambre = new Enjambre(player,escudos);
		enjambre.add();
		
		score = new Digitalizer(10, 2,FlxG.score);
		
		ufo = new UFO(player);
		add(ufo);
	}	
	var waitingForRespawn:Bool = true;
	
	
	override public function update(elapsed:Float):Void
	{		
		super.update(elapsed);	
		if (waitingForRespawn && FlxG.keys.anyJustPressed([FlxKey.A,FlxKey.D,FlxKey.J]))
		{
			player.revive();
			enjambre.ResetPosition();
			enjambre.active = true;
			waitingForRespawn = false;
		}
		
		
		if (!enjambre.Erradicated()) {
			
			enjambre.Update(elapsed);	
			
			//Balas de enemigos vs Escudo
			enjambre.CollideBulletsWithShield();
			
			//Bala de player vs Enemigos
			if (player.b.alive && enjambre.CollidePoint(player.b.getCorrectedPosition()))
			{
				player.b.kill();
			}
			
			//Player vs Enemigos
			if (player.alive && enjambre.CollidePoint(player.getPosition()))
			{
				player.kill();
				waitingForRespawn = true;
				enjambre.celebrate();				
			}
			
			//Balas de enemigos vs Player
			if (enjambre.CollideBulletsWithPlayer())
			{				
				enjambre.celebrate();	
				waitingForRespawn = true;
				player.kill();
			}
			
			//Balas de enemigos vs Bala de player
			enjambre.CollideBulletsWithPlayerBullet();
			
			
			
			//Bala de player vs Escudo
			for (i in 0...escudos.length){
				if (player.b.alive && escudos[i].CollidePoints(player.b.pointsDuringFrame()))
				{
					player.b.kill();
				}
			}			
			
			if (FlxG.keys.pressed.F) enjambre.ResetPosition();
			if (FlxG.keys.pressed.G) {
				for (i in 0...escudos.length){
					escudos[i].kill(); 
					escudos[i].revive(); 
					escudos[i].ResetGraphic(); 	
				}
			}
		}else{
			FlxG.switchState(new MenuState());
		}
		score.update(FlxG.score);
		
		//score.digitalize(score);
		//enemigos.colisionarConBala(player.b.getPosition());	
	}
}
