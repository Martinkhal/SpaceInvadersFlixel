package clases;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.utils.ByteArray;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxAssets.FlxGraphicAsset;
import openfl.geom.Rectangle;

/**
 * ...
 * @author ...
 */
class Shield extends FlxSprite
{

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.shield__png,false,true);
		//makeGraphic (16, 10);
		//graphic.bitmap.setPixel(0, 0, 0);
	}
	public function ResetGraphic()
	{
		//graphic.bitmap.fillRect(new Rectangle(0, 0, 16, 10), 0xFFAAFFAA);	
		
		loadGraphic(AssetPaths.shield__png,false,true);
		dirty = true;
	}
	public function CollidePoint(point:FlxPoint):Bool
	{
		if (!alive)
		{
			return false;
		}		
		if (pixelsOverlapPoint(point))
		{
			var hitX:Int = Math.floor(point.x - x);
			var hitY:Int = Math.floor(point.y - y);
			
			if (hitX < 0)
			{
				hitX = 0;
			}
			if (hitY < 0)
			{
				hitY = 0;
			}
			if (hitX > graphic.width)
			{
				hitX = graphic.width-1;
			}
			if (hitY > graphic.height)
			{
				hitY = graphic.height-1;
			}
				
			//var bit:BitmapData = FlxG.bitmap.create(5, 5, 0x00000000, false).bitmap;	
			//CopyBitmapManually(bit, hitX - Math.floor(bit.width/2), Math.floor(hitY-bit.height/2));
			var bit:BitmapData = FlxG.bitmap.add(AssetPaths.bulletMask1__png).bitmap;
			Mask(bit, hitX - Math.floor(bit.width / 2), Math.floor(hitY - bit.height / 2));		
			
			return true;
		}else{
			return false;
		}
	}
	public function DropPixel(X:Float,Y:Float,Color:Int)
	{
		var roguePixel:RoguePixel = new RoguePixel( X, Y, Color);
		FlxG.state.add(roguePixel);
	}
	
	public function CollidePoints(points:Array<FlxPoint>):Bool
	{		
		var collided:Bool = false;
		for (i in 0...points.length)
		{
			collided = CollidePoint(points[i]) || collided;
		}		
		return collided;
	}
	
	public function CopyBitmapManually(bit:BitmapData,offsetX:Int,offsetY:Int)
	{
		graphic.bitmap.lock();
		for (i in 0...bit.width)
		{
			for (j in 0...bit.height)
			{
				graphic.bitmap.setPixel32(i+offsetX,j+offsetY,bit.getPixel32(i,j));				
			}			
		}		
		graphic.bitmap.unlock();
		dirty = true;
	}
	public function Mask(bit:BitmapData, offsetX:Int, offsetY:Int)
	{
		graphic.bitmap.lock();
		for (i in 0...bit.width)
		{
			for (j in 0...bit.height)
			{
				if (bit.getPixel32(i, j) == 0xFF000000){
					DropPixel(i + offsetX+x, j + offsetY+y, graphic.bitmap.getPixel32(i + offsetX, j + offsetY));					
					graphic.bitmap.setPixel32(i + offsetX, j + offsetY, 0x00000000);		
				}
			}			
		}		
		graphic.bitmap.unlock();
		dirty = true;
	}
}