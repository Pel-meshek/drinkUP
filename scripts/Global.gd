extends Node
signal item_changed(item_name: String)
var score = 0
var held_item: String = "Готовый Летний блонд"
var day = 1
var day_increased: bool = false
var index = 0


func take_item(name: String):
	held_item = name
	item_changed.emit(held_item) # Оповещаем UI

func drop_item():
	held_item = ""
	item_changed.emit(held_item) # Оповещаем UI
