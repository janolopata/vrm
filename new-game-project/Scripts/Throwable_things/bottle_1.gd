extends Throwable

class_name Bottle1

@onready var sound_player: AudioStreamPlayer3D = $AudioStreamPlayer3D
	
func _physics_process(delta: float) -> void:
	collision_detection()
	
var current_collisions: Dictionary = {}
var previous_collisions: Dictionary = {}

func collision_detection() -> void:
	# Swap current and previous sets
	var temp = previous_collisions
	previous_collisions = current_collisions
	current_collisions = temp
	current_collisions.clear()

	# Check for new collisions
	for body in get_colliding_bodies():
		current_collisions[body] = true
		if not previous_collisions.has(body):
			on_new_collision()
			break
	
func on_new_collision():
	if sound_player and not sound_player.is_playing():
		sound_player.play()
