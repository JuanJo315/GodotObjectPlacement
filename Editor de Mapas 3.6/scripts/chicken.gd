extends Area2D

# Variable to get the chicken's position when initialized 
var start_pos = Vector2(0, 0) 
var init = false 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# We get it's position on the level before it runs 
	if !init: 
		start_pos = global_position
		init = true 
	
	# Once the game mode starts, the chicken runs 
	if GameManager.playing: 
		global_position.x -= 3
	else: 
		# When we exist game mode, the placed chickens 
		# return to their starting position 
		global_position = start_pos
