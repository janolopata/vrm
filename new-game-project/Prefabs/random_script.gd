extends Node3D

@export var broken_model: PackedScene

# Called when the rock collides with the statue
func _on_statue_body_entered(body: Node) -> void:
	if body.is_in_group("rock"):  # Check if the collider is in the "rock" group
		destroy_statue()

# Function to handle the destruction logic
func destroy_statue() -> void:
	print("Statue destroyed!")
	var broken_model_inst: Node3D = broken_model.instantiate()
	get_parent().add_child(broken_model_inst)
	broken_model_inst.transform = self.transform
	self.queue_free()
