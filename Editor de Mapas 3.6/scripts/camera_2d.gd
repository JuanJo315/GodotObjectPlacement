extends Camera2D

# Export so the zoom speed can be adjusted through the inspector 
@export var zoomSpeed: float = 10

# Same but with camera movement speed
@export var cameraSpeed: float = 1

# So the zoom feature is smoother 
var zoomTarget: Vector2

# Smoothing the camera 
#var cameraMove: Vector2 = Vector2.ZERO

# Now for the click and drag 
var dragStartMousePos: Vector2 = Vector2.ZERO
var dragStartCameraPos: Vector2 = Vector2.ZERO
var isDragging: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	zoomTarget = zoom
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Zoom(delta)
	SimplePan(delta)
	ClickAndDrag()
	
func Zoom(delta): 
	if !GameManager.filesystem_shown: 
		if Input.is_action_just_pressed("zoom_in"):
			zoomTarget *= 1.1
		
		if Input.is_action_just_pressed("zoom_out"):
			zoomTarget *= 0.9
	
	# Now so the zoom moves gradually to the target  
	zoom = zoom.slerp(zoomTarget, zoomSpeed * delta)

func SimplePan(delta): 
	# We write the variable here because it wouldn't 
	# stop moving if placed outside the function 
	var cameraMove: Vector2 = Vector2.ZERO
	
	if !GameManager.filesystem_shown: 
		if Input.is_action_pressed("KeyW"): 
			# position.y -= 1
			cameraMove.y -= cameraSpeed
		if Input.is_action_pressed("KeyS"): 
			cameraMove.y += cameraSpeed
		if Input.is_action_pressed("KeyA"): 
			cameraMove.x -= cameraSpeed
		if Input.is_action_pressed("KeyD"): 
			cameraMove.x += cameraSpeed 
	
	cameraMove = cameraMove.normalized()
	position += cameraMove * delta * 1000 * (1/zoom.x)

func ClickAndDrag(): 
	if !GameManager.filesystem_shown: 
		if !isDragging and Input.is_action_just_pressed("panoramic"):
			dragStartMousePos = get_viewport().get_mouse_position() 
			dragStartCameraPos = position 
			isDragging = true
		
		if isDragging and Input.is_action_just_released("panoramic"):
			isDragging = false
		
		if isDragging: 
			var moveVector = get_viewport().get_mouse_position() - dragStartMousePos 
			position = dragStartCameraPos - moveVector * (1/zoom.x)
