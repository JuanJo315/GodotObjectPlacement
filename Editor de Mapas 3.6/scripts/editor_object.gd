extends Node2D

@onready var level = get_node("/root/main/Level")
@onready var tileMap: TileMap = level.get_node("TileMap")

var can_place = true
var current_item

# So in the File Dialog we can save when it's true 
# and when it's false it will be loading 
var do_save = false

@onready var popup: FileDialog = get_node("/root/main/Item_Selector/FileDialog")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#editor_camera.is_current = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Make the object follor the mouse cursor 
	global_position = get_global_mouse_position()
	
	if !GameManager.place_tile:
		if !GameManager.filesystem_shown: 
			if(current_item != null and can_place and Input.is_action_just_pressed("mouse_left")):
				var new_item = current_item.instantiate()
				level.add_child(new_item)
				new_item.owner = level
				new_item.global_position = get_global_mouse_position()
	else: 
		if can_place:
			if !GameManager.filesystem_shown: 
				if Input.is_action_pressed("mouse_left"):
					place_tile()
				if Input.is_action_pressed("mouse_right"):
					remove_tile()
	
	if Input.is_action_pressed("save"):
		GameManager.filesystem_shown = true
		do_save = true 
		popup.mode = 4
		popup.show()
	if Input.is_action_pressed("load"):
		GameManager.filesystem_shown = true
		do_save = true 
		popup.mode = 0
		popup.show()

func place_tile(): 
	var mouse_pos = tileMap.world_to_map(get_global_mouse_position())
	tileMap.set_cell(mouse_pos.x, mouse_pos.y, GameManager.current_tile)

func remove_tile(): 
	var mouse_pos = tileMap.world_to_map(get_global_mouse_position())
	tileMap.set_cell(mouse_pos.x, mouse_pos.y, -1)


func save_level():
	var toSave: PackedScene = PackedScene.new()
	tileMap.owner = level
	toSave.pack(level)
	#ResourceSaver.save(popup.current_path + ".tscn", toSave)

func load_level():
	var toLoad: PackedScene = PackedScene.new()
	toLoad = ResourceLoader.load(popup.current_path)
	var this_level = toLoad.instantiate()
	get_parent().remove_child(level)
	level.queue_free()
	get_parent().add_child(this_level)
	tileMap = get_parent().get_node("/Level/TileMap")
	level = this_level

func _on_file_dialog_confirmed() -> void:
	if popup.window_title == "Save a File":
		save_level()
	else: 
		load_level()
	pass # Replace with function body.


func _on_file_dialog_visibility_changed() -> void:
	GameManager.filesystem_shown = false
	do_save = false
	pass # Replace with function body.
