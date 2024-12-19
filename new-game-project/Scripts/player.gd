extends CharacterBody3D

class_name Player

## Refferences

@onready var ui: UI_Game = get_node("CameraPivot/Camera3D/GameUI") as UI_Game
@onready var hand: Node3D = get_node("CameraPivot/Hand") as Node3D  

## Player movement

@export var walk_speed: float = 2.0
@export var sprint_speed: float = 3.0  # Speed when sprinting
@export var gravity: float = -9.8
@export var jump_velocity: float = 2.0

func _physics_process(delta):
	# Get input direction
	var input_dir = Vector3.ZERO
	input_dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_dir.z = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	input_dir = input_dir.normalized()
	
	# Check if sprinting
	var current_speed = walk_speed
	if Input.is_action_pressed("sprint"):
		current_speed = sprint_speed

	# Move the player
	var direction = (transform.basis * input_dir).normalized()
	velocity.x = direction.x * current_speed
	velocity.z = direction.z * current_speed

	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	# Jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Move and slide
	move_and_slide()

## Mouse looking

# Sensitivity for mouse movement
@export var mouse_sensitivity = 0.0075

# Pitch (up/down rotation), limits to prevent flipping
var pitch = 0.0
var pitch_limit = 89.0  # Prevents the camera from flipping upside down
var target_pitch = 0.0

func _ready():
	# Capture the mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion:
		# Horizontal rotation (yaw)
		rotate_y(-deg_to_rad(event.relative.x) * mouse_sensitivity)

		# Vertical rotation (pitch)
		pitch -= event.relative.y * mouse_sensitivity
		pitch = clamp(pitch, -pitch_limit, pitch_limit)

		# Apply the pitch to the camera or a child node
		if get_node("CameraPivot"):  # Replace 'CameraPivot' with your vertical rotation node
			get_node("CameraPivot").rotation_degrees.x = pitch
		else:
			print("test")
