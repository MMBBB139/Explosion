extends Node3D

var fixed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func fix():
	fixed = true

func setpos(pos):
	if(!fixed):
		global_position = pos
