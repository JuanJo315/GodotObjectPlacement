extends TabContainer

@onready var object_cursor = get_node("/root/main/Editor_Object")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !GameManager.filesystem_shown: 
		if Input.is_action_just_pressed("toggle_editor"): 
			GameManager.playing = !GameManager.playing 
			visible = !GameManager.playing 

#Doesn't work, so we go and change item_texture.gd
# Got fixed by doing this on the scroll container 
# Control + K can be used to comment multiple lines 
#func _on_mouse_entered():
	#object_cursor.can_place = false
	#object_cursor.hide()
#
#func _on_mouse_exited():
	#object_cursor.can_place = true
	#object_cursor.show()
