class_name Prompt extends Control


@onready var _line_edit: LineEdit = $MarginContainer/LineEdit


signal prompt_submitted(text: String)


func _ready():
	self.visible = false
	_line_edit.text_submitted.connect(func(text: String):
		prompt_submitted.emit(text)
	)


func open() -> void:
	await get_tree().create_timer(0.1).timeout
	_line_edit.clear()
	_line_edit.grab_focus()
	self.visible = true


func close() -> void:
	self.visible = false
	_line_edit.clear()
