extends Sprite2D
	
func _input(event):
	if Input.is_action_just_pressed("ui_accept") and get_tree().paused:
		get_tree().paused = false
		$"..".hide()
		get_tree().reload_current_scene()
