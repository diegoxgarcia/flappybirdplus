extends Node2D

var speed : int
var coin = preload("res://Scenes/Objects/coin.tscn")
signal obs_destroyed
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	position.y = randf_range(230.0, 1080.0)
	_coin_creator()

func _coin_creator():
	var new_coin = coin.instantiate()
	new_coin.speed = speed
	new_coin.position.x = 800
	new_coin.position.y = position.y
	get_parent().add_child(new_coin)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= speed * delta
	if position.x <= -100:
		obs_destroyed.emit()
		queue_free()

func _up_and_down_animation():
	$AnimationPlayer.play("up_and_down")

func _on_tube_body_entered(body):
	animation_player.play("shake_tube")
