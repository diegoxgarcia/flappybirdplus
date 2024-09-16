extends ParallaxBackground

var speed = 300

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_base_offset.x -= (speed * delta)
	pass


func _on_player_move(direction):
	if direction == 1:
		scroll_base_offset.x -= 3
	else: 
		scroll_base_offset.x += 3
	pass # Replace with function body.
