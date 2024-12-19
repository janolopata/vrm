extends Holdable

class_name Throwable

@export var throw_force: float = 3

func throw() -> void:
	var interactor_temp = current_interactor
	drop()

	# Apply a forward throw force
	var throw_direction = -interactor_temp.global_transform.basis.z.normalized()  # Forward direction
	apply_impulse(throw_direction * throw_force)
	
