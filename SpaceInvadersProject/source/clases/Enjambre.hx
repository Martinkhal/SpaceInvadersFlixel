package clases;
import flash.display.InteractiveObject;
import flash.geom.Point;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.system.debug.completion.CompletionList;

/**
 * ...
 * @author ...
 */
class Enjambre
{
	private var enemigos: FlxGroup = new FlxGroup(); 
	var enjambreWidth:Int = 7;
	var enjambreHeight:Int = 4;
	
	
	public var stageLeft:Float = 8;
	public var stageRight:Float = 140;
	public var active = false;
	private var player:Navecita;
	private var escudo:Array<Shield> = [];
	public var percentComplete:Float = 0;
	
	public function new(Player:Navecita,Escudos:Array<Shield>) 
	{		
		FlxG.watch.add(this, "timeCompleted");
		FlxG.watch.add(this, "timeToComplete");
		player = Player;
		escudo = Escudos;
		CreateEnemies();
		ResetPosition();
	}
	
	public function Update(elapsed:Float) {
		timeToComplete = 0.05 * enemigos.countLiving();
		timeCompleted += elapsed;
		
		if (Erradicated())
		{
			
		}else{
			if (active)
			{
				handleMovement(elapsed);
				handleShooting(elapsed);
			}		
		}		
	}
	
	//Intialization
	public function CreateEnemies()
	{
		var e:Enemigo;			
		for (i in 0...enjambreHeight)
		{
			for (j in 0...enjambreWidth)
			{
				var enemyType:Int = 0;
				if (i > 1)
				{
					enemyType = 1;
				}
				if (i > 2)
				{
					enemyType = 2;
				}
				e = new Enemigo(enemyType);				
				
				enemigos.add(e);
			}
		}	
	}
	public function add()
	{		
		FlxG.state.add(enemigos);
	}	
	public function ResetPosition()
	{
		var index:Int = 0;			
		for (i in 0...enjambreHeight)
		{
			for (j in 0...enjambreWidth)
			{
				(cast(enemigos.members[index], Enemigo)).restAnimation();	
				(cast(enemigos.members[index], Enemigo)).restFrame = 0;
				(cast(enemigos.members[index], Enemigo)).setPosition(stageLeft+20 + j * 15, 60 - i*15);	
				index++;
			}
		}
		EnemyMovementIndex = 0;
		deleteAllBullets();
	}
	
	
	
	
	public function celebrate(){
		for (i in 0...enjambreWidth*enjambreHeight)
		{
			cast(enemigos.members[i], Enemigo).celebrate();
			active = false;
		}		
	}

	
	
	
	//Movement	
	var EnemyMovementIndex:Int = 0;
	var EnemyMovementDir:Int = 1;
	var EnemyMovementH:Int = 8;
	var EnemyMovementV:FlxPoint = new FlxPoint(8,0);
	
	
	
	
	
	//Bullets
	
	private var BalasEnemigas:Array<Bala> = [];
	public function fire(){
		BalasEnemigas.push(fireRandom());		
		var i:Int = BalasEnemigas.length-1;
		while (i >= 0) {
			if (!BalasEnemigas[i].exists)
			{
				BalasEnemigas.splice(i, 1);
				//trace("Removed: "+i);
			}
			i--;
		}
		//trace(BalasEnemigas.length);		
	}
	public function deleteAllBullets(){		
		var l:Int = BalasEnemigas.length;
		for (i in 0...l) {
			if (BalasEnemigas[i].exists)
			{
				BalasEnemigas[i].destroy();
			}
		}
		BalasEnemigas = [];
	}
	public function fireRandom():Bala{			
		var alive:Array<Enemigo> = AliveArray();
		var chosenToShoot:Int = Math.floor(Math.random() * (enemigos.countLiving()));		
		var bullet:Bala = cast(alive[chosenToShoot], Enemigo).Disparar(Math.random()>0.4);
		return (bullet);		
	}
	
