extends Node2D

func _ready() -> void:
	$AudioStreamPlayer2D.play()
	
func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer2d.play()
