extends Node3D

@onready var basket_center = $BasketCenter.global_transform.origin
@export var magnet_range: float = 0.2  # Range within which the magnet effect applies
@export var magnet_strength: float = 8.0  # Strength of the pull

func _process(_delta):
	for body in get_tree().get_nodes_in_group("pickable"):
		if body is RigidBody3D:
			var distance = body.global_transform.origin.distance_to(basket_center)
			
			# If the ball is within the magnet range
			if distance < magnet_range:
				var direction = (basket_center - body.global_transform.origin).normalized()
				body.apply_central_force(direction * magnet_strength)
