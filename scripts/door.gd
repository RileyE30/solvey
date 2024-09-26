extends StaticBody3D

@export var connected_button : NodePath

var button
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if connected_button:
		button = get_node(connected_button)
		button.T.connect(_on_button_pressed)
		button.F.connect(_on_button_released)	

func _on_button_pressed():
	open_door()

func _on_button_released():
	close_door()
	
func open_door():
	# Your code to open the door
	$CollisionShape3D.disabled = true
	$MeshInstance3D.visible = false
	print("Open")

func close_door():
	# Your code to close the door
	$CollisionShape3D.disabled = false
	$MeshInstance3D.visible = true
	print("closed")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
