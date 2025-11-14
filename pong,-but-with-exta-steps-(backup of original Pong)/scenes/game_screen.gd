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
#add potential round changes here for idea*
func check_score(scores):
	if score[0] == 7: 
		end_game("Player")
	if score[1] == 7:
		end_game("CPU")
	
#changes screen based off winner
func end_game(winner):
	match winner: 
		"Player": 
			get_tree().change_scene_to_file("res://scenes/YouWonEndScreen.tscn")
		"CPU":
			get_tree().change_scene_to_file("res://scenes/YouLostEndScreen.tscn")
