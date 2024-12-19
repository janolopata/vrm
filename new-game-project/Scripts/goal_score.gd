extends Area3D

@onready var game_ui: Node = $"/root/Node3D/Player/CameraPivot/Camera3D/GameUI" 

func _ready():
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	# Check if the entering body is the basketball
	if body.is_in_group("basketball"):
		print("Goal scored!")
		mark_task_as_done()

# Update the GameUI to mark the task as complete
func mark_task_as_done() -> void:
	if game_ui.has_method("mark_task_done_basketball"):
		game_ui.call("mark_task_done_basketball")
	print("Task complete: You scored!")
