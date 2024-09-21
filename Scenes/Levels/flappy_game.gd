extends Node

const BACKGROUND_NIGHT = preload("res://flappy-bird-assets/sprites/background-night.png")
const PIPE_RED = preload("res://flappy-bird-assets/sprites/pipe-red.png")
const PIPE_GREEN = preload("res://flappy-bird-assets/sprites/pipe-green.png")
var obstacle = preload("res://Scenes/Objects/obstacle.tscn")
var pipe
var velocity_obs_difficult = 400
var upgrade_difficult_emitted = false
@onready var player = $Player
@onready var gameover = $UIGame/Gameover
@onready var live_progress_bar = $UIStatus/LiveProgressBar
@onready var score_label = $UIStatus/ScoreLabel
@onready var record_label = $UIStatus/RecordLabel
@onready var create_obstacles_timer = $CreateObstaclesTimer
@onready var ui_game = $UIGame
@onready var die_audio_stream_player = $DieAudioStreamPlayer
@onready var point_audio_stream_player = $PointAudioStreamPlayer
@onready var bkgr_sprite_2d = $Background2D/BkgrSprite2D
@onready var background_2d = $Background2D

func _ready():
	ui_game.hide()
	record_label.text = "Record: " + str(Save.game_data.record)
	pipe = PIPE_GREEN
	live_progress_bar.value = player.live
	player.update_score.connect(_on_update_score)
	player.update_live.connect(_on_update_live)
	player.upgrade_difficult.connect(_upgrade_difficult)

func _on_create_obstacles_timer_timeout():
	var obs = obstacle.instantiate()
	obs.speed = velocity_obs_difficult
	obs.get_child(0).get_child(0).texture = pipe
	obs.get_child(1).get_child(0).texture = pipe
	obs.position.x = 800
	obs.obs_destroyed.connect(_on_obs_destroyed)
	if upgrade_difficult_emitted:
		obs._up_and_down_animation()
	add_child(obs)
	
func _on_obs_destroyed():
	randomize()
	var rand_time = randf_range(2.0,6.0)
	create_obstacles_timer.wait_time = rand_time
	
func _on_update_score(score):
	point_audio_stream_player.play()
	_save_record(score)
	score_label.text = str(score)
	
func _upgrade_difficult():
	bkgr_sprite_2d.texture = BACKGROUND_NIGHT
	velocity_obs_difficult = 550
	background_2d.speed = 400
	pipe = PIPE_RED
	upgrade_difficult_emitted = true
		
func _save_record(score : int):
	if Save.game_data.record < score:
		Save.game_data.record = score
		Save.save_data()

func _on_update_live(live):
	live_progress_bar.value = live
	if live <= 0:
		player._start_player_dead_animation()
		get_tree().paused = true
		gameover.show()
		ui_game.show()
	else:
		player._start_player_hit_animation()
