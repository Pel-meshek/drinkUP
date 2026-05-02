extends HBoxContainer

signal complete_pressed

@onready var name_label = $Label
@onready var qty_label = $Label2
@onready var btn = $Button

func set_data(item: String, qty: int):
	name_label.text = item
	qty_label.text = "x" + str(qty)

func _on_complete_button_pressed():
	complete_pressed.emit()
