extends CharacterBody3D

@onready var head: Node3D = $Head
const WALKSPEED = 5.0
const RUNSPEED = 10.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENS = 0.07
# The speed at which the character slows down
# Once all movement keys are released
const LERP_SPEED = 10.0

var mouse_mode = Input.MOUSE_MODE_CAPTURED
var direction = Vector3.ZERO

func _ready() -> void:
	# On Scene ready, lock the mouse to the center of the window
	# To enable "First Person Look Mode"
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every time a key is pressed or the mouse is moved
func _input(event: InputEvent) -> void:
	# If the recieved input is mouse movement and the mouse is locked
	# At the center of the screen
	if (event is InputEventMouseMotion and mouse_mode == Input.MOUSE_MODE_CAPTURED):
		# Rotate the player on the Y Axis (Left and Right)
		rotate_y(deg_to_rad(-event.relative.x * MOUSE_SENS))
		# Rotate player on the X Axis (Up and Down)
		head.rotate_x(deg_to_rad(-event.relative.y * MOUSE_SENS))
		# Clamp the up and down values to ensure that the camera stays
		# Between 90 degrees and -90 degrees
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))


func _process(delta: float) -> void:
	# When the "Esc" key is pressed
	if (Input.is_action_just_pressed("ui_cancel")):
		# Toggle mouse capture mode
		if (mouse_mode == Input.MOUSE_MODE_CAPTURED):
			mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			mouse_mode = Input.MOUSE_MODE_CAPTURED
		Input.set_mouse_mode(mouse_mode)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Determine if the player is running.
	var is_running = Input.is_action_pressed("run")
	
	# Set speed based on running or walking.
	var current_speed = RUNSPEED if is_running else WALKSPEED
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var input_dir := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	)
	# Linear Interpolate the movement -- creates a more smooth feel for movement
	direction = lerp(direction, (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(), delta * LERP_SPEED)
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()
