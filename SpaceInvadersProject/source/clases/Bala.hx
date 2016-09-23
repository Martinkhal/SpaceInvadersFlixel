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
	public var waiting(default, null):Bool = false;
	private var selfDestroy:Bool;
	private var vy:Float;
	private var prevPositionY:Float;
	
	
	public function setWaiting(value:Bool){
		waiting = value;
		visible = !value;
	}
	
	public function new(?X:Float=0, ?Y:Float=0,?SelfDestroy:Bool=false, ?Velocity:Int=-120) 
	{
		super(X, Y);
		
		loadGraphic(AssetPaths.bullet1__png);
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
		if (!waiting)
		{
			super.update(elapsed);
			prevPositionY = y;
			y += vy*elapsed;
			if (StageTools.FueraDePantalla(getPosition()))
			{
				explode();
			}	
		}
	}
	public function getCorrectedPosition():FlxPoint
	{		
		return new FlxPoint(x + width / 2, y + height / 2);
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
				points.push(new FlxPoint(x+width/2,i+height/2));
			}
		}else{
			points.push(getPosition());			
		}
		return(points);
	}
	
	public function explode()
	{
		if (selfDestroy) {
				//trace("BOOM");
				FlxG.sound.play(AssetPaths.explode1__ogg, 0.5);	
				var e:LittleExplosion = new LittleExplosion(x+width/2, y+width/2);
				destroy();
			}else {
				//trace("ded x.X");
				FlxG.sound.play(AssetPaths.explode1__ogg, 0.5);	
				var e:LittleExplosion = new LittleExplosion(x+width/2, y+width/2);
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
		if (point.x > x + width/2 - 2 && point.x < x + width/2 + 2 && point.y < y + height/2 + 2 && point.y > y + height/2 - 2) 
		{
			return true;
		}
		return false;
	}
}