extends Node3D

const RAY_LENGTH = 1000
var bomb_scene = preload("res://source/bomb.tscn")
var bomb
var bombs = []
var bombsplaced = 0
var is_ready = true
signal bomb_placed
	
func _ready():
	randomize()
	$AnimationPlayer.play("fadeIn")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("TestInput"):
		won()
	if Input.is_action_pressed("placebomb"):
		if !bomb:
			bomb = bomb_scene.instantiate()
			add_child(bomb)
			bombs.append(bomb)
		var space_state = get_world_3d().direct_space_state
		var mousepos = get_viewport().get_mouse_position()
		var camera = $"CharacterBody3D/Camera/Camera3D"
		var from = camera.project_ray_origin(mousepos)
		var to = from + camera.project_ray_normal(mousepos) * RAY_LENGTH
		
		var query = PhysicsRayQueryParameters3D.create(from, to)
		var result = space_state.intersect_ray(query)
		if "position" in result:
			bomb.set_position(result["position"]+Vector3(0,0,0))
		if Input.is_action_just_released("actuallyplacebomb"):
			bomb.fix()
			bomb = null
			bombsplaced += 1
			is_ready = false
			$"BombsPlacedIndicator/Label".text = str("Bombs Placed: ") + str(bombsplaced)
	

func _on_audio_stream_player_3d_finished():
	$AudioStreamPlayer3D.play();

func won():
	print("won triggered")
	$house.hide()
	$Win.hide()
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
