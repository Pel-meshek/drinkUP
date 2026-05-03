extends Node2D

@onready var score_hud = $"Катсцена"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	wait_scene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match Global.score:
		0: score_hud.play("1")
		1: score_hud.play("2")
		2: score_hud.play("3")
		-1: score_hud.play("4")
		-2: score_hud.play("5")

func wait_scene():
	await get_tree().create_timer(5.0).timeout
	get_tree().change_scene_to_file("res://scenes/garage.tscn")
	
