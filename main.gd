class_name Main extends Node


@onready var pause_menu:PauseMenu = $UI/PauseMenu
@onready var prompt: Prompt = $UI/Prompt


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
	
	pause_menu.resume_clicked.connect(func():
		state = MENU_STATE_GAME
	)
	
	prompt.prompt_submitted.connect(func(text: String):
		print(text)
		state = MENU_STATE_GAME
	)


func _input(event):
	if event.is_action_pressed("esc"):
		state.handle_esc(self)
	if event.is_action_pressed("interact"):
		state.handle_interact(self)
