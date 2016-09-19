package clases;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.system.FlxAssets.FlxGraphicAsset;


/**
 * ...
 * @author ...
 */
class Digitalizer
{
	var maxDigits:Int = 7;
	var digits:Array<Int> = [];
	
	var numberSprites:Array<FlxSprite> = [];	
	
	var x:Int = 0;
	var y:Int = 0;
	private var number:Int = 0;
	public function new(X:Int,Y:Int,?Number:Int=0) 
	{
		x = X;
		y = Y;
		loadAssets();		
		createSprites();
		digitalize(Number);
		refreshSpriteArray();
		positionSprites();
	}	
	
	private function createSprites()
	{	
		for (i in 0...maxDigits)
		{
			var digitSprite:FlxSprite = new FlxSprite();
			numberSprites.push(digitSprite);
			FlxG.state.add(digitSprite);
		}			
	}	
	
	private function refreshSpriteArray()
	{
		for (i in 0...maxDigits)
		{			
			numberSprites[i].loadGraphic(numberAssets[digits[i]]);
		}
	}
	var numberAssets:Array<FlxGraphicAsset> = [];
	private function loadAssets()
	{	
		
		var n0:FlxGraphicAsset = AssetPaths.num2_0__png;
		numberAssets.push(n0);
		var n1:FlxGraphicAsset = AssetPaths.num2_1__png;
		numberAssets.push(n1);
		var n2:FlxGraphicAsset = AssetPaths.num2_2__png;
		numberAssets.push(n2);
		var n3:FlxGraphicAsset = AssetPaths.num2_3__png;
		numberAssets.push(n3);
		var n4:FlxGraphicAsset = AssetPaths.num2_4__png;
		numberAssets.push(n4);
		var n5:FlxGraphicAsset = AssetPaths.num2_5__png;
		numberAssets.push(n5);
		var n6:FlxGraphicAsset = AssetPaths.num2_6__png;
		numberAssets.push(n6);
		var n7:FlxGraphicAsset = AssetPaths.num2_7__png; 
		numberAssets.push(n7);
		var n8:FlxGraphicAsset = AssetPaths.num2_8__png;
		numberAssets.push(n8);
		var n9:FlxGraphicAsset = AssetPaths.num2_9__png;
		numberAssets.push(n9);
	}
	private function positionSprites()
	{
		var offset:Int = 0;		
		for (i in 0...maxDigits)
		{				
			offset += 7;			
			numberSprites[i].x = offset + x;
			numberSprites[i].y = y;			
		}
	}
	
	public function update(newNumber:Int)
	{
		if (number != newNumber)
		{
			digitalize(newNumber);
			refreshSpriteArray();
			positionSprites();
		}
	}
	
	public function digitalize(newNumber:Int)
	{	
		number = newNumber;
		if (newNumber >= Math.pow(10, maxDigits))
		{
			newNumber = maxNumber();
		}
		
		digits = [];
		var i:Int = maxDigits;
		
		
		while (newNumber>=10 && i>0)
		{
			var digit:Int = newNumber % 10;
			newNumber = Math.floor(newNumber / 10);
			digits.insert(0,digit);
			i--;
		}
		
		if (i > 0)
		{
			digits.insert(0, newNumber % 10);
			i--;
		}		
		
		while (i>0)
		{
			digits.insert(0,0);
			i--;			
		}				
	}
	
	
	private function maxNumber():Int
	{
		var tempNumber:Int = 0;
		for (i in 0...maxDigits)
		{
			tempNumber += Std.int(9 * Math.pow(10, i));
		}
		return tempNumber;
	}
	
	
}