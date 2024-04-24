extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("fadeIn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	print("button pressed")
	$Fader.show()
	$AudioStreamPlayer.play()
	$AnimationPlayer.play("fadeOut")
	print("playingAnimation")

	
 
func changeScene():
	get_tree().change_scene_to_file("res://source/instructions.tscn")
	

