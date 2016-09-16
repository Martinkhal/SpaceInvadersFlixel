package clases;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class Navecita extends FlxSprite
{

	public var b:Bala = new Bala(); 
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);		
		loadGraphic(AssetPaths.navejugador__png);
		setGraphicSize(32, 32);
		b.kill();
	}
	
	override public function update (elapsed:Float):Void
	{
		super.update(elapsed);		
		
		Movimiento();		
		if (FlxG.keys.justPressed.J)
		{
			Disparar();
		}
	}
	public function Movimiento()
	{
		if (FlxG.keys.pressed.D)
		x += 3;
		
		if (FlxG.keys.pressed.A)
		x -= 3;
		
		RestringirMovimiento();		
	}
	//PARA QUE PLAYER NO SE MUEVA MAS ALLA DE LA PANTALLA
	public function RestringirMovimiento()
	{
		
		
		if(x > FlxG.width - width)	 
			x = FlxG.width - width; 
			
		if(x < 0)
			x = 0;
	}
	
	public function Disparar()
	{
		if (!b.alive)
		{			
			b.reset(x + width / 2, y + height / 16);
			FlxG.state.add(b);		
		}
	}
}