package;

import clases.NewUFO;
import clases.ScrollingBackground;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import PlayState;
import flixel.system.scaleModes.PixelPerfectScaleMode;
class MenuState extends FlxState
{
	var b:ScrollingBackground;
	override public function create():Void
	{
		super.create();
		FlxG.resizeWindow(FlxG.initialWidth * 3, FlxG.initialHeight * 3);
		FlxG.scaleMode = new PixelPerfectScaleMode();
		
		b = new ScrollingBackground(AssetPaths.bg1__png); 
		add(b);		
		var MenuSign:FlxSprite = new FlxSprite(0,0,AssetPaths.bg0__png);
		add(MenuSign);
		var Alien:NewUFO = new NewUFO(50, 50);		
		add(Alien);
		
		FlxG.sound.playMusic(AssetPaths.music1__ogg, 0.5); //para reproducir musica, recordar subir la musica en la carpeta music en formato WAV
	}

	override public function update(elapsed:Float):Void
	{		
		
		super.update(elapsed);		
		if (FlxG.keys.anyJustPressed([FlxKey.A,FlxKey.D,FlxKey.J]))
		{
			FlxG.switchState(new PlayState());
		}
	}
}
