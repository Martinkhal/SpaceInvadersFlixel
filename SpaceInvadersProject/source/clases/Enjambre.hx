package clases;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;

/**
 * ...
 * @author ...
 */
class Enjambre
{
	private var enemigos: FlxGroup = new FlxGroup(); 
	var enjambreWidth:Int = 11;
	var enjambreHeight:Int = 6;
	
	public var currentMovingEnemy:Int;
	
	public var stageLeft:Float = 80;
	public var stageRight:Float = 550;
	
	private var player:Navecita;
	private var escudo:Shield;
	public function new(Player:Navecita,Escudo:Shield) 
	{		
		player = Player;
		escudo = Escudo;
		var e:Enemigo;			
		for (i in 0...enjambreWidth)
		{
			for (j in 0...enjambreHeight)
			{
				e = new Enemigo(80 + i*40, 30+ j*35);				
				enemigos.add(e);
			}
		}	
		currentMovingEnemy = 1;
		//trace(cast(enemigos.members[currentMovingEnemy-1], Enemigo).alive);
	}	
	public function Erradicated():Bool
	{
		return (enemigos.countLiving() == 0);
	}
	public function Move(movement:FlxPoint):Bool
	{
		var endOfCicle:Bool = false;	
		if (enemigos.length>0)
		{			
			while (!cast(enemigos.members[FromBottomLeft(currentMovingEnemy)], Enemigo).alive)
			{
				endOfCicle = nextIndex(currentMovingEnemy) || endOfCicle;
			}
			
			cast(enemigos.members[FromBottomLeft(currentMovingEnemy)], Enemigo).move(movement);
			endOfCicle = nextIndex(currentMovingEnemy) || endOfCicle;
		}
		return endOfCicle;
	}
	public function nextIndex(index:Int):Bool{
		var endOfCicle:Bool = false;	
		currentMovingEnemy++;
		if (currentMovingEnemy > enjambreHeight * enjambreWidth)
		{
			endOfCicle = true;
			currentMovingEnemy = 1;
		}
		if (currentMovingEnemy < 1){
			endOfCicle = true;
			currentMovingEnemy = 1;
		}
		return endOfCicle;
	}
	
	public function FromBottomLeft(index:Int):Int
	{		
		var x:Int = ((index-1) % enjambreWidth) +1;
		var y:Int = Math.ceil(index / enjambreWidth);
		
		//trace("Index:" + index + ", x:" + x + ", y:" + y + ", Value:" + ((x * enjambreHeight) - y));
		return ((x * enjambreHeight) - y);
	}
	
	public function add()
	{		
		FlxG.state.add(enemigos);
	}
	
	public function checkWall():Int
	{
		var rightMost:Int = RightMostIndex();
		var leftMost:Int = LeftMostIndex();
		trace("Right: " +(cast(enemigos.members[rightMost], Enemigo).getPosition()));
		trace("Left: " +(cast(enemigos.members[leftMost], Enemigo).getPosition()));
		if ((cast(enemigos.members[rightMost], Enemigo).getPosition().x) > stageRight)
		{
			return -1;
		}
	
		if ((cast(enemigos.members[leftMost], Enemigo).getPosition().x) < stageLeft)
		{
			return 1;
		}
		return 0;
	}
	
	public function RightMostIndex():Int
	{
		var rightMost:Int = 0;
		for (i in 0...enjambreWidth*enjambreHeight)
		{
			if (enemigos.members[i].alive)
			{
				rightMost = i;				
			}
		}
		return rightMost;
	}
	
	public function LeftMostIndex():Int
	{
		for (i in 0...enjambreWidth*enjambreHeight)
		{
			if (enemigos.members[i].alive)
			{
				return i;
			}
		}
		return 0;
	}	

	
	public function CollidePoint(point:FlxPoint):Bool
	{
		for (i in 0...enjambreHeight*enjambreWidth)
		{
			if (cast(enemigos.members[i], Enemigo).CollidePoint(point))
			{
				return true;
			}
		}
		return false;
	}
	
	public function ResetPosition()
	{
		var index:Int = 0;			
		for (i in 0...enjambreWidth)
		{
			for (j in 0...enjambreHeight)
			{
				(cast(enemigos.members[index], Enemigo)).setPosition(80 + i * 40, 30 + j * 35);
				index++;
			}
		}
		currentMovingEnemy = 1;
		deleteAllBullets();
	}
	
	public function AliveArray():Array<Enemigo>
	{
		var a:Array<Enemigo> = [];
		
		for(i in 0...enemigos.length) 
		{
			if (enemigos.members[i].alive) {
					a.push(cast(enemigos.members[i], Enemigo));
			}
		}
		return a;
	}
	
	private var BalasEnemigas:Array<Bala> = [];
	
	public function fire()
	{
		BalasEnemigas.push(fireRandom());		
		var i:Int = BalasEnemigas.length-1;
		while (i >= 0) {
			if (!BalasEnemigas[i].exists)
			{
				BalasEnemigas.splice(i, 1);
				trace("Removed: "+i);
			}
			i--;
		}
		trace(BalasEnemigas.length);		
	}

	public function deleteAllBullets()
	{		
		var l:Int = BalasEnemigas.length;
		for (i in 0...l) {
			if (BalasEnemigas[i].exists)
			{
				BalasEnemigas[i].destroy();
			}
		}
		BalasEnemigas = [];
	}
	public function fireRandom():Bala
	{			
		var a:Array<Enemigo> = AliveArray();
		return (cast(a[Math.floor(Math.random() * (enemigos.countLiving()))], Enemigo)).Disparar();		
	}
	
	private var currentMovement:FlxPoint = new FlxPoint(15,0);
	private var movementH:Float = 15;
	private var movementV:Float = 30;
	
	public function StartMove() {
		if (Move(currentMovement))
		{			
			var dir:Int = checkWall();
			if (dir != 0)
			{
				currentMovement = new FlxPoint(movementH * dir,movementV);
			}else{
				currentMovement =  new FlxPoint(currentMovement.x,0);
			}					
		}
	}
	private var MoveTimer:Float = 0;
	private var FireTimer:Float = 0;
	public function Update(elapsed:Float) {
		MoveTimer += elapsed;		
		if (MoveTimer >= 0.05)
		{
			StartMove();				
			MoveTimer = 0;
		}
		FireTimer -= elapsed;		
		if (FireTimer <= 0)
		{							
			fire();			
			FireTimer = 0.4 + Math.random() * 0.5;
		}
		//CollideBulletsWithPlayer();
	}
	public function CollideBulletsWithPlayer():Bool {
		var i:Int = BalasEnemigas.length-1;
		while (i >= 0) {
			if (BalasEnemigas[i].exists)
			{
				if (player.CollidePoint(BalasEnemigas[i].getPosition()))
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
					if (BalasEnemigas[i].CollidePoint(player.b.getPosition()))
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
				if (escudo.CollidePoints(BalasEnemigas[i].pointsDuringFrame()))
				{
					BalasEnemigas[i].explode();
					return true;
				}
			}
			i--;
		}
		return false;
	}
}