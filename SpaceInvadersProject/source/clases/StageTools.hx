package clases;
import flixel.math.FlxPoint;
import flixel.FlxG;
/**
 * ...
 * @author ...
 */
class StageTools
{
	public static function FueraDePantalla(posicion:FlxPoint):Bool
	{
		if (posicion.x < 0 || posicion.x > FlxG.width || posicion.y > FlxG.height || posicion.y < 0)
	    {
			return true;
		}
		return false;		
	}
	
}