extends Area2D

@onready var timer = $Timer
@onready var death_sound = $AudioStreamPlayer  # Supondo que você tenha um AudioStreamPlayer na cena

func _on_body_entered(body):
	if body.is_in_group("players"):
		Globais.estado_morte = true
		print("You died!")
		Engine.time_scale = 0.5
		body.get_node("CollisionShape2D").queue_free()
		var musica = get_parent().get_node_or_null("AudioStreamPlayer")
		if musica:
			musica.stop()
		else:
			musica =  get_parent().get_parent().get_node_or_null("AudioStreamPlayer")
			if musica:
				musica.stop() 
		# Reproduz o som de morte
		death_sound.play()
		
		timer.start()
	

func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
