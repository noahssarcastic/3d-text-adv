class_name PausedMenuState extends BaseMenuState


func enter(context: Main) -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	context.get_tree().paused = true
	context.pause_menu.open()


func handle_esc(context: Main) -> void:
	context.state = context.MENU_STATE_GAME


func handle_interact(_context: Main) -> void:
	pass


func exit(context: Main) -> void:
	context.get_tree().paused = false
	context.pause_menu.close()
