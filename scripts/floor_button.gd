extends Area3D

signal T
signal F

var is_pressed = false

func _ready():
	$Area3D.body_entered.connect(_on_body_entered)
	$Area3D.body_exited.connect(_on_body_exited)

	
func _on_body_entered(body):
	if not is_pressed:
		is_pressed = true
		emit_signal("T")
		# Optional: Animate the button being pressed down
		_animate_button(true)
		print("Pushed")

func _on_body_exited(body):
	# Check if there are still bodies on the button
	if $Area3D.get_overlapping_bodies().size() == 0:
		is_pressed = false
		emit_signal("F")
		# Optional: Animate the button returning to original position
		_animate_button(false)
		print("Released")

# Optional function for visual feedback
func _animate_button(pressed):
	if pressed:
		# Move the button down or change its color
		$Area3D/MeshInstance3D.translate(Vector3(0, -0.1, 0))
	else:
		# Reset the button's position or color
		$Area3D/MeshInstance3D.translate(Vector3(0, 0.1, 0))
