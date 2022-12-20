extends Spatial

var rotation_amount = 0.0
export (float, 0.05, 1.0) var rotation_speed = 0.09
export var zoom_enabled = false

var lmb = false
var rmb = false
var speed = 0.2
var move = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	rotation_amount = rotation_degrees.y 
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(_delta):
# var forward = transform.basis.z.normalized()*speed
#	if(Input.is_action_pressed("ui_up")):
#		transform.origin -= forward
#	elif(Input.is_action_pressed("ui_down")):
#		transform.origin += forward
#	elif(Input.is_action_pressed("ui_left")):
#		transform.origin += forward.cross(Vector3.UP)/1.5
#	elif(Input.is_action_pressed("ui_right")):
#		transform.origin -= forward.cross(Vector3.UP)/1.5 
#	else:
	rotation_degrees.y = lerp(rotation_degrees.y, rotation_amount, rotation_speed) 

func _unhandled_input(event):
	if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		return
	if event is InputEventMouseButton and zoom_enabled:
		if event.pressed:
			match event.button_index:
				BUTTON_WHEEL_UP:
					if($Camera.size<100):
						$Camera.size += 1
				BUTTON_WHEEL_DOWN:
					if($Camera.size>5):
						$Camera.size -= 1
					
	# Check if LMB is pressed
	if(event.is_action_pressed("left_mouse_button")):
			lmb = true
	elif event.is_action_released("left_mouse_button"):
			lmb  = false
	# Check if RMB is pressed
	if(event.is_action_pressed("right_mouse_button")):
			rmb = true
	elif event.is_action_released("right_mouse_button"):
			rmb  = false
	# Camera Rotation
	if event is InputEventMouseMotion:
		if lmb:
			if event.relative.x != 0:
				pass
				rotation_amount = rotation_degrees.y + event.relative.x *0.8



