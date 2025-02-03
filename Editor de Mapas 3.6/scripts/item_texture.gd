extends TextureRect

@onready var object_cursor = get_node("/root/main/Editor_Object")
@onready var cursor_sprite = object_cursor.get_node("Sprite2D")

@export var this_scene: PackedScene
@export var tile: bool = false 
@export var tileID: int = 0 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.gui_input.connect(self._item_clicked) 

# Event is for passing an argument
func _item_clicked(event): 
	if(event is InputEvent):
		if(!tile): 
			if(event.is_action_released("mouse_left")):
				object_cursor.current_item = this_scene
				cursor_sprite.texture = texture
				GameManager.place_tile = false
			elif(event.is_action_released("mouse_right")):
				object_cursor.current_item = null
				cursor_sprite.texture = null
				GameManager.place_tile = true
				GameManager.current_tile = tileID
		pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
