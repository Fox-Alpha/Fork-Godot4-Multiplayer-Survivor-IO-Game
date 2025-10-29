extends Control

const PLAYER_COLOR := Color(1.0, 0.0, 0.0)   # Red color for player
@export var tile_size: Vector2 = Vector2(3, 3)
@export var player: Node2D

@onready var coordsLabel := $"../../CoordsLabel"
@onready var tile_map = get_node("/root/Game/Level/Main/Map/TileMap")

func _ready():
	if !tile_map:
		push_error("TileMap node not found! Check the path: /root/Game/Level/Main/Map/TileMap")
		return

func _process(_delta):
	queue_redraw()
	pass

func _draw():
	if !tile_map or !tile_map.tile_set:
		return

	if is_instance_valid(player):
		#PlayerGlobalPosition
		var pgp = player.global_position
		#TileSetTileSize
		var tsts = Vector2(tile_map.tile_set.tile_size)
		var PlayerPosToMinimap = pgp / tsts #* tile_size
		var player_rect = Rect2(PlayerPosToMinimap, tile_size)
		draw_rect(player_rect, PLAYER_COLOR)
		coordsLabel.text = str(Vector2i(PlayerPosToMinimap))
	else:
		player = get_node_or_null("../../../../../Players/"+str(multiplayer.get_unique_id()))
