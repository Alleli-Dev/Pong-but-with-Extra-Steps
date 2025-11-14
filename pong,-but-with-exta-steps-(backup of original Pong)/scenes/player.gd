extends StaticBody2D

#creates a variable window wight: type=int
var win_height : int
#creates a variable paddle height: type=int
var p_height : int

#called when the (Player)node enters the scene tree for the first time
func _ready():
	win_height = get_viewport_rect().size.y
	p_height = $ColorRect.get_size().y

#called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta):
	if Input.is_action_pressed("ui_up"):
		position.y -= get_parent().PADDLE_SPEED * delta
	elif Input.is_action_pressed("ui_down"):
		position.y += get_parent().PADDLE_SPEED * delta

	#limit paddle movement to window
	position.y = clamp(position.y, p_height / 2, win_height - p_height / 2)
