extends Node2D

@onready var dialogue = $Camera2D/Dialogue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player/"Звук прихода белки".stop()
	$"ГрустныйСаунд".play()
	if Global.score < 0:
		$"ГрустныйСаунд".stop()
		$"Основной трек".play()
	else:
		$"ГрустныйСаунд".play()
		$"Основной трек".stop()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()

	if Global.day == 1 or Global.day == 4:
		$belka.visible = false
		$light.visible = false
		#$Camera2D/Dialogue.visible = true
	if Global.day_increased :
		$Player/"Звук прихода белки".play()
		timestop()

func timestop():


	$"ГрустныйСаунд".stop()
	$"Основной трек".stop()
	$belka.visible = true
	$light.visible = true
	$Player.global_position = Vector2(416, 142)
	$Player.rotation_degrees = -90
	$Player.speed = 0
	$Player.rotation_speed = 0
	$Camera2D/recepts.visible = false
	$Camera2D/UI.visible = false
	$Camera2D/UI.cutscene = true
	$Camera2D/UI.update_time_display()
	Global.day_increased = false
	if is_instance_valid(dialogue):
		dialogue.visible = true
