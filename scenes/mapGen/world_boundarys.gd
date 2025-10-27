## Sets the World Border Position with the Map Size
class_name WorldBoundarys extends Node2D

## Border Nodes
@export_group("Borders")
## Holds a [StaticBody2D] as the Left Border Node
@export var LeftBorder : StaticBody2D
## Holds a [StaticBody2D] as the Top Border Node
@export var TopBorder : StaticBody2D
## Holds a [StaticBody2D] as the Right Border Node
@export var RightBorder : StaticBody2D
## Holds a [StaticBody2D] as the Bottom Border Node
@export var BottomBorder : StaticBody2D


func _ready() -> void:
	Multihelper.terrain_generated.connect(ResetWorldBorderPositions)
	pass


## Sets the World Border Position with the Map Size [br]
##
## [param maprect] : [Vector2i] Bottom right point from Mapsize[br]
## [param _layer] (unused): Map Layer Index [br]
func ResetWorldBorderPositions(maprect : Vector2i, _layer : int = 0) -> void:
	print("ResetWorldBorderPositions: %s" % [maprect])

	LeftBorder.position.x = 0 #-(maprect.x / 2.0)	#-2000		#Left	+2Tiles
	TopBorder.position.y = 0 #(-maprect.y / 2.0)	#-4400		#Top
	RightBorder.position.x = maprect.x #(maprect.x / 2.0) 	#2000		#Right
	BottomBorder.position.y = maprect.y #(maprect.y / 2.0) 	#4400		#Bottom
	pass
