package clases;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.group.FlxGroup;

/**
 * ...
 * @author ...
 */
class Enjambre
{
	private var enemigos: FlxGroup = new FlxGroup(); 
	public function new() 
	{
		var enjambreWidth:Int = 8;
		var enjambreHeight:Int = 4;
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
}