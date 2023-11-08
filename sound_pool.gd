@tool
class_name SoundPool extends Node


var _sounds: Array[SoundQueue] = []
var _last_index: int = -1


func _ready():
	var children: Array[Node] = find_children("*", "SoundQueue", false)
	if children.size() < 2:
		push_warning("Expected at least 2 SoundQueue children.")
		return
	for child in children:
		_sounds.append(child)


func _get_configuration_warnings():
	var children: Array[Node] = find_children("*", "SoundQueue", false)
	if children.size() < 2:
		return ["Expected at least 2 SoundQueue children."]


func play_sound() -> void:
	var idx: int = randi_range(0, _sounds.size() - 1)
	while (idx == _last_index):
		idx = randi_range(0, _sounds.size() - 1)
	_sounds[idx].play_sound()
	_last_index = idx
