extends Node2D
@onready var cpu_particles_2d = $CPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func start_fire():
	cpu_particles_2d.emitting = true
