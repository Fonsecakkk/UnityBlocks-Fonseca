extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if %GameManager and body.is_in_group("players"):
		$AudioStreamPlayer2D.play(0)
		%GameManager.respawn_players()
		body.animation.play("death")  # Toca a animação de morte
		
	else:
		print("Erro")
