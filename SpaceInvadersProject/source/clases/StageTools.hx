package clases;
import flixel.FlxObject;
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
	public static var gameScale:Int = 1;
	public static var player:FlxObject;
	public static var scorre:Int = 0;
	public static var Highscorre:Int = 0;
	public static var newHighScore:Bool = false;
}