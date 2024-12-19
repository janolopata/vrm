extends Node3D

var start_position: Vector3
var end_position: Vector3
@export var flight_duration: float = 20.0  # Time in seconds for the plane to fly
@export var wait_time: float = 60.0       # Time to wait before flying again

@onready var plane_mesh: MeshInstance3D = $plane  
@onready var audio_player: AudioStreamPlayer3D = $plane_sound

var flying: bool = false
var flight_timer: float = 0.0

func _ready():
	start_position = Vector3(0, 70, 300)
	end_position = Vector3(0, 70, -300)
	plane_mesh.visible = false
	global_transform.origin = start_position  # Corrected position initialization
	start_flight()  # Start first flight

func _process(delta: float) -> void:
	if flying:
		flight_timer += delta
		var progress = clamp(flight_timer / flight_duration, 0.0, 1.0)
		global_transform.origin = start_position.lerp(end_position, progress)
		
		if progress >= 1.0:
			finish_flight()

func finish_flight():
	flying = false
	flight_timer = 0.0
	plane_mesh.visible = false
	audio_player.stop()
	print("Flight finished. Waiting to restart...")
	await get_tree().create_timer(wait_time).timeout
	start_flight()

func start_flight():
	print("Flight starting...")
	global_transform.origin = start_position
	plane_mesh.visible = true
	flying = true
	flight_timer = 0.0
	audio_player.play()
