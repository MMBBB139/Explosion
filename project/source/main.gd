extends Node3D

const RAY_LENGTH = 69
@export var bomb_scene: PackedScene
var bomb
var bombs = []
var bombsplaced = 0
var is_ready = true
@onready var cooldown_timer = $CD
signal bomb_placed

func _on_cooldown_timer_timeout():
	is_ready = true 
	
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !bomb:
		bomb = bomb_scene.instantiate()
		add_child(bomb)
		bombs.append(bomb)
		print("instantiated")
	if Input.is_action_pressed("placebomb"):
		print(get_viewport().get_mouse_position())
		var space_state = get_world_3d().direct_space_state
		var mousepos = get_viewport().get_mouse_position()
		var camera = $"CharacterBody3D/Camera/Camera3D"
		var from = camera.project_ray_origin(mousepos)
		var to = from + camera.project_ray_normal(mousepos) * RAY_LENGTH
		
		var query = PhysicsRayQueryParameters3D.create(from, to)
		var result = space_state.intersect_ray(query)
		if "position" in result:
			print(result["position"])
			bomb.set_position(result["position"]+Vector3(0,5,0))
			print(bomb.global_position)
		if Input.is_action_pressed("actuallyplacebomb") and is_ready:
			bomb.fix()
			bomb = null
			print(!bomb)
			bombsplaced += 1
			is_ready = false
			cooldown_timer.start()
			$"BombsPlacedIndicator/Label".text = str("Bombs Placed: ") + str(bombsplaced)
	

func _on_audio_stream_player_3d_finished():
	$AudioStreamPlayer3D.play();
