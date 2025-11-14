extends Sprite2D

#creates a variable called score: type=array
var score := [0, 0]# 0:Player, 1: CPU 
#const creates constant variable: type=int
const PADDLE_SPEED : int = 500

#spawns new ball when ball timer runs out
func _on_ball_timer_timeout():
	$Ball.new_ball()

#gives point when ball enters left collision shape 2D, displays current score
func _on_score_left_body_entered(_body):
	score[1] += 1
	$HUD/CPUScore.text = str(score[1])
	check_score(score)
	$BallTimer.start()

#gives point when ball enters right collision shape 2D, displays current score
func _on_score_right_body_entered(_body):
	score[0] += 1
	$HUD/PlayerScore.text = str(score[0])
	check_score(score)
	$BallTimer.start()

#creates a function that checks score
func check_score(_scores):
	if score[0] == 7: 
		end_game("Player")
	if score[1] == 7:
		end_game("CPU")
	if score[0] == 1:
		change_CPU_paddle_length()
	if score[0] == 2:
		change_Player_paddle_length()
	if score[0] == 3:
		pass

#onready allows you to access parent/child nodes/classes
@onready var cpu_color_rect = $CPU/CPUColorRect
@onready var cpu_collision_shape = $CPU/CPUCollisionShape2D

func change_CPU_paddle_length():
	if cpu_color_rect.size.y > 120:
		return
	var cpu_node = $CPU
	var current_center_y = cpu_color_rect.position.y + cpu_color_rect.size.y / 2.0 #keeps top paddle hitbox inside screen
	cpu_color_rect.size.y = cpu_node.cpu_p_height * 1.5 #changes paddle size
	cpu_color_rect.position.y = current_center_y - cpu_color_rect.size.y / 2.0 #keeps bottom paddle hitbox inside screen
	
	#makes sure ball hits front of paddle and doesn't clip through
	if cpu_collision_shape.shape is RectangleShape2D:
		cpu_collision_shape.shape = cpu_collision_shape.shape

#constantly checks the y height of the cpu paddle***
#func _process(delta):
	#var color_rect = $CPU/CPUColorRect
	#if color_rect:
		#print("ColorRect height: ", color_rect.size.y)

#onready allows you to access parent/child nodes/classes
@onready var player_color_rect = $Player/PlayerColorRect
@onready var player_collision_shape = $Player/PlayerCollisionShape2D

func change_Player_paddle_length():
	if player_color_rect.size.y > 120 or player_color_rect.size.y == 90:
		return
	var player_node = $Player
	var current_center_y = player_color_rect.position.y + player_color_rect.size.y / 2.0
	player_color_rect.size.y = player_node.player_p_height * .75
	player_color_rect.position.y = current_center_y - player_color_rect.size.y / 2.0
	
	if player_collision_shape.shape is RectangleShape2D:
		player_collision_shape.shape = player_collision_shape.shape

#constantly checks the y height of the player paddle***
#func _process(delta):
	#var color_rect = $Player/PlayerColorRect
	#if color_rect:
		#print("ColorRect height: ", color_rect.size.y)

#changes screen based off winner
func end_game(winner):
	match winner: 
		"Player": 
			get_tree().change_scene_to_file("res://scenes/YouWonEndScreen.tscn")
		"CPU":
			get_tree().change_scene_to_file("res://scenes/YouLostEndScreen.tscn")
