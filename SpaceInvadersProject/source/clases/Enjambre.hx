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
	var enjambreHeight:Int = 4;
	
	public var currentMovingEnemy:Int;
	
	public function new() 
	{
		
		var e:Enemigo;			
		for (i in 0...enjambreWidth)
		{
			for (j in 0...enjambreHeight)
			{
				e = new Enemigo(20 + i*50, 30+ j*50);				
				enemigos.add(e);
			}
		}	
		currentMovingEnemy = enjambreHeight * enjambreWidth - 1;
		trace(cast(enemigos.members[currentMovingEnemy-1], Enemigo).alive);
	}	
	
	public function Move(movement:FlxPoint)
	{
		/*
		for (i in 0...enjambreWidth*enjambreHeight)
		{
			if (enemigos.members[i].alive)
			{
				cast(enemigos.members[i], Enemigo).move(movement);				
			}
		}
		*/		
		cast(enemigos.members[currentMovingEnemy], Enemigo).move(movement);
		currentMovingEnemy --;
		if (currentMovingEnemy < 0)
		{
			currentMovingEnemy = enjambreHeight * enjambreWidth - 1;
		}
	}
	
	public function add()
	{		
		FlxG.state.add(enemigos);
	}
	public function checkRightMost()
	{
		var rightMost:Int = 0;
		for (i in 0...enjambreWidth*enjambreHeight)
		{
			if (enemigos.members[i].alive)
			{
				rightMost = i;				
			}
		}
		trace(rightMost);
	}
	
	public function checkLeftMost()
	{
		var leftMost:Int = 0;
		for (i in 0...enjambreWidth*enjambreHeight)
		{
			if (enemigos.members[i].alive)
			{
				leftMost = i;
				break;
			}
		}
		trace(leftMost);
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