extends StaticBody2D

@onready var timer_label = $StolTimerLabel
var is_active = false
var progress = 0.0
const TIME = 5.0
var is_playing_sound = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer_label.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_active or not Input.is_action_pressed("interact"):
		progress = 0.0
		timer_label.visible = false
		if is_playing_sound:
			$AudioStreamPlayer2D.stop()
			is_playing_sound = false
		return
	if not is_playing_sound:
		$AudioStreamPlayer2D.play()
		is_playing_sound = true
	progress += delta
	timer_label.visible = true
	timer_label.text = "%.1f" % (TIME - progress)
	
	if progress >= TIME:
		$AudioStreamPlayer2D.stop()
		is_playing_sound = false
		timer_label.visible = false
		progress = 0.0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_active = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_active = false
