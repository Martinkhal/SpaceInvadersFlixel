package;

import clases.Digitalizer;
import clases.Enjambre;
import clases.Points;
import clases.ScrollingBackground;
import clases.Shield;
import clases.StageTools;
import clases.UFO;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxSoundAsset;

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
	
	var b:ScrollingBackground;
	var score:Digitalizer;
	var livesDigits:Digitalizer;
	
	override public function create():Void
	{		
		super.create();		
		StageTools.score = 0;
		//FlxG.fullscreen = !FlxG.fullscreen;
		
		
		b = new ScrollingBackground(AssetPaths.bg1__png); 
		add(b);		
		
		var scoreSign:FlxSprite = new FlxSprite(15,1,AssetPaths.ScoreSign__png);
		add(scoreSign);
		var livesSign:FlxSprite = new FlxSprite(100,1,AssetPaths.LivesSign__png);
		add(livesSign);
		
		var escudo1:Shield = new Shield(30, 104);		
		add(escudo1);
		escudos.push(escudo1);
		var escudo2:Shield = new Shield(100, 104);		
		add(escudo2);
		escudos.push(escudo2);
		
		player = new Navecita(50, 124); //posicion donde aparece NAVE del jugador
		player.enabled = false;
		add(player);		
		StageTools.player =  player;
		enjambre = new Enjambre(player,escudos);
		enjambre.add();
		
		score = new Digitalizer(37, 1,6,StageTools.score);
		livesDigits = new Digitalizer(125, 1,2,lives);
		ufo = new UFO(1,1,player);
		add(ufo);
	}	
	var waitingForRespawn:Bool = true;
	
	var lives:Int = 3;
	public function killPlayer()
	{
		player.kill();
		lives --;
		livesDigits.update(lives);
		FlxG.sound.play(AssetPaths.explode0__wav, 0.5);	
	}
	public var RespawnCooldown:Float = 0.3;
	public var RespawnTime:Float = 0.3;
	override public function update(elapsed:Float):Void
	{		
		super.update(elapsed);	
		
		if (waitingForRespawn){
			RespawnCooldown -= elapsed;
		}else{
			RespawnCooldown = RespawnTime;
		}
		if (waitingForRespawn && RespawnCooldown<= 0 && FlxG.keys.anyJustPressed([FlxKey.A,FlxKey.D,FlxKey.J]))
		{
			if (lives > 0)
			{
				player.enabled = true;
				player.revive();
				enjambre.ResetPosition();
				enjambre.active = true;
				waitingForRespawn = false;
			}else{
				if (StageTools.score > StageTools.highscore)
				{
					StageTools.highscore = StageTools.score;				
				}
				FlxG.switchState(new GameOverState());
			}	
			
		}
		
		
		if (!enjambre.Erradicated()) {			
			enjambre.Update(elapsed);	
			
			
			//Enemigos debajo del limite
			if(enjambre.AnyoneBelowFloorLevel()){
				enjambre.celebrate();	
				waitingForRespawn = true;
				killPlayer();
				enjambre.ResetPosition();
			}
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
				killPlayer();
				waitingForRespawn = true;
				enjambre.celebrate();				
			}
			
			//Balas de enemigos vs Player
			if (enjambre.CollideBulletsWithPlayer())
			{				
				enjambre.celebrate();	
				waitingForRespawn = true;
				killPlayer();
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
			if (StageTools.score > StageTools.highscore)
			{
				StageTools.highscore = StageTools.score;				
			}
			enjambre.ResetPosition(); 
			enjambre.Respawn();
			//FlxG.switchState(new GameOverState());
		}
		score.update(StageTools.score);
		
		//score.digitalize(score);
		//enemigos.colisionarConBala(player.b.getPosition());	
	}
}
