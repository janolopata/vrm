extends RigidBody3D

class_name Interactable

@export
var indicator_text = "Interact"

func get_indicator_text() -> String:
	var binding: String = ""
	var actions = InputMap.get_actions()
	for action in actions:
		if action == "interact":
			var events = InputMap.action_get_events(action)
			if events.size() > 0:
				var event = events[0]
				if event is InputEventKey:  # If the event is a keyboard key press
					var key_name = event.as_text()  # Get the key as text (e.g., "W", "Up")
				break
				
	if not binding or binding == "":
		return indicator_text
	else:
		return "({0}) {1}".format([binding, indicator_text])
	
func interact(interactor: Interactor) -> void:
	pass
