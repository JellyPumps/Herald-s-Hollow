extends Node2D

# Ints
var current_level : int = 1

func _ready():
	var level_path : String      = "res://gameplay/scenes/levels/level_"+str(current_level)+".tscn"
	var level      : PackedScene = load(level_path)
	
	var level_instance = level.instance()
	add_child(level_instance)
