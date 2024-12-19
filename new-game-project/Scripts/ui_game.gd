extends Control

class_name UI_Game

@onready var interact_label: Label = null
@onready var task_label_basketball = $L_basketball  # Reference to the label node displaying the task
@onready var task_label_trash = $L_trash
@onready var task_label_statue = $L_statue
@onready var sound_player2: AudioStreamPlayer = $AudioStreamPlayer

# Define a signal to be emitted when a task is completed
signal task_completed(task_name: String)

func _ready() -> void:
	interact_label = get_node("L_interact") as Label
	if interact_label:
		set_interact_text("")

# Function to update the interact text
func set_interact_text(text: String) -> void:
	if not text or text == "":
		interact_label.visible = false
	else:
		interact_label.text = text
		interact_label.visible = true

# Function to mark the basketball task as complete
func mark_task_done_basketball():
	task_label_basketball.bbcode_text = "[s]" + task_label_basketball.text + "[/s]"  # Apply strikethrough
	emit_signal("task_completed", "basketball")  # Emit signal with task name

# Function to mark the trash task as complete
func mark_task_done_trash():
	task_label_trash.bbcode_text = "[s]" + task_label_trash.text + "[/s]"
	emit_signal("task_completed", "trash")  # Emit signal with task name

# Function to mark the statue task as complete
func mark_task_done_statue():
	task_label_statue.bbcode_text = "[s]" + task_label_statue.text + "[/s]"
	emit_signal("task_completed", "statue")  # Emit signal with task name
