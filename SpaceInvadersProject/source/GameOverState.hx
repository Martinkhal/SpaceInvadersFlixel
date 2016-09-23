package;
import clases.Digitalizer;
import clases.ScrollingBackground;
import clases.StageTools;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
/**
 * ...
 * @author ...
 */
class GameOverState extends FlxState
{
	var score:Digitalizer;
	var b:ScrollingBackground;
	override public function create():Void
	{
		super.create();
		b = new ScrollingBackground(AssetPaths.bg1__png); 
		b.speed = -3;
		add(b);		
		var scoreSign:FlxSprite = new FlxSprite(30,20,AssetPaths.HighScoresSign__png);
		add(scoreSign);
		score = new Digitalizer(59, 50, 6, StageTools.highscore);
		
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