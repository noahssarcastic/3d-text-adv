class_name GameplayMenuState extends BaseMenuState


func enter(_context: Main) -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func handle_esc(context: Main) -> void:
	context.state = context.MENU_STATE_PAUSED


func handle_interact(context: Main) -> void:
	context.state = context.MENU_STATE_PROMPT


func exit(_context: Main) -> void:
	pass
