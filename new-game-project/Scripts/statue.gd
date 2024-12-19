extends Node3D  # The statue is still a Node3D

@export var broken_model: PackedScene  # Ensure this is the broken version of the statue scene
@onready var collision_area: Area3D = $Area3D  # Reference to the Area3D node we added for collision detection
@onready var game_ui: Node = $"/root/Node3D/Player/CameraPivot/Camera3D/GameUI"
@onready var sound_player2: AudioStreamPlayer = $AudioStreamPlayer

# This signal is triggered when a body (the rock) enters the statue's area
func _ready() -> void:
	# Connect the body_entered signal to the _on_body_entered function
	collision_area.body_entered.connect(_on_body_entered)

# This function is triggered when an object enters the Area3D (statue)
func _on_body_entered(body: Node) -> void:
	# Check if the object that entered is in the "rock" group
	if body.is_in_group("rock"):  
		destroy_statue()

# Function to destroy the statue and spawn the broken model
func destroy_statue() -> void:
	print("Statue destroyed!")  # Debugging message to confirm the destruction
	var broken_model_inst: Node3D = broken_model.instantiate()  # Create a new broken model
	get_parent().add_child(broken_model_inst)  # Add it to the parent node
	broken_model_inst.transform = self.transform  # Set its transform to match the statue's
	mark_task_as_done()
	self.queue_free()  # Remove the original statue

func mark_task_as_done() -> void:
	sound_player2.play()
	if game_ui.has_method("mark_task_done_statue"):
		game_ui.call("mark_task_done_statue")
	print("Task complete: Statue destroyed!")
