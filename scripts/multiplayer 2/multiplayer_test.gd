extends Node2D
 
var peer = ENetMultiplayerPeer.new()
@export var player_scene: PackedScene
 
 
func _on_host_pressed():
	peer.create_server(135)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_player)
	_add_player()
	#get_tree().change_scene_to_file("res://scenes/world_multiplayer.tscn")  # Muda para a cena desejada

 
func _add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child",player)
 
 
func _on_join_pressed():
	peer.create_client("localhost", 135)
	multiplayer.multiplayer_peer = peer
