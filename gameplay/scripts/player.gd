extends CharacterBody3D

# Ints
const BASE_SPEED : int = 5
var speed        : int = BASE_SPEED

func _input(event):
	if event is InputEventKey:
		
		if event.is_action("north"):   velocity.z -= 1
		elif event.is_action("south"): velocity.z += 1
		if event.is_action("east"):    velocity.x += 1
		if event.is_action("west"):    velocity.x -= 1

func _physics_process(_delta):
	# Reset the velocity before calculating the new one
	velocity = Vector3.ZERO
	
	# Make sure player movement isn't slow
	velocity = velocity * speed
	
	move_and_slide()
