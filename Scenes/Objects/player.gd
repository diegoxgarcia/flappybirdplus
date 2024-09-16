extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const DIFFICULT_LIMIT = 120
var score : int = 0
var live : int = 100
@onready var flap_audio_stream_player = $FlapAudioStreamPlayer
@onready var fire = $fire
@onready var animation_player = $AnimationPlayer

signal move
signal update_score(int)
signal update_live(int)
signal upgrade_difficult

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.play("flap_fat")
		flap_audio_stream_player.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		#move.emit(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_damager_player_damaged(damageValue):
	live -= damageValue
	if live <= 0: 
		fire.start_fire()
	update_live.emit(live)
	
func _on_collecter_player_collected(area):
	area.queue_free()
	score += 10
	update_score.emit(score)
	if score == DIFFICULT_LIMIT:
		upgrade_difficult.emit()
	
func _start_player_hit_animation():
	animation_player.play("player_hit")
	
func _start_player_dead_animation():
	animation_player.play("player_dead")
	
func _start_vibrate_joystick():
	Input.start_joy_vibration(0,0.5,0.5,0.5)
	
func _start_vibrate_dead_joystick():
	Input.start_joy_vibration(0,0.8,0.8,1)
