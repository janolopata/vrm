extends Camera3D

class_name Interactor

@onready var sound_player: AudioStreamPlayer = $AudioStreamPlayer

@export
var distance = 3

var in_intersection: Interactable = null
var in_holding: Holdable = null

var player: Player = null
var hand: Node3D = null

func _ready() -> void:
	player = get_parent().get_parent() as Player
	hand = get_node("../Hand") as Node3D
	if not player:
		print("Player not found")
	if not hand:
		print("Hand not found")


func _process(_delta: float) -> void:
	var intersecting = ray_intersect()
		
	if intersecting && not in_intersection:
		set_in_intersection(intersecting)
	elif not intersecting && in_intersection:
		set_in_intersection(null)
	
	if Input.is_action_just_pressed("interact") && in_intersection:
		in_intersection.interact(self)
	if Input.is_action_just_pressed("throw") && in_holding is Throwable:
		sound_player.play()
		(in_holding as Throwable).throw()
			

func ray_intersect() -> Interactable:
	var from = global_transform.origin
	var to = from - global_basis.z.normalized() * distance
	
	#print("From: {0}, To: {1}".format([from, to]))
	# Create a PhysicsRayQueryParameters3D instance
	var ray_params = PhysicsRayQueryParameters3D.new()
	ray_params.from = from
	ray_params.to = to
	ray_params.exclude = [self]
	
	# Perform the raycast
	var space_state = get_world_3d().direct_space_state
	var result = space_state.intersect_ray(ray_params)
	
	# Return the result (an empty dictionary if no collision)
	if result:
		return result["collider"] as Interactable
	return null

func set_in_intersection(interactable: Interactable) -> void:
	if in_intersection:
		player.ui.set_interact_text("")
	in_intersection = interactable
	if in_intersection:	
		player.ui.set_interact_text(in_intersection.get_indicator_text())
