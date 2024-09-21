extends Parallax2D

@onready var floor_2d = $"../Floor2D"
var speed = 300

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_offset.x -= (speed * delta)
	floor_2d.scroll_offset.x -= (speed * delta)
	pass


func _on_player_move(direction):
	if direction == 1:
		scroll_offset.x -= 3
		floor_2d.scroll_offset.x -= 3
	else: 
		scroll_offset.x += 3
		floor_2d.scroll_offset.x += 3
	pass
