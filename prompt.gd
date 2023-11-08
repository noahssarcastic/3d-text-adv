class_name Prompt extends Control


@onready var _input: LineEdit = $MarginContainer/VBoxContainer/LineEdit
@onready var _output: Terminal = $MarginContainer/VBoxContainer/Terminal


signal prompt_submitted(text: String)


func _ready():
	if !get_meta("debug"):
		self.visible = false
		
	_input.text_submitted.connect(func(text: String):
		_input.clear()
		prompt_submitted.emit(text)
		if get_meta("debug"):
			write(text)
	)


func open() -> void:
	await get_tree().create_timer(0.1).timeout
	_input.clear()
	_input.grab_focus()
	self.visible = true


func close() -> void:
	self.visible = false
	_input.clear()


func write(text: String) -> void:
	_output.write(text)
	_output.animate()


func reset_display() -> void:
	_output.clear()
