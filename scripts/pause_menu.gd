extends Control

func _ready():
	$AnimationPlayer.play("RESET")
	

func resume():
	get_tree().paused = false
	$AnimationPlayer.play("RESET")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	

func pause():
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$AnimationPlayer.play("blur")
	
	

func testEsc():
	if Input.is_action_just_pressed("pause") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused:
		resume()


func _on_continue_pressed() -> void:
	resume()


func _on_give_up_pressed() -> void:
	get_tree().quit()


func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()

func _process(delta):
	testEsc()
