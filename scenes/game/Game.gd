# godot 4.3
extends Node

@onready var mainlevel = preload("res://scenes/main/main.tscn")

@onready var levelnode = %Level

func _ready() -> void:
	pass

func start_game():
	# Hide the UI and unpause to start the game.
	%MainMenu.queue_free()
	get_tree().paused = false
	# Only change level on the server.
	# Clients will instantiate the level via the spawner.
	if multiplayer.is_server() and not OS.has_environment("dedicated_server"):
		change_level.call_deferred()

# Call this function deferred and only on the main authority (server).
func change_level():
	# Remove old level if any.
	for child in levelnode.get_children():
		child.queue_free()

	if mainlevel.can_instantiate():
		levelnode.child_entered_tree.connect(_On_LevelEnteredTree)
		var ml = mainlevel.instantiate()
		ml.child_entered_tree.connect(_On_ChildEnteredTree)
		levelnode.call_deferred("add_child", ml)
		await get_tree().process_frame
		#levelnode.add_child().call_deferred()
		#levelnode.get_child(0).child_entered_tree.connect(_On_ChildEnteredTree)


func _On_ChildEnteredTree(node : Node) -> void:
	if node is Node2D:
		print("Game::_On_ChildEnteredTree() => ", node.name)


func _On_LevelEnteredTree(node : Node) -> void: 
	print("Game::_On_LevelEnteredTree() => ", node.name)
	pass
