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
	var enjambreWidth:Int = 7;
	var enjambreHeight:Int = 4;
	
	public var currentMovingEnemy:Int;
	
	public var stageLeft:Float = 8;
	public var stageRight:Float = 140;
	public var active = false;
	private var player:Navecita;
	private var escudo:Array<Shield> = [];
	public function new(Player:Navecita,Escudos:Array<Shield>) 
	{		
		player = Player;
		escudo = Escudos;
		var e:Enemigo;			
		for (i in 0...enjambreWidth)
		{
			for (j in 0...enjambreHeight)
			{
				var enemyType:Int = 2;
				if (j > 0)
				{
					enemyType = 1;
				}
				if (j > 1)
				{
					enemyType = 0;
				}
				e = new Enemigo(enemyType);				
				
				enemigos.add(e);
			}
		}	
		ResetPosition();
		currentMovingEnemy = 1;
		//trace(cast(enemigos.members[currentMovingEnemy-1], Enemigo).alive);
	}	
	public function Erradicated():Bool
	{
		return (enemigos.countLiving() == 0);
	}
	
	public function celebrate()
	{
		for (i in 0...enjambreWidth*enjambreHeight)
		{
			cast(enemigos.members[i], Enemigo).celebrate();
			active = false;
		}		
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
				(cast(enemigos.members[index], Enemigo)).restAnimation();	
				(cast(enemigos.members[index], Enemigo)).restFrame = 0;
				(cast(enemigos.members[index], Enemigo)).setPosition(stageLeft + i*15, 20+ j*15);	
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
				//trace("Removed: "+i);
			}
			i--;
		}
		//trace(BalasEnemigas.length);		
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
		var alive:Array<Enemigo> = AliveArray();
		var chosenToShoot:Int = Math.floor(Math.random() * (enemigos.countLiving()));		
		var bullet:Bala = cast(alive[chosenToShoot], Enemigo).Disparar(Math.random()>0.4);
		return (bullet);
		
	}
	
	private var currentMovement:FlxPoint = new FlxPoint(8,0);
	private var movementH:Float = 8;
	private var movementV:Float = 5;	
	public function StartMove() {
		var completedCycle:Bool = Move(currentMovement);
		if (completedCycle)
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
	
	private var MoveTimer:Float = 0;
	private var FireTimer:Float = 0;
	public function Update(elapsed:Float) {
		if (active)
		{
			MoveTimer += elapsed;		
			if (MoveTimer >= 0.1)
			{
				StartMove();				
				MoveTimer = 0;
			}
			FireTimer -= elapsed;		
			if (FireTimer <= 0)
			{							
				fire();			
				FireTimer = 0.8 + Math.random() * 0.8;
			}
		}		
		//CollideBulletsWithPlayer();
	}
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
}