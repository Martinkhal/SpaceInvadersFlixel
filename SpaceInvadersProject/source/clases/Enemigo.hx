package clases;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import clases.Bala;
/**
 * ...
 * @author ...
 */
class Enemigo extends FlxSprite
{	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);		
		//PARA CREAR ENEMIGO/imagen
		loadGraphic(AssetPaths.enemigo1__png); //para cargar la direccion de una imagen y usarla
		//makeGraphic(64, 64, 0xFFFFFF00);
		setGraphicSize(30, 30); //tamaño de la imagen
		
	}
	
	override public function update (elapsed:Float):Void
	{
		super.update(elapsed);	
	}
	
	public function move(movement:FlxPoint)
	{
		x += movement.x;
		y += movement.y;
	}
	public function checkAgainstBullet(point:FlxPoint):Bool
	{
		if (!alive)
		{
			return false;
		}
		if (overlapsPoint(point))
		{
			kill();
			return true;
		}else{
			return false;
		}
	}
}