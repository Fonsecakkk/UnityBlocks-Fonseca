extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tela_inicio_local.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/controls_screen.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
