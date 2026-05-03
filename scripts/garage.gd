extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera2D/UI.start_day_timer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
	if Global.day == 1:
		$belka.visible = true
		$light.visible = true
		$Camera2D/Dialogue.visible = true
