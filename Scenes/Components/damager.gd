extends Area2D

signal player_damaged

# TODO para cuando un enemigo de tipo body lo alcanza, se emite
# con un valor de daño
func _on_body_entered(body):
	player_damaged.emit(5)

# TODO cuando una tuberia entra emite un daño con un valor
func _on_area_entered(area):
	player_damaged.emit(10)
