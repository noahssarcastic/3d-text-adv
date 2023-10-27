class_name Player
extends CharacterBody3D


@export var move_speed: float = 5.0
@export var jump_velocity: float = 4.5
@export var look_speed: float = 0.01

var _gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var _x_rotation: float = 0.0
var _y_rotation: float = 0.0

@onready var _camera: Camera3D = $Camera3D


func _input(event):
	if event is InputEventMouseMotion:
		_x_rotation += -event.relative.x * look_speed
		# Prevent accumulator from going to +-inf
		_x_rotation = fmod(_x_rotation, (2.0 * PI))
		transform.basis = Basis()
		rotate_object_local(Vector3(0, 1, 0), _x_rotation)
		
		_y_rotation += -event.relative.y * look_speed
		# Prevent camera from flipping upside-down
		_y_rotation = clampf(_y_rotation, -0.5 * PI, 0.5 * PI)
		_camera.transform.basis = Basis()
		_camera.rotate_object_local(Vector3(1, 0, 0), _y_rotation)


func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= _gravity * delta

	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = jump_velocity

	var input_dir: Vector2  = Input.get_vector(
		"move_left", 
		"move_right", 
		"move_forward", 
		"move_back",
	)
	var direction: Vector3 = transform.basis * Vector3(input_dir.x, 0, input_dir.y)
	direction = direction.normalized()
	if direction:
		velocity.x = direction.x * move_speed
		velocity.z = direction.z * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		velocity.z = move_toward(velocity.z, 0, move_speed)

	move_and_slide()

