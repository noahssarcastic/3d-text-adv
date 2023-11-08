class_name Main extends Node


@onready var pause_menu:PauseMenu = $UI/PauseMenu
@onready var prompt: Prompt = $UI/Prompt

var game_objects: Array[GameObject]


static var MENU_STATE_GAME: GameplayMenuState = GameplayMenuState.new()
static var MENU_STATE_PAUSED: PausedMenuState = PausedMenuState.new()
static var MENU_STATE_PROMPT: PromptMenuState = PromptMenuState.new()

var state: BaseMenuState:
	set(new_state):
		if state:
			state.exit(self)
		state = new_state
		state.enter(self)


func _ready():
	state = MENU_STATE_GAME
	
	for child in $World/GameObjects.get_children():
		if child is GameObject:
			game_objects.append(child)
	
	pause_menu.resume_clicked.connect(func():
		state = MENU_STATE_GAME
	)
	
	prompt.prompt_submitted.connect(func(text: String):
		handle_prompt(text)
	)


func _input(event):
	if event.is_action_pressed("esc"):
		state.handle_esc(self)
	if event.is_action_pressed("interact"):
		state.handle_interact(self)


func handle_prompt(text: String) -> void:
	var prompt_parts = text.split(" ")
	if prompt_parts.size() < 1:
		return
	var verb = prompt_parts[0]
	if prompt_parts.size() == 1:
		match verb:
			"look": 
				for l in Lookable.look_around(game_objects):
					prompt.write(l)
			"clear":
				prompt.reset_display()
		return
#	var obj = prompt_parts[1]
#	match verb:
#			"look": 
#				print(Lookable.look_around(game_objects))
