extends Interactable

class_name Holdable

var current_interactor: Interactor = null

@onready var original_parent: Node = get_parent()
@onready var hand: Node3D = get_node("/root/Node3D/Player/CameraPivot/Hand")  # Ensure this is the correct hand node
@onready var playing_area: Area3D = get_node("/root/Node3D/PlayingArea")  # Reference to the playing area

# Called when the player interacts with the object
func interact(interactor: Interactor) -> void:
	pickup(interactor)

# Pick up the object
func pickup(interactor: Interactor) -> void:
	if current_interactor:
		drop()  # Drop the object if it's already held
	current_interactor = interactor
	original_parent.remove_child(self)
	current_interactor.hand.add_child(self)  # Attach the object to the player's hand

	# Temporarily disable area detection for this object while it is held
	playing_area.add_to_held_objects(self)  # Mark this object as being held

	# Position the object relative to the hand (adjust the offset as needed)
	var hand_position = current_interactor.hand.global_transform.origin
	var hand_rotation = current_interactor.hand.global_transform.basis
	var offset = Vector3(0, 0, 0)  # Adjust this offset to fine-tune the position

	# Position the object relative to the hand using global transform
	global_transform.origin = hand_position + hand_rotation * offset

	# Freeze the object's physics while holding it
	freeze = true
	current_interactor.in_holding = self
	print("Object picked up and placed in hand.")

# Drop the object
func drop() -> void:
	var original_position = global_transform.origin
	current_interactor.hand.remove_child(self)  # Remove the object from the hand
	original_parent.add_child(self)  # Reattach it to its original parent
	freeze = false  # Release the physics freeze
	current_interactor.in_holding = null
	current_interactor = null
	global_transform.origin = original_position  # Reset its position

	# Re-enable area detection for this object when it is dropped
	playing_area.remove_from_held_objects(self)  # Remove it from the held objects list
