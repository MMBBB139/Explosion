extends Node3D

@export var explosion_force = 200
var items_in_radius : Array
var fixed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	explosion()
	

func _on_area_3d_body_entered(body):
	if body.name != self.name:
		if body is RigidBody3D:
			items_in_radius.append(body)


func _on_area_3d_body_exited(body):
		if body is RigidBody3D:
			items_in_radius.erase(body)

func explosion():
	var force_dir : Vector3
	var random_vector : Vector3
	#Applying the explosion force for every Rigidbody in the array.
	await get_tree().create_timer(5).timeout
	$smoke.emitting = true
	$AnimationPlayer.play("explode")
	$explode.play()
	for j in items_in_radius:
		#Getting a direction vector between the bomb and all nearby RigidBodies. This line of code later helps to calculate a trajectory for the Rigidbodies.
		force_dir = self.position.direction_to(j.position)
		#Generating a position on the object where the force will be applied. This line of code makes the Rigidbodies randomly rotate after the explosion.
		random_vector = Vector3(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1)) * force_dir
		j.apply_impulse(random_vector, force_dir * explosion_force)	
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func fix():
	fixed = true

func setpos(pos):
	if(!fixed):
		global_position = pos

