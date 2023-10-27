class_name PauseMenu
extends Control


@onready var _resume_button: Button = $VBoxContainer/Resume
@onready var _quit_button: Button = $VBoxContainer/Quit

var is_paused: bool = false:
	set(new_state):
		is_paused = new_state
		_pause() if is_paused else _unpause()

signal opened
signal closed

func _ready():
	self.visible = false
	_resume_button.pressed.connect(func():
		is_paused = false
	)
	_quit_button.pressed.connect(func():
		get_tree().quit()
	)


func _input(event):
	if event.is_action_pressed("pause"):
		is_paused = !is_paused


func _pause() -> void:
	self.visible = true
	opened.emit()


func _unpause() -> void:
	self.visible = false
	closed.emit()
	