	//Enjambre's members sorting functions
	public function Erradicated():Bool{
		return (enemigos.countLiving() == 0);
	}
	public function IndexOf(index:Int):Enemigo{
		return((cast(enemigos.members[index], Enemigo)));
	}
	public function AliveArray():Array<Enemigo>{
		var a:Array<Enemigo> = [];
		
		for(i in 0...enemigos.length) 
		{
			if (enemigos.members[i].alive) {
					a.push(cast(enemigos.members[i], Enemigo));
			}
		}
		return a;
	}
	public function RightMostIndex():Float{
		var c:Int = enjambreWidth-1;
		while (c >= 0)
		{
			for (r in 0...enjambreHeight)
			{
				if (IndexOf(r*enjambreWidth+c).alive)
				{
					return IndexOf(r*enjambreWidth+c).x;				
				}
			}
			c--;
		}
		return 0;
	}
	public function LeftMostIndex():Float{		
		var c:Int = enjambreWidth - 1;
		for (c in 0...enjambreWidth)
		{	
			var r:Int = 0;
			for (r in 0...enjambreHeight)
			{
				if (IndexOf(r*enjambreWidth+c).alive)
				{
					return IndexOf(r*enjambreWidth+c).x;				
				}
			}
		}	
		return 0;
	}	
	public function isColumnAlive(index:Int):Bool{
		for (i in 0...enjambreHeight)
		{
			if (IndexOf(i*enjambreWidth+index).alive)
			{
				return true;				
			}
		}
		return false;
	}
	
	
	var moveTime:Float = 0.05;
	var shootTime:Float = 0.8;
	var shotTimeRandom:Float = 0.8;

	private var MoveTimer:Float = 0;
	private var FireTimer:Float = 0;
	
	var timeToComplete:Float = 0;
	var timeCompleted:Float = 0;
		
	
	public function handleMovement(elapsed:Float){
		MoveTimer += elapsed;		
		if (MoveTimer >= moveTime)
		{
			Move();			
			MoveTimer = 0;
		}
	}
	public function handleShooting(elapsed:Float){
		FireTimer -= elapsed;		
				if (FireTimer <= 0)
				{							
					fire();			
					FireTimer = shootTime + Math.random() * shotTimeRandom - shotTimeRandom / 2;
				}
	}
	
	public var music:EnjambreMusic = new EnjambreMusic();
	
	public function Move(){
		while (EnemyMovementIndex < (enjambreHeight * enjambreWidth)-1 && !IndexOf(EnemyMovementIndex).alive)
		{
			EnemyMovementIndex++;
		}
		IndexOf(EnemyMovementIndex).move(EnemyMovementV);
		
		EnemyMovementIndex++;
		
		while (EnemyMovementIndex < enjambreHeight * enjambreWidth && !IndexOf(EnemyMovementIndex).alive)
		{
			EnemyMovementIndex++;
		}	
		
		if (EnemyMovementIndex >= enjambreHeight * enjambreWidth)
		{
			music.play();
			music.setTimeUnit(timeToComplete);
			timeCompleted = 0;
			EnemyMovementIndex = 0;
			var wall:Int = checkWall();
			if (wall != 0){
				EnemyMovementV.x = EnemyMovementH * wall;
				EnemyMovementV.y = 5;
			}else{
				EnemyMovementV.y = 0;
			}
		}
	}
	
	//Collision
	public function CollideBulletsWithPlayer():Bool {
		var i:Int = BalasEnemigas.length-1;
		while (i >= 0) {
			if (BalasEnemigas[i].exists)
			{
				if (player.CollidePoint(BalasEnemigas[i].getCorrectedPosition()))
				{
					return true;
				}
			}
			i--;
		}
		return false;
	}
	public function CollideBulletsWithPlayerBullet():Bool {		
		if (player.b.alive){
			var i:Int = BalasEnemigas.length - 1;
			while (i >= 0) {
				if (BalasEnemigas[i].exists)
				{				
					if (BalasEnemigas[i].CollidePoint(player.b.getCorrectedPosition()))
					{						
						player.b.explode();
						return true;
					}
				}
				i--;
			}	
		}		
		return false;
	}
	public function CollideBulletsWithShield():Bool {
		var i:Int = BalasEnemigas.length-1;
		while (i >= 0) {
			if (BalasEnemigas[i].exists)
			{
				for (j in 0...escudo.length)
				{
					if (escudo[j].CollidePoints(BalasEnemigas[i].pointsDuringFrame()))
					{
						BalasEnemigas[i].explode();
						return true;
					}
				}
			}
			i--;
		}
		return false;
	}
	public function CollidePoint(point:FlxPoint):Bool{
		for (i in 0...enjambreHeight*enjambreWidth)
		{
			if (cast(enemigos.members[i], Enemigo).CollidePoint(point))
			{
				return true;
			}
		}
		return false;
	}
	public function checkWall():Int{	
		if (RightMostIndex() > stageRight)
		{
			return -1;
		}
		if (LeftMostIndex() < stageLeft)
		{
			return 1;
		}
		return 0;
	}
}