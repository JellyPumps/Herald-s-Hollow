extends Node2D

# Ints
var current_level : int = 1

# Objects
@onready var h_box_container : HBoxContainer = $CanvasLayer/Control/VBoxContainer/HBoxContainer
@onready var canvas_layer = $CanvasLayer

# Dictionaries
var weapon_affinity = {
	"[Button:1279]" : "Sword",
	"[Button:1280]" : "Bow",
	"[Button:1281]" : "Sorcery",
	"[Button:1282]" : "Holy"
}

func _ready():
	for btn in h_box_container.get_children():
		btn.connect("pressed", Callable(self, "_on_Affinity_pressed").bind(btn))

func _on_Affinity_pressed(which : Button): 
	var colon_index : int = str(which).find(":")
	if colon_index == -1: return
	var button = str(which).substr(colon_index + 1, str(which).length())
