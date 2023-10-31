class_name PauseMenu extends Control


@onready var _resume_button: Button = $VBoxContainer/Resume
@onready var _quit_button: Button = $VBoxContainer/Quit

signal resume_clicked


func _ready():
	self.visible = false
	_resume_button.pressed.connect(func():
		resume_clicked.emit()
	)
	_quit_button.pressed.connect(func():
		get_tree().quit()
	)


func open() -> void:
	self.visible = true


func close() -> void:
	self.visible = false
