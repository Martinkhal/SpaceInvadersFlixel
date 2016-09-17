package clases;

import flixel.FlxSprite;
import flixel.animation.FlxAnimation;
import flixel.input.FlxAccelerometer;
import flixel.math.FlxRect;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.animation.FlxAnimation;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
/**
 * ...
 * @author ...
 */
class Bala extends FlxSprite
{
	private var selfDestroy:Bool;
	private var vy:Float;
	private var prevPositionY:Float;
	public function new(?X:Float=0, ?Y:Float=0,?SelfDestroy:Bool=false, ?Velocity:Int=-500) 
	{
		super(X, Y);
		
		makeGraphic (4, 8);
		color = FlxColor.WHITE;
		vy = Velocity;
		prevPositionY = y;
		//graphic.bitmap.setPixel(0, 0, 0);
		selfDestroy = SelfDestroy;
	}
	override public function reset(X:Float, Y:Float):Void 
	{
		super.reset(X, Y);
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		prevPositionY = y;
		y += vy*elapsed;
		if (StageTools.FueraDePantalla(getPosition()))
		{
			explode();
		}		
	}
	public function pointsDuringFrame():Array<FlxPoint>
	{
		var points:Array<FlxPoint> = [];
		var from:Int = Math.floor(prevPositionY);
		var to:Int = Math.floor(y);
		if (from != to)
		{
			if (to < from){
				from = to;
				to = Math.floor(prevPositionY);
			}
			for (i in from...to)
			{
				points.push(new FlxPoint(x,i));
			}
		}else{
			points.push(getPosition());			
		}
		return(points);
	}
	
	public function explode()
	{
		if (selfDestroy) {
				trace("BOOM");
				destroy();
			}else {
				trace("ded x.X");
				kill();
			}
	}
	public function CollidePoint(point:FlxPoint):Bool
	{
		if (!alive)
		{
			return false;
		}
		
		if (overlapsPointExpanded(point))
		{
			explode();
			return true;
		}else{
			return false;
		}
	}
	public function overlapsPointExpanded(point:FlxPoint):Bool
	{		
		if (point.x > x - 10 && point.x < x + 10 && point.y < y + 10 && point.y > y - 10) 
		{
			return true;
		}
		return false;
	}
}