extends Node

@export var interactable: bool = true
@export var current_state: bool = false

signal toggled

# Runs when the player is looking at the object and
# Pressed the interact button
func execute() -> void:
	# Get the animation player from the lever
	var animation_player: AnimationPlayer = self.get_node("LeverAnchor/AnimationPlayer")
	
	# If an animation is currently playing, return
	if animation_player.is_playing(): return
	
	# Play the animation according to the state the lever is in
	if not current_state:
		animation_player.play("lever_down") 
	else: 
		animation_player.play_backwards("lever_down")
	# Change the state of the lever
	current_state = not current_state
	# Emit a signal to tell objects listening to this lever
	# That the state of this lever has changed
	# Pass to the listeners the current_state of the lever
	emit_signal("toggled", current_state)
	
