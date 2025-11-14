extends Sprite2D

#creates a variable called score: type=array
var score := [0, 0]# 0:Player, 1: CPU 
#const creates constant variable: type=int
const PADDLE_SPEED : int = 500

#spawns new ball when ball timer runs out
func _on_ball_timer_timeout():
	$Ball.new_ball()

#gives point when ball enters left collision shape 2D, displays current score
func _on_score_left_body_entered(body):
	score[1] += 1
	$HUD/CPUScore.text = str(score[1])
	check_score(score)
	$BallTimer.start()

#gives point when ball enters right collision shape 2D, displays current score
func _on_score_right_body_entered(body):
	score[0] += 1
	$HUD/PlayerScore.text = str(score[0])
	check_score(score)
	$BallTimer.start()

#creates a function that checks score
func check_score(scores):
	if score[0] == 7: 
		end_game("Player")
	if score[1] == 7:
		end_game("CPU")
	if score[0] == 1:
		change_CPU_paddle_length()
	if score[0] == 2:
		pass #make player paddle smaller

#onready allows you to access parent/child nodes/classes
@onready var cpu_color_rect = $CPU/CPUColorRect
@onready var cpu_collision_shape = $CPU/CPUCollisionShape2D

func change_CPU_paddle_length():
	if cpu_color_rect.size.y > 120:
		return
	var cpu_node = $CPU
	var current_center_y = cpu_color_rect.position.y + cpu_color_rect.size.y / 2.0 #keeps paddle hitbox inside screen
	cpu_color_rect.size.y = cpu_node.cpu_p_height * 1.5 #changes paddle size
	cpu_color_rect.position.y = current_center_y - cpu_color_rect.size.y / 2.0 #keeps paddle hitbox inside screen
	
	#makes sure ball hits front of paddle and doesn't clip through
	if cpu_collision_shape.shape is RectangleShape2D:
		cpu_collision_shape.shape = cpu_collision_shape.shape

		var rect_shape = cpu_collision_shape.shape as RectangleShape2D
		rect_shape.extents.y += $CPU.cpu_p_height / 2.0
		
	#print("change_CPU_paddle_length func *****RAN*****") 

#changes screen based off winner
func end_game(winner):
	match winner: 
		"Player": 
			get_tree().change_scene_to_file("res://scenes/YouWonEndScreen.tscn")
		"CPU":
			get_tree().change_scene_to_file("res://scenes/YouLostEndScreen.tscn")
