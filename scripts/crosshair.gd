extends TextureRect


@onready var main_character: CharacterBody3D = $"../../../MainCharacter"

func _ready() -> void:
	self.visible = false

func _physics_process(delta: float) -> void:
	var cast = main_character.get_node("Head/RayCast3D")
	var colliderObject = cast.get_collider()
	self.visible = true if colliderObject and colliderObject.name == "RigidBody3D" else false
