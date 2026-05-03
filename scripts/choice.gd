extends CanvasLayer

var is_кофе_pressed = false
var is_пиво_pressed = false
var is_choice = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
	
func _on_пиво_pressed():
	Global.score += 1
	is_пиво_pressed = true
	is_кофе_pressed = false
	Global.choice1 = "pivo"
	get_tree().change_scene_to_file("res://scenes/катсцены.tscn")
func _on_кофе_pressed():
	Global.score -= 1
	Global.choice1 = "kofe"
	is_кофе_pressed = true
	is_пиво_pressed = false
	get_tree().change_scene_to_file("res://scenes/катсцены.tscn")
	
