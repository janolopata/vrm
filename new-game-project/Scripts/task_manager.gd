extends Node

@onready var game_ui: UI_Game = $"/root/Node3D/Player/CameraPivot/Camera3D/GameUI"  # Reference to the UI_Game node
@onready var world_environment: WorldEnvironment = $"/root/Node3D/WorldEnvironment" # Reference to WorldEnvironment node
@onready var sun_light: DirectionalLight3D = $"/root/Node3D/Light/Sun"  # Reference to your DirectionalLight node
@onready var audio_player: AudioStreamPlayer = $"/root/Node3D/Ambience/Ambience_music"

# Export variables for night and day skybox textures
@export var night_skybox: Texture
@export var day_skybox: Texture
@export var night_audio_stream: AudioStream
@export var day_audio_stream: AudioStream

var tasks_completed = 0
var total_tasks = 3  # Adjust according to how many tasks you have

func _ready():
	# Connect the signals from UI_Game
	game_ui.connect("task_completed", Callable(self, "_on_task_completed"))

# This function gets triggered when a task is completed
func _on_task_completed(task_name: String):
	print(task_name + " task completed!")

	# Increment the task completion counter
	tasks_completed += 1
	
	# Check if all tasks are completed
	if tasks_completed == total_tasks:
		change_skybox()

# Function to change the skybox to day
func change_skybox():
	var sky = world_environment.environment.sky.sky_material
	if sky and sky is ShaderMaterial:
		var sky_shader = sky as ShaderMaterial
		sky_shader.set_shader_parameter("source_panorama", night_skybox)
		sun_light.visible = false
		change_audio_stream(night_audio_stream)
	print("All tasks completed! The skybox has been changed to day.")

# Function to change the audio stream
func change_audio_stream(new_stream: AudioStream) -> void:
	if audio_player:
		if new_stream:
			audio_player.stream = new_stream
			audio_player.play()
		else:
			print("Error: New audio stream is null.")
