extends CharacterBody3D

const SPEED = 5.0
const GRAVITY = 0  

@export var sensitivity = 3000

var is_grounded = false
var fly_direction = Vector3.ZERO

func _physics_process(delta):
	fly_direction = Vector3.ZERO
	if Input.is_action_pressed("Up"):
		fly_direction.y = 1
	elif Input.is_action_pressed("Down"):
		fly_direction.y = -1
	var input_dir = Input.get_vector("Right", "Left", "Back", "Forward")

	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y) + fly_direction).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		velocity.y = direction.y * SPEED 
	else:
		velocity.x = 0
		velocity.y = 0
		velocity.z = 0

	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x/(sensitivity/2)
		$Camera.rotation.x -= event.relative.y/sensitivity
		$Camera.rotation.x = clamp($Camera.rotation.x, deg_to_rad(0), deg_to_rad(90)) 
