extends Node3D


@export var INTENSITY:float = 0.01
@onready var sound_player: AudioStreamPlayer3D = $AudioStreamPlayer3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	statue_sound()
	for piece in self.get_children():
		if piece is RigidBody3D:
			(piece as RigidBody3D).apply_impulse(
				piece.get_child(0).position * INTENSITY, self.global_position
			);
	
func statue_sound() -> void:
	sound_player.play()
