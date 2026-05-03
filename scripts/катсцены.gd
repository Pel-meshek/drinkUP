extends Node2D

@onready var score_hud = $"Катсцена"
@onready var soundU = $"ЗвукУспокоения"
@onready var soundY = $"ЗвукУжаса"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	wait_scene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match Global.score:
		0: score_hud.play("0")
		1: score_hud.play("1")
		2: score_hud.play("2")
		-1: score_hud.play("-1")
		-2: score_hud.play("-2")

func wait_scene():
	await get_tree().create_timer(5.0).timeout
	match Global.score:
		0: score_hud.play("0")
		1: score_hud.play("1")
		2: score_hud.play("2")
		-1: score_hud.play("-1")
		-2: score_hud.play("-2")
	match Global.score:
		0: soundY.play()
		1: soundY.play()
		2: soundY.play()
		-1: soundU.play()
		-2: soundU.play()

	get_tree().change_scene_to_file("res://scenes/garage.tscn")
	
