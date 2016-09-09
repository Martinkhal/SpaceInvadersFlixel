package clases;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import clases.Bala;
/**
 * ...
 * @author ...
 */
class Enemigo extends FlxSprite
{	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		//PARA CREAR ENEMIGO/imagen
		loadGraphic(AssetPaths.enemigo1__png); //para cargar la direccion de una imagen y usarla
		//makeGraphic(64, 64, 0xFFFFFF00);
		setGraphicSize(30, 30); //tamaño de la imagen
		
	}
	
	override public function update (elapsed:Float):Void
	{
		super.update(elapsed);	
	}
	
	public function move(movement:Float)
	{
		x += movement;
	}
}