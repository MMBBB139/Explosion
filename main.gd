extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("fadeIn")
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("TestInput"):
		won()


func _on_audio_stream_player_3d_finished():
	$AudioStreamPlayer3D.play();

func won():
	print("won triggered")
	$house.hide()
	$Node3D.hide()
	$house.queue_free()
	$newGrass.show()
	$FlowerCollection.show()
	$AnimationPlayer.play("flowersFadeIn")
	#$AnimationPlayer.play("houseFadeOut")

	#$AnimationPlayer.play("fadeOut")

func switchToWin():
	get_tree().change_scene_to_file("res://win_screen.tscn")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "houseFadesOut":
		$house.queue_free()
		$newGrass.show()
		$FlowerCollection.show()
		$AnimationPlayer.play("flowersFadeIn")
	if anim_name == "flowersFadeIn":
		$Fader.show()
		$AnimationPlayer.play("fadeOut")
		

