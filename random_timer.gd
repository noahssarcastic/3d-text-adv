class_name RandomTimer extends Node
## Trigger something multiple times at a random interval.
##
## Timer restarts after timeout until [stop] is called.


## The minimum interval the timer will run for (inclusive).
@export_range(0.05, 100, 0.01,"or_greater") var minimum_interval: float = 0.1
## The maximum interval the timer will run for (inclusive).
@export_range(0.05, 100, 0.01,"or_greater") var maximum_interval: float = 10.0

var _timer: Timer

## Emitted when the timer reaches 0.
signal timeout


func _ready():
	_timer = Timer.new()
	_timer.one_shot = true
	_timer.autostart = false
	_timer.timeout.connect(_on_timer_timeout)
	add_child(_timer)


func _on_timer_timeout() -> void:
	timeout.emit()
	start()


## Starts the timer with a random wait_time.
func start() -> void:
	if _timer.is_stopped():
		_timer.start(randf_range(minimum_interval, maximum_interval))


## Stops the timer.
func stop() -> void:
	if !_timer.is_stopped():
		_timer.stop()
