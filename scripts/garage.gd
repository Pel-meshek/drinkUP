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
		#$Camera2D/Dialogue.visible = true
	if Global.day_increased:
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
	if Global.day == 2:
		if is_instance_valid(dialogue):
			dialogue.visible = true
	if Global.day == 3 and Global.choice1 == "pivo":
		if is_instance_valid($Camera2D/Dialoguepivo) and is_instance_valid($Camera2D/Dialoguepivo):
			$Camera2D/Dialoguepivo.visible = true
			$Camera2D/Dialoguekofe.visible = false
	if Global.day == 3 and Global.choice1 == "kofe":
		if is_instance_valid($Camera2D/Dialoguepivo) and is_instance_valid($Camera2D/Dialoguekofe):
			$Camera2D/Dialoguekofe.visible = true
			$Camera2D/Dialoguepivo.visible = false
	if Global.day >= 4 and Global.choice1 == "pivo":
		if is_instance_valid($Camera2D/Dialoguepivo2) and is_instance_valid($Camera2D/Dialoguekofe2):
			$Camera2D/Dialoguepivo2.visible = true
			$Camera2D/Dialoguekofe2.visible = false
	if Global.day >= 4 and Global.choice1 == "kofe":
		if is_instance_valid($Camera2D/Dialoguepivo2) and is_instance_valid($Camera2D/Dialoguekofe2):
			$Camera2D/Dialoguekofe2.visible = true
			$Camera2D/Dialoguepivo2.visible = false
