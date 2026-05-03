extends Node
signal item_changed(item_name: String)
var score = 0
var held_item: String = ""
var day = 1
var day_increased: bool = false
var index = 0
var choice1 = ""

func _process(delta: float) -> void:
	if (score >= 2 and day >= 4):
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	if (score <= -2 and day >= 4):
		get_tree().change_scene_to_file("res://scenes/win.tscn")

func take_item(name: String):
	held_item = name
	item_changed.emit(held_item) # Оповещаем UI

func drop_item():
	held_item = ""
	item_changed.emit(held_item) # Оповещаем UI
