extends Node
signal item_changed(item_name: String)

var held_item: String = ""

func take_item(name: String):
	held_item = name
	item_changed.emit(held_item) # Оповещаем UI

func drop_item():
	held_item = ""
	item_changed.emit(held_item) # Оповещаем UI
