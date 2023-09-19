extends KinematicBody2D

# Ints
export (int) var speed = 200

# Arrays
var directions : Array      = ["north", "south", "east", "west"]
var held_directions : Array = []
var walking_audio : Array   = [
	"res://assets/audio/01-footstep.ogg",
	"res://assets/audio/02-footstep.ogg",
	"res://assets/audio/03-footstep.ogg",
	"res://assets/audio/05-footstep.ogg",
	"res://assets/audio/06-footstep.ogg"
]

# String
var current_direction : String = "north"

# Objects
onready var animation_player : AnimationPlayer = $AnimationPlayer
onready var footsteps : AudioStreamPlayer      = $footsteps

# Functions
func get_input():
	for dir in directions:
		var is_pressed = Input.is_action_pressed(dir)
		var direction_idx = held_directions.find(dir)
		
		if direction_idx == -1:
			if is_pressed: held_directions.push_front(dir)
		else:
			if !is_pressed: held_directions.remove(direction_idx)
		
	if held_directions.size() > 0:
		current_direction = held_directions[0]
		var _mas = move_and_slide(get_movement(current_direction))
		animation_player.play("walk_"+current_direction)
	else: 
		animation_player.play("idle")
		current_direction = directions[0]

func _physics_process(_delta):
	get_input()

func get_movement(dir):
	var vectors = {
		"north" : Vector2(0, -speed),
		"south" : Vector2(0,  speed),
		"east"  : Vector2(speed,  0),
		"west"  : Vector2(-speed, 0)
	}
	return vectors[dir]

func footstep():
	randomize()
	walking_audio.shuffle()
	footsteps.stream = load(walking_audio[0])
	footsteps.play()
