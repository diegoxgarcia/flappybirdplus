extends Node

const savefile = "user://SAVEFILE.save"

var game_data = {
	"record" : 0
}

# Called when the node enters the scene tree for the first time.
func _ready():
	load_data()
	pass # Replace with function body.

func load_data():
	var file = FileAccess.open(savefile, FileAccess.READ)
	if file == null:
		save_data()
	else:
		game_data = file.get_var()
	file = null

func save_data():
	var file = FileAccess.open(savefile,FileAccess.WRITE)
	file.store_var(game_data)
	file = null # Cierra file
