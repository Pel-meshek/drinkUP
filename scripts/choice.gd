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
	get_tree().change_scene_to_file("res://scenes/катсцены.tscn")
func _on_кофе_pressed():
	Global.score -= 1
	is_кофе_pressed = true
	is_пиво_pressed = false
	get_tree().change_scene_to_file("res://scenes/катсцены.tscn")
	
func choice():
		if is_кофе_pressed:
			return 9
		else:
			return 0
