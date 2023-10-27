extends Node


@onready var pause_menu:PauseMenu = $UI/PauseMenu


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pause_menu.opened.connect(func():
		get_tree().paused = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	)
	pause_menu.closed.connect(func():
		get_tree().paused = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	)
