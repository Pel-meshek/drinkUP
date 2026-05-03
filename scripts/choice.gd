extends CanvasLayer

var is_кофе_pressed = false
var is_пиво_pressed = false
var is_choice = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if is_choice:
		await is_кофе_pressed or is_пиво_pressed
		if is_кофе_pressed:
			Global.index += 14
		else:
			Global.index += 5 
	
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
	
