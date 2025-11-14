extends CharacterBody2D

#creates a variable called win_size: tpye=vector2
var win_size : Vector2
#creates a constant ball starting speed: type=int
const START_SPEED : int = 500
#creates a constant ball acceleration speed: type=int
const ACCEL : int = 50
#creates a variable speed: type=int
var speed : int
#creates a variable direction: type=vector2
var dir : Vector2
#creates a constant max y vector: type=float
const MAX_Y_VECTOR : float = 0.6

#called when the (ball)node enters the scene tree for the first time
func _ready():
	win_size = get_viewport_rect().size

#creates a new ball
func new_ball():
	#randomize start position and direction
	position.x = win_size.x / 2
	position.y = randi_range(200, win_size.y - 200)
	speed = START_SPEED
	dir = random_direction()


#called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision = move_and_collide(dir * speed * delta)
	var collider
	if collision:
		collider = collision.get_collider()
		#if ball hits paddle
		if collider == $"../Player" or collider == $"../CPU":
			speed += ACCEL
			dir = new_direction(collider)
		#if it hits a wall
		else:
			dir = dir.bounce(collision.get_normal())

#ball is bounced towards random angle off spawn
func random_direction():
	var new_dir := Vector2()
	new_dir.x = [1, -1].pick_random()
	new_dir.y = randf_range(-1, 1)
	return new_dir.normalized()

#ball is bounced towards random angle based off of ball on paddle location
func new_direction(collider):
	var ball_y = position.y
	var pad_y = collider.position.y
	var dist = ball_y - pad_y
	var new_dir := Vector2()
	
	#flip the horizontal direction
	if dir.x > 0:
		new_dir.x = -1
	else:
		new_dir.x = 1
	if collider == $"../Player":
		new_dir.y = (dist / (collider.player_p_height / 2)) * MAX_Y_VECTOR
	if collider == $"../CPU":
		new_dir.y = (dist / (collider.cpu_p_height / 2)) * MAX_Y_VECTOR
	return new_dir.normalized()
	
