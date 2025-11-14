extends StaticBody2D

#creates a variable window wight: type=int
var win_height : int
#creates a variable paddle height: type=int
var player_p_height : float

#called when the (Player)node enters the scene tree for the first time
func _ready():
	win_height = get_viewport_rect().size.y

#onready allows you to access parent/child nodes/classes
@onready var player_color_rect = $PlayerColorRect
@onready var player_collision_shape = $PlayerCollisionShape2D

#called every frame. 'delta' is the elapsed time since the previous frame
func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		position.y -= get_parent().PADDLE_SPEED * delta
	elif Input.is_action_pressed("ui_down"):
		position.y += get_parent().PADDLE_SPEED * delta
	player_p_height = $PlayerColorRect.get_size().y
	#gets a reference to the player's CollisionShape2D, which is a RectangleShape2D 
	var rect_shape = player_collision_shape.shape as RectangleShape2D
	#sets the height of the collision box to HALF of the visual paddle's height
	#rect_shape.extents.y = HALF of the total height, so if the paddle is 90, half is 45, so now the collision shape matches the height
	rect_shape.extents.y = player_color_rect.size.y / 2.0
	#reassigns the shape, telling Godot to update the physics body with the new shape NOW
	player_collision_shape.shape = rect_shape
	#from var rect_shape down to the last line, these belong in the _physics_process(delta): because the paddle chages every frame and needs to be updated accordingly
	#it's taken out of the func change_Player_paddle_length(): in the game_screen.gd because in there it only runs once, and causes misalignment

	#limit paddle movement to window
	position.y = clamp(position.y, player_p_height / 2, win_height - player_p_height / 2)
