class_name PromptMenuState extends BaseMenuState


func enter(context: Main) -> void:
	context.get_tree().paused = true
	context.prompt.open()


func handle_esc(context: Main) -> void:
	context.state = context.MENU_STATE_GAME


func handle_interact(_context: Main) -> void:
	pass


func exit(context: Main) -> void:
	context.get_tree().paused = false
	context.prompt.close()
