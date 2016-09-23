package clases;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class Navecita extends FlxSprite
{

	public var b:Bala = new Bala(); 
	public var enabled:Bool = true;
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		
		super(X, Y);		
		loadGraphic(AssetPaths.player1__png);
		setGraphicSize(15, 14);
		b.kill();
	}
	
	override public function update (elapsed:Float):Void
	{
		super.update(elapsed);		
		if(enabled){
			Movimiento(elapsed);		
			if (FlxG.keys.justPressed.J)
			{
				Disparar();
			}
		}
	}
	public function Movimiento(elapsed:Float)
	{
		if (FlxG.keys.pressed.D)
		x += 90*elapsed;
		
		if (FlxG.keys.pressed.A)
		x -= 90*elapsed;
		
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
			FlxG.sound.play(AssetPaths.shoot0__wav, 0.5);	
			b.reset(x + width / 2-b.width/2, y + height / 16);
			FlxG.state.add(b);		
		}
	}
	
	public function CollidePoint(point:FlxPoint):Bool
	{
		if (!alive)
		{
			return false;
		}
		if (overlapsPoint(point))
		{
			kill();
			//die();
			return true;
		}else{
			return false;
		}
	}
	override public function kill():Void 
	{
		super.kill();
		var e:Points = new Points(x+width/2, y+height/2, true);	
		enabled = false;
	}
}