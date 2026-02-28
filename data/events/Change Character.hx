import haxe.ds.StringMap;

var debugMode:Bool = false;
var charMap:Array<Array<StringMap<Character>>> = [];

// partially stole from gorefield lol
function postCreate() {
	for (event in events) {
		if (event.name == 'Change Character') {
			for (strumLane in strumLines) {
				var strumIndex:Int = strumLines.members.indexOf(strumLane);
				if (charMap[strumIndex] == null) charMap[strumIndex] = [];
				if (debugMode) trace('Strum Index: ' + strumIndex);
				
				for (char in strumLane.characters) {
					var charIndex:Int = strumLane.characters.indexOf(char);
					if (charMap[strumIndex][charIndex] == null) charMap[strumIndex][charIndex] = new StringMap();
					if (debugMode) trace('Character Index: ' + charIndex);

					var charName:String = event.params[1];
					if (char.curCharacter == charName) {
						if (debugMode) trace('Old Character: ' + char.curCharacter);
						charMap[strumIndex][charIndex].set(char.curCharacter, char);
					}
					if (!charMap[strumIndex][charIndex].exists(charName)) {
						var newChar:Character = new Character(char.x, char.y, charName, char.isPlayer);
						if (debugMode) trace('New Character: ' + newChar.curCharacter);
						charMap[strumIndex][charIndex].set(newChar.curCharacter, newChar);
						newChar.visible = false;
						newChar.drawComplex(FlxG.camera);
					}
				}
			}
		}
	}
}

function onEvent(event) {
	if (event.event.name == 'Change Character') {
		var params = {
			strumIndex: event.event.params[0],
			charName: event.event.params[1],
			charIndex: event.event.params[2]
		};
		if (debugMode) trace('Change Character Event Called: ' + params);
		var oldChar:Character = strumLines.members[params.strumIndex].characters[params.charIndex];
		var newChar:Character = charMap[params.strumIndex][params.charIndex].get(params.charName);
		var charPosition = PlayState.instance.stage.characterPoses.get(strumLines.members[params.strumIndex].data.position);
		if (oldChar.curCharacter == newChar.curCharacter) return;
		insert(members.indexOf(oldChar), newChar);
		newChar.visible = true;
		remove(oldChar);
		
		newChar.setPosition(charPosition.x, charPosition.y);
		newChar.scale.x *= charPosition.scale.x;
		newChar.scale.y *= charPosition.scale.y;
		newChar.cameraOffset.x += charPosition.camxoffset;
		newChar.cameraOffset.y += charPosition.camyoffset;
		newChar.playAnim(oldChar.animation.name);
		newChar.animation?.curAnim?.curFrame = oldChar.animation?.curAnim?.curFrame;
		strumLines.members[params.strumIndex].characters[params.charIndex] = newChar;

		if (params.charIndex == 0) {
			if (params.strumIndex == 0) iconP2.setIcon(newChar.getIcon());
			else if (params.strumIndex == 1) iconP1.setIcon(newChar.getIcon());
		}

		var leftColor:Int = dad != null && dad.iconColor != null && Options.colorHealthBar ? dad.iconColor : (PlayState.opponentMode ? 0xFF66FF33 : 0xFFFF0000);
		var rightColor:Int = boyfriend != null && boyfriend.iconColor != null && Options.colorHealthBar ? boyfriend.iconColor : (PlayState.opponentMode ? 0xFFFF0000 : 0xFF66FF33); // switch the colors
		healthBar.createFilledBar(leftColor, rightColor);
	}
}