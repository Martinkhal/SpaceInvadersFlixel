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
	public function new() 
	{
		
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
	
	//Ya no anda
	public function checkAliveColumns(){
		var s:String = "";
		for (i in 0...enjambreWidth)
		{
			if (checkColumn(i))
			{
				s += "1";
			}else{
				s += "0";
			}
		}
		trace(s);
	}
	//Ya no anda
	public function checkColumn(column:Int):Bool{
		for (i in 0...enjambreHeight)
		{
			if (enemigos.members[i * enjambreWidth + column].alive)
			{
				return true;
			}
		}
		return false;
	}
	
	public function checkAgainstBullet(point:FlxPoint):Bool
	{
		for (i in 0...enjambreHeight*enjambreWidth)
		{
			if (cast(enemigos.members[i], Enemigo).checkAgainstBullet(point))
			{
				return true;
			}
		}
		return false;
	}
}