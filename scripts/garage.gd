extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()

	if Global.day == 1:
		$belka.visible = true
		$light.visible = true
		#$Camera2D/Dialogue.visible = true

	if Global.day_increased:
		timestop()

func timestop():
	$belka.visible = true
	$light.visible = true
	$Player.global_position = Vector2(416, 142)
	$Player.rotation_degrees = -90
	$Player.speed = 0
	$Player.rotation_speed = 0
	$Player/AnimatedSprite2D.play("idle")
	$Camera2D/recepts.visible = false
	$Camera2D/UI.visible = false
	$Camera2D/Dialogue.visible = true
	Global.day_increased = false
