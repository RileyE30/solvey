extends TextureRect


@onready var main_character: CharacterBody3D = $"../../../MainCharacter"

func _ready() -> void:
	self.visible = false

func _physics_process(delta: float) -> void:
	var cast = main_character.get_node("Head/RayCast3D")
	var colliderObject = cast.get_collider()
	self.visible = colliderObject and ("interactable" in colliderObject) and colliderObject.interactable
