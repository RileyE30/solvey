# DO NOT EDIT THIS SCRIPT
# Duplicate this script and attach it to which ever object you
# Wish to turn into an interactable
extends Node

@export var interactable: bool = true

# Runs when the player is looking at the object and
# Pressed the interact button
func execute() -> void:
	print("Executing from " + self.name + "'s script!")
	#Code goes here
	
