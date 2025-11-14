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

#onready allows you to access parent/child nodes/classes
@onready var cpu_color_rect = $CPUColorRect
@onready var cpu_collision_shape = $CPUCollisionShape2D

#called every frame. 'delta' is the elapsed time since the previous frame
func _physics_process(delta):
	#move paddle towards ball
	ball_pos = $"../Ball".position
	dist = position.y - ball_pos.y
	cpu_p_height = $CPUColorRect.get_size().y
	#gets a reference to the CPU's CollisionShape2D, which is a RectangleShape2D
	var rect_shape = cpu_collision_shape.shape as RectangleShape2D
	#sets the height of the collision box to HALF of the visual paddle's height
	#rect_shape.extents.y = HALF of the total height, so if the paddle is 180, half is 90, so now the collision shape matches the height
	rect_shape.extents.y = cpu_color_rect.size.y / 2.0
	#reassigns the shape, telling Godot to update the physics body with the new shape NOW
	cpu_collision_shape.shape = rect_shape
	#from var rect_shape down to the last line, these belong in the _physics_process(delta): because the paddle chages every frame and needs to be updated accordingly
	#it's taken out of the func change_CPU_paddle_length(): in the game_screen.gd because in there it only runs once, and causes misalignment
	
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
