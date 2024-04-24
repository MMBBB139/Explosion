extends Node3D

var structure : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

func _on_area_3d_body_entered(body):
	if body.name != self.name:
		if body is RigidBody3D:
			structure.append(body)


func _on_area_3d_body_exited(body):
		if body is RigidBody3D:
			structure.erase(body)
	
func _process(delta):  # Continuously check for empty array (optional)
	if structure.size() == 0:
		get_tree().change_scene_to_file("res://source/win_screen.tscn")
