extends StaticBody3D

var button_push_distance = 2.0
@export var period : float = 5.0
signal T
signal F
var time
var is_pressed = false

@onready var player = get_parent().get_node("MainCharacter")
func _ready():
	time = $Timer
	time.timeout.connect(_on_timeout)

func _process(delta):
	if player:
		# Calculate the distance between player and door
		var distance_to_player = global_transform.origin.distance_to(player.global_transform.origin)
		
		# Check if the player is within the required distance
		if distance_to_player <= button_push_distance:
			if Input.is_action_pressed("interact"):
				if not is_pressed:
					is_pressed = true
					time.wait_time = period
					time.start()
					emit_signal("T")
					# Optional: Animate the button being pressed down
					_animate_button(true)
					print("Pushed")
func _on_timeout():
	is_pressed = false
	emit_signal("F")
	print("released")

			
# Optional function for visual feedback
func _animate_button(pressed):
	#if pressed:
		## Move the button down or change its color
		#$Area3D/MeshInstance3D.translate(Vector3(0, -0.1, 0))
	#else:
		## Reset the button's position or color
		#$Area3D/MeshInstance3D.translate(Vector3(0, 0.1, 0))
	pass
