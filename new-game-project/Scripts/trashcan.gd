extends Interactable

var is_open = false  # Tracks if the lid is open
@onready var trash_detector: Area3D = $"/root/Node3D/Environment/Objects/trashcan/TrashDetector"
var required_trash_count: int = 1  # Total trash required to complete the task
var current_trash_count: int = 0  # Tracks the number of trash pieces inside the trashcan
@onready var game_ui: Node = $"/root/Node3D/Player/CameraPivot/Camera3D/GameUI"  # Reference to the game UI
@onready var sound_player: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var sound_player2: AudioStreamPlayer = $AudioStreamPlayer

# Override the interact() function
func interact(interactor: Interactor) -> void:
	if is_open:
		close_lid()
	else:
		open_lid()

# Function to open the lid
func open_lid() -> void:
	is_open = true
	# Rotate the lid to open (adjust the axis to match your model's orientation)
	rotation_degrees.x = -100  # Example: Open to 90 degrees
	print("Trashcan lid opened!")

# Function to close the lid
func close_lid() -> void:
	is_open = false
	# Rotate the lid to close
	rotation_degrees.x = 0  # Example: Return to closed position
	print("Trashcan lid closed!")

# Detect when trash enters the trashcan
func _ready() -> void:
	# Connect to the Area3D's body_entered signal
	trash_detector.body_entered.connect(_on_trash_entered)

# Handle trash entering the trashcan
func _on_trash_entered(body: Node) -> void:
	if body.is_in_group("trash"):  # Ensure only trash objects are detected
		current_trash_count += 1
		sound_player.play()
		print("Trash entered the trashcan! Current count: " + str(current_trash_count))
		
		# Check if the task is complete
		if current_trash_count >= required_trash_count:
			mark_task_as_done()

# Update the GameUI to mark the task as complete
func mark_task_as_done() -> void:
	sound_player2.play()
	if game_ui.has_method("mark_task_done_trash"):
		game_ui.call("mark_task_done_trash")
	print("Task complete: All trash thrown into the trashcan!")
