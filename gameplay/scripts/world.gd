extends Node2D

# Ints
var current_level : int = 1

# Objects
@onready var h_box_container : HBoxContainer = $CanvasLayer/Control/VBoxContainer/HBoxContainer
@onready var canvas_layer = $CanvasLayer

# Arrays
var delimiters = [":",";"]

func _ready():
	for btn in h_box_container.get_children():
		btn.connect("pressed", Callable(self, "set_affinity").bind(btn))

func set_affinity(button_id : Button):
	var id : String = split_button_id(str(button_id), delimiters[0])
	
	# Set affinity here
	print(id)
	
	# Disconnect signal
	button_id.disconnect("pressed", Callable(self, "set_affinity").bind(button_id))
	
	# Disable canvas layer after selection
	canvas_layer.visible = false
	
	return

func split_button_id(subject_id : String, delimiter : String):
	return subject_id.rsplit(delimiter, true, 1)[0]
