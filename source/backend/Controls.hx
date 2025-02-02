package backend;

import flixel.input.gamepad.FlxGamepadButton;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.gamepad.mappings.FlxGamepadMapping;
import flixel.input.keyboard.FlxKey;

class Controls
{
	// Keeping same use cases on stuff for it to be easier to understand/use
	// I'd have removed it but this makes it a lot less annoying to use in my opinion
	// You do NOT have to create these variables/getters for adding new keys,
	// but you will instead have to use:
	//   controls.justPressed("ui_up")   instead of   controls.UI_UP
	// Dumb but easily usable code, or Smart but complicated? Your choice.
	// Also idk how to use macros they're weird as fuck lol
	// Pressed buttons (directions)
	public var UI_UP_P(get, never):Bool;
	public var UI_DOWN_P(get, never):Bool;
	public var UI_LEFT_P(get, never):Bool;
	public var UI_RIGHT_P(get, never):Bool;
	public var NOTE_UP_P(get, never):Bool;
	public var NOTE_DOWN_P(get, never):Bool;
	public var NOTE_LEFT_P(get, never):Bool;
	public var NOTE_RIGHT_P(get, never):Bool;

	private function get_UI_UP_P()
		return justPressed('ui_up');

	private function get_UI_DOWN_P()
		return justPressed('ui_down');

	private function get_UI_LEFT_P()
		return justPressed('ui_left');

	private function get_UI_RIGHT_P()
		return justPressed('ui_right');

	private function get_NOTE_UP_P()
		return justPressed('note_up');

	private function get_NOTE_DOWN_P()
		return justPressed('note_down');

	private function get_NOTE_LEFT_P()
		return justPressed('note_left');

	private function get_NOTE_RIGHT_P()
		return justPressed('note_right');

	// Held buttons (directions)
	public var UI_UP(get, never):Bool;
	public var UI_DOWN(get, never):Bool;
	public var UI_LEFT(get, never):Bool;
	public var UI_RIGHT(get, never):Bool;
	public var NOTE_UP(get, never):Bool;
	public var NOTE_DOWN(get, never):Bool;
	public var NOTE_LEFT(get, never):Bool;
	public var NOTE_RIGHT(get, never):Bool;

	private function get_UI_UP()
		return pressed('ui_up');

	private function get_UI_DOWN()
		return pressed('ui_down');

	private function get_UI_LEFT()
		return pressed('ui_left');

	private function get_UI_RIGHT()
		return pressed('ui_right');

	private function get_NOTE_UP()
		return pressed('note_up');

	private function get_NOTE_DOWN()
		return pressed('note_down');

	private function get_NOTE_LEFT()
		return pressed('note_left');

	private function get_NOTE_RIGHT()
		return pressed('note_right');

	// Released buttons (directions)
	public var UI_UP_R(get, never):Bool;
	public var UI_DOWN_R(get, never):Bool;
	public var UI_LEFT_R(get, never):Bool;
	public var UI_RIGHT_R(get, never):Bool;
	public var NOTE_UP_R(get, never):Bool;
	public var NOTE_DOWN_R(get, never):Bool;
	public var NOTE_LEFT_R(get, never):Bool;
	public var NOTE_RIGHT_R(get, never):Bool;

	private function get_UI_UP_R()
		return justReleased('ui_up');

	private function get_UI_DOWN_R()
		return justReleased('ui_down');

	private function get_UI_LEFT_R()
		return justReleased('ui_left');

	private function get_UI_RIGHT_R()
		return justReleased('ui_right');

	private function get_NOTE_UP_R()
		return justReleased('note_up');

	private function get_NOTE_DOWN_R()
		return justReleased('note_down');

	private function get_NOTE_LEFT_R()
		return justReleased('note_left');

	private function get_NOTE_RIGHT_R()
		return justReleased('note_right');

	// Pressed buttons (others)
	public var ACCEPT(get, never):Bool;
	public var BACK(get, never):Bool;
	public var PAUSE(get, never):Bool;
	public var RESET(get, never):Bool;

	private function get_ACCEPT()
		return justPressed('accept');

	private function get_BACK()
		return justPressed('back');

	private function get_PAUSE()
		return justPressed('pause');

	private function get_RESET()
		return justPressed('reset');

	// Gamepad, Keyboard & Mobile stuff
	public var keyboardBinds:Map<String, Array<FlxKey>>;
	public var gamepadBinds:Map<String, Array<FlxGamepadInputID>>;
	#if mobileC public var mobileBinds:Map<String, Array<FlxMobileInputID>>; #end

	public function justPressed(key:String)
	{
		var result:Bool = (FlxG.keys.anyJustPressed(keyboardBinds[key]) == true);
		if (result)
			controllerMode = false;

		return result || _myGamepadJustPressed(gamepadBinds[key]) == true #if mobileC || mobileControlsJustPressed(mobileBinds[key]) == true #end;
	}

	public function pressed(key:String)
	{
		var result:Bool = (FlxG.keys.anyPressed(keyboardBinds[key]) == true);
		if (result)
			controllerMode = false;

		return result || _myGamepadPressed(gamepadBinds[key]) == true #if mobileC || mobileControlsPressed(mobileBinds[key]) == true #end;
	}

	public function justReleased(key:String)
	{
		var result:Bool = (FlxG.keys.anyJustReleased(keyboardBinds[key]) == true);
		if (result)
			controllerMode = false;

		return result || _myGamepadJustReleased(gamepadBinds[key]) == true #if mobileC || mobileControlsJustReleased(mobileBinds[key]) == true #end;
	}

