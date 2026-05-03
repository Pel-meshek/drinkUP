extends CanvasLayer

var is_кофе_pressed = false
var is_пиво_pressed = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
	
func _on_пиво_pressed():
	Global.score += 1
	is_пиво_pressed = true
	is_кофе_pressed = false
	
func _on_кофе_pressed():
	Global.score -= 1
	is_кофе_pressed = true
	is_пиво_pressed = false
	
func choice():
	if is_кофе_pressed or is_пиво_pressed:
		if Global.score == -1:
			$"Катсцена".play("-1")
		if Global.score == -2:
			$"Катсцена".play("-2")
		get_tree().change_scene_to_file("res://scenes/катсцены.tscn")
