extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$ExplosivesUsed.text = "Explosives used: "+str(Global.bombsUsed)
	$Record.text = "Record: "+ str(Global.recordBombsUsed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
