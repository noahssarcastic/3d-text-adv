class_name Terminal extends Control


@onready var _display: RichTextLabel = $RichTextLabel
@onready var sound_pool: SoundPool = $SoundPool

var _last_animated_character: int
var _timer: RandomTimer


func _ready():
	_last_animated_character = _display.get_total_character_count()
	_display.visible_characters = _last_animated_character
	_timer = RandomTimer.new()
	_timer.minimum_interval = 0.01
	_timer.maximum_interval = 0.1
	_timer.timeout.connect(func():
		sound_pool.play_sound()
	)
	add_child(_timer)


func write(text: String) -> void:
	_display.append_text(text)
	_display.newline()
	
	if(_display.get_content_height() > self.size[1]):
		_display.fit_content = false
		_display.anchors_preset = PRESET_FULL_RECT


func animate() -> void:
	var curr_char_count: int = _display.get_total_character_count()
	
	var tween: Tween = self.create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(_display, "visible_characters", curr_char_count, 2.0).from_current()
	tween.tween_callback(_timer.stop)
	_timer.start()
	_last_animated_character = curr_char_count


func clear():
	_display.clear()
	_last_animated_character = _display.get_total_character_count()
	_display.fit_content = true
	_display.anchors_preset = PRESET_BOTTOM_WIDE
