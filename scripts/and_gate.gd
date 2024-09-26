extends Node

@export var connected_button1 : NodePath
@export var connected_button2 : NodePath

var button1
var button2
signal T
signal F


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if connected_button1 and connected_button2:
		button1 = get_node(connected_button1)
		button2 = get_node(connected_button2)
		button1.T.connect(_on_button_state_changed)
		button1.F.connect(_on_button_state_changed)
		button2.T.connect(_on_button_state_changed)
		button2.F.connect(_on_button_state_changed)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_button_state_changed():
	# Check if both buttons are pressed
	if button1.is_pressed and button2.is_pressed:
		emit_signal("T")
	else:
		emit_signal("F")
