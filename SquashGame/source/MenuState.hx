package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxG;

class MenuState extends FlxState
{
	function clickPlay()
	{
		FlxG.switchState(new PlayState());
	}
	var _btnPlay:FlxButton;
	var developer:FlxText;
	override public function create():Void
	{
		_btnPlay = new FlxButton(10, 10, "PlayNow", clickPlay);
		add(_btnPlay);
		_btnPlay.screenCenter();	
		super.create();
		developer = new FlxText(280,300, 100, "Developed by Tejas Wadiwala \n @tejaswadiwala");
		add(developer);
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

}