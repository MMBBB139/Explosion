extends Node3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_audio_stream_player_3d_finished():
	$AudioStreamPlayer3D.play();
