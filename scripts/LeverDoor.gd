extends StaticBody3D


# Function that is connected to Lever's "toggled" signal
# "toggled" signal passes in the current_state of the lever
func _on_lever_toggled(state: bool) -> void:
	self.visible = not state
