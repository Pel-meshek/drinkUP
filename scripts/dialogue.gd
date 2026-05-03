extends CanvasLayer

var current_index: int = 0
var is_typing: bool = false
@export var text_speed: float = 0.05
@export_file("*.json") var dialog_file: String = "res://assets/Dialog.json"
var dialog_data: Array = []

# Ссылки на узлы UI
@onready var name_label = $NinePatchRect/Name
@onready var message_label = $NinePatchRect/Message
@onready var choice_node = $"../Choice"

func _ready() -> void:
	# Проверка, нашли ли мы узлы
	if not name_label or not message_label:
		push_error("Ошибка: Не найдены узлы Name или Message внутри NinePatchRect!")
		queue_free()
		return
		
	dialog_data = load_dialog()
	
	if dialog_data.is_empty():
		print("Диалоги не загружены или файл пуст.")
		queue_free()
		return
	
	# 1. Загружаем индекс из глобальной переменной
	current_index = Global.index
	
	# 2. ВАЖНО: Передаем current_index, а не 0!
	update_dialog(current_index) 

func update_dialog(index: int):
	# Защита от выхода за пределы массива
	if index >= dialog_data.size():
		queue_free()
		return
		
	var current_line = dialog_data[index]
	
	# Проверяем, есть ли поле "name"
	if current_line.has("name"):
		name_label.text = current_line["name"]
	else:
		name_label.text = "" 
		
	# Запускам печать текста
	type_text(current_line["text"])

func load_dialog() -> Array:
	if FileAccess.file_exists(dialog_file):
		var file = FileAccess.open(dialog_file, FileAccess.READ)
		var content = file.get_as_text()
		var result = JSON.parse_string(content)
		if result is Array:
			return result
		else:
			push_error("Ошибка JSON: Ожидался массив, получено: " + str(result))
			return []
	return []


func type_text(new_text: String):
	if is_typing:
		return
	
	is_typing = true
	message_label.text = ""
	
	for char in new_text:
		# Если игрок нажал пробел во время печати, прерываем цикл
		if not is_typing:
			break
			
		message_label.text += char
		await get_tree().create_timer(text_speed).timeout
	
	is_typing = false

func _input(event: InputEvent):
	if event is InputEventKey and event.keycode == KEY_SPACE and event.pressed and not event.echo:
		if is_typing:
			# Мгновенное завершение печати
			is_typing = false
			# Достаем полный текст из текущей строки
			if current_index < dialog_data.size():
				message_label.text = dialog_data[current_index]["text"]
		else:
			# Переход к следующему диалогу
			current_index += 1
			
			# Пример логики для выбора (раскомментируйте и настройте под себя)
			if current_index == 5: 
				if is_instance_valid(choice_node):
					choice_node.visible = true
					Choice.is_choice = true
					Global.day = 2
					print(Global.index)
					queue_free()
			
			if current_index < dialog_data.size():
				update_dialog(current_index)
			else:
				# Диалоги кончились
				queue_free()
	
	if event is InputEventKey and event.keycode == KEY_ESCAPE and event.pressed:
		queue_free()