	public var controllerMode:Bool = false;

	private function _myGamepadJustPressed(keys:Array<FlxGamepadInputID>):Bool
	{
		if (keys != null)
		{
			for (key in keys)
			{
				if (FlxG.gamepads.anyJustPressed(key) == true)
				{
					controllerMode = true;
					return true;
				}
			}
		}
		return false;
	}

	private function _myGamepadPressed(keys:Array<FlxGamepadInputID>):Bool
	{
		if (keys != null)
		{
			for (key in keys)
			{
				if (FlxG.gamepads.anyPressed(key) == true)
				{
					controllerMode = true;
					return true;
				}
			}
		}
		return false;
	}

	private function _myGamepadJustReleased(keys:Array<FlxGamepadInputID>):Bool
	{
		if (keys != null)
		{
			for (key in keys)
			{
				if (FlxG.gamepads.anyJustReleased(key) == true)
				{
					controllerMode = true;
					return true;
				}
			}
		}
		return false;
	}
	#if mobileC
	public var isInSubstate:Bool = false; // don't worry about this it becomes true and false on it's own in MusicBeatSubstate
	public var requested(get, default):Dynamic; // is set to MusicBeatState or MusicBeatSubstate when the constructor is called
	public var gameplayRequest(get, default):Dynamic; // for PlayState and EditorPlayState (hitbox and virtualPad)
	public var mobileC(get, never):Bool;
	
	public function mobileControlsPressed(keys:Array<FlxMobileInputID>):Bool {
		return virtualPadPressed(keys) || mobileCPressed(keys);
	}

	public function mobileControlsJustPressed(keys:Array<FlxMobileInputID>):Bool {
		return virtualPadJustPressed(keys) || mobileCJustPressed(keys);
	}

	public function mobileControlsJustReleased(keys:Array<FlxMobileInputID>):Bool {
		return virtualPadJustReleased(keys) || mobileCJustReleased(keys);
	}

	private function virtualPadPressed(keys:Array<FlxMobileInputID>):Bool{
		if(keys != null && requested.virtualPad != null){
			if(requested.virtualPad.anyPressed(keys) == true){
				controllerMode = true; // !!DO NOT DISABLE THIS IF YOU DONT WANT TO KILL THE INPUT FOR MOBILE!!
				return true;
			}
		}
		return false;
	}

	private function virtualPadJustPressed(keys:Array<FlxMobileInputID>):Bool{
		if(keys != null && requested.virtualPad != null){
			if(requested.virtualPad.anyJustPressed(keys) == true){
				controllerMode = true;
				return true;
			}
		}
		return false;
	}

	private function virtualPadJustReleased(keys:Array<FlxMobileInputID>):Bool{
		if(keys != null && requested.virtualPad != null){
			if(requested.virtualPad.anyJustReleased(keys) == true){
				controllerMode = true;
				return true;
			}
		}
		return false;
	}

	// these functions are used for playstate controls, just ignore them and use the controls.justPressed() instead
	private function mobileCPressed(keys:Array<FlxMobileInputID>):Bool{
		if(keys != null && requested.mobileControls != null && gameplayRequest != null){
			if(gameplayRequest.anyPressed(keys) == true){
				controllerMode = true;
				return true;
			}
		}
		return false;
	}

	private function mobileCJustPressed(keys:Array<FlxMobileInputID>):Bool{
		if(keys != null && requested.mobileControls != null && gameplayRequest != null){
			if(gameplayRequest.anyJustPressed(keys) == true){
				controllerMode = true;
				return true;
			}
		}
		return false;
	}

	private function mobileCJustReleased(keys:Array<FlxMobileInputID>):Bool{
		if(keys != null && requested.mobileControls != null && gameplayRequest != null){
			if(gameplayRequest.anyJustReleased(keys) == true){
				controllerMode = true;
				return true;
			}
		}
		return false;
	}

	@:noCompletion
	private function get_requested():Dynamic{
		if(isInSubstate)
			return MusicBeatSubstate.instance;
		else
			return MusicBeatState.instance;
	}

	@:noCompletion
	private function get_gameplayRequest():Dynamic{
		switch(MobileControls.getMode()){
			case 0 | 1 | 2 | 3:
				if(isInSubstate)
					return MusicBeatSubstate.instance.mobileControls.virtualPad;
				else
					return MusicBeatState.instance.mobileControls.virtualPad;
			case 4:
				if(isInSubstate)
					return MusicBeatSubstate.instance.mobileControls.hitbox;
				else
					return MusicBeatState.instance.mobileControls.hitbox;
			default:
				if(isInSubstate)
					return MusicBeatSubstate.instance.mobileControls.virtualPad;
				else
					return MusicBeatState.instance.mobileControls.virtualPad;
		}
	}

	@:noCompletion
	private function get_mobileC():Bool{
		if(ClientPrefs.data.controlsAlpha >= 0.1)
			return true;
		else
			return false;
	}
	#end

	// IGNORE THESE/ karim: no.
	public static var instance:Controls;
	public function new()
	{
		#if mobileC mobileBinds = ClientPrefs.mobileBinds; #end
		gamepadBinds = ClientPrefs.gamepadBinds;
		keyboardBinds = ClientPrefs.keyBinds;
	}
}
