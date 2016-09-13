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
	var enjambreWidth:Int = 8;
	var enjambreHeight:Int = 4;
	public function new() 
	{
		
		var e:Enemigo;			
		for (i in 0...enjambreHeight)
		{
			for (j in 0...enjambreWidth)
			{
				e = new Enemigo(20 + j*50, 30+ i*50);				
				enemigos.add(e);
			}
		}				
	}	
	
	
	public function add()
	{		
		FlxG.state.add(enemigos);
	}
	
	public function checkAliveColumns()
	{
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
	
	public function checkColumn(column:Int):Bool
	{
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