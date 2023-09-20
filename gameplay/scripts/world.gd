extends Node2D

# Ints
var current_level : int = 1

# Objects
onready var h_box_container : HBoxContainer = $CanvasLayer/Control/VBoxContainer/HBoxContainer
onready var canvas_layer = $CanvasLayer

# Dictionaries
var weapon_affinity = {
	"[Button:1279]" : "Sword",
	"[Button:1280]" : "Bow",
	"[Button:1281]" : "Sorcery",
	"[Button:1282]" : "Holy"
}

func _ready():
	for btn in h_box_container.get_children():
		btn.connect("pressed", self, "_on_Affinity_pressed", [btn])

func _on_Affinity_pressed(which : Button): 
	var colon_index : int = str(which).find(":")
	if colon_index == -1: return
	var button = str(which).substr(colon_index + 1, str(which).length())
	
	canvas_layer.visible = false
	load_level()
	
	var player = get_node("level/player")
	player.affinity = weapon_affinity[button]
	
	print(player.affinity)

func load_level():
	var level_path : String      = "res://gameplay/scenes/levels/level_"+str(current_level)+".tscn"
	var level      : PackedScene = load(level_path)
	
	var level_instance = level.instance()
	add_child(level_instance)
