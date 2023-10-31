class_name GameObject extends Node3D


var object_name: String

var _visibility_notifier: VisibleOnScreenNotifier3D


func _ready():
	_visibility_notifier = VisibleOnScreenNotifier3D.new()
	self.add_child(_visibility_notifier)


func is_in_view() -> bool:
	return _visibility_notifier.is_on_screen()
