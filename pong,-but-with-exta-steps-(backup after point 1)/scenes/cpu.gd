extends StaticBody2D

#creates a variable ball_pos: type=vector2
var ball_pos : Vector2
#creates a variable dist: dist=int
var dist : int
#creates a variable move_by: move_by=int
var move_by : int
#creates a variable win_height: win_height=int
var win_height : int
#creates a variable p_height: p_height=int
var cpu_p_height : float

#called when the (CPU)node enters the scene tree for the first time
func _ready():
	win_height = get_viewport_rect().size.y
	#p_height = $ColorRect.get_size().y

#called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta):
	#move paddle towards ball
	ball_pos = $"../Ball".position
	dist = position.y - ball_pos.y
	cpu_p_height = $CPUColorRect.get_size().y

	#print("cpu size: " + str(cpu_p_height))
	
	#if is a check for the distance being greater than the paddle speed * delta
	#else happens if the "if" is false
	#get_parent comes from the GameScreen script(gamescreen=parent)(cpuscript=child of gamescreen)
	if abs(dist) > get_parent().PADDLE_SPEED * delta:
		move_by = get_parent().PADDLE_SPEED * delta * (dist / abs(dist))
	else:
		move_by = dist

	position.y -= move_by
	
	#limit paddle movement to window
	position.y = clamp(position.y, cpu_p_height / 2, win_height - cpu_p_height / 2)
