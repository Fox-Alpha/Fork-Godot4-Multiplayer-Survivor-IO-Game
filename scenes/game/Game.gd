# godot 4.3
extends Node

func _ready() -> void:
	pass

func start_game():
	# Hide the UI and unpause to start the game.
	%MainMenu.queue_free()
	get_tree().paused = false
	# Only change level on the server.
	# Clients will instantiate the level via the spawner.
	if multiplayer.is_server() and not OS.has_environment("dedicated_server"):
		change_level.call_deferred(load("res://scenes/main/main.tscn"))

# Call this function deferred and only on the main authority (server).
func change_level(scene: PackedScene):
	# Remove old level if any.
	var level = %Level
	for c in level.get_children():
		level.remove_child(c)
		c.queue_free()
	var s = scene.instantiate()
	s.child_entered_tree.connect(_On_ChildEnteredTree)
	# Add new level.
	level.add_child(s)


func _On_ChildEnteredTree(node : Node) -> void:
	print("Game::_On_ChildEnteredTree() => ", node.name)
