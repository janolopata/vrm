extends Area3D

# The respawn position for objects
var respawn_position: Vector3 = Vector3(0, 5, 0)

# Array to track held objects so we don't respawn them
var held_objects: Array = []

func _ready():
	# Connect the signal that will be triggered when a body exits the area
	self.body_exited.connect(_on_body_exited)

# This function will be called when a body leaves the area
func _on_body_exited(body: Node) -> void:
	# If the object is in the "pickable" group and is not in the held_objects list, respawn it
	if body.is_in_group("pickable") and body not in held_objects:
		respawn_object(body)

# Function to respawn an object
func respawn_object(object: Node) -> void:
	print(object.name + " has left the area! Respawning...")
	object.position = respawn_position  # Reset the object's position
	if object is RigidBody3D:
		object.linear_velocity = Vector3.ZERO  # Stop any movement for RigidBody3D objects

# This function ensures objects are not incorrectly monitored
func add_to_held_objects(object: Node) -> void:
	if object not in held_objects:
		held_objects.append(object)

func remove_from_held_objects(object: Node) -> void:
	if object in held_objects:
		held_objects.erase(object)
