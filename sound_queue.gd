@tool
class_name SoundQueue extends Node
## Allow multiple concurrent playbacks of a single [AudioStreamPlayer].
##
## Structure holds an array of duplicate [AudioStreamPlayer]s which can be
## played concurrently without interupting previous playbacks.


## How many concurrent playbacks are supported.
@export var count: int = 1

var _next: int = 0
var _players: Array[AudioStreamPlayer] = []


func _ready():
	var children: Array[Node] = find_children("*", "AudioStreamPlayer", false)
	if children.size() != 1 or not children[0] is AudioStreamPlayer:
		push_warning("Expected exactly one AudioStremPlayer child.")
		return
	var base_player: AudioStreamPlayer = children[0]
	_players.append(base_player)
	for i in range(count - 1):
		var dupe: AudioStreamPlayer = base_player.duplicate()
		add_child(dupe)
		_players.append(dupe)


func _get_configuration_warnings():
	var children: Array[Node] = find_children("*", "AudioStreamPlayer", false)
	if children.size() != 1 or not children[0] is AudioStreamPlayer:
		return ["Expected exactly one AudioStremPlayer child."]


## Add a playback to the queue.
##
## If all [AudioStreamPlayer]s are playing, skip playback.
func play_sound() -> void:
	if !_players[_next].playing:
		_players[_next].play()
		_next += 1
		_next %= count
	else:
		push_warning("Playback skipped; queue too small.")
