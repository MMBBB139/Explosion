extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$ExplosivesUsed.text = "Explosives used: "+str(Global.bombsUsed)
	$Record.text = "Record: "+ str(Global.recordBombsUsed)
	$AnimationPlayer.play("fade_in")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_button_pressed():
	$AudioStreamPlayer.play()
	$Fader.show()
	$AnimationPlayer.play("fade_out")

func restart():
	Global.bombsUsed = 0
	get_tree().change_scene_to_file("res://main.tscn")
