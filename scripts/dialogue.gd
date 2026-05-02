extends CanvasLayer

var current_index: int = 0
var can_change: bool = true
var is_typing: bool = false
@export var text_speed: float = 0.05
@export_file("*.json") var dialog_file: String = "res://assets/Dialog.json"
var dialog: Array = []

func _ready() -> void:
	dialog = load_dialog()
	if dialog.is_empty():
		push_error("Диалоги не загружены!")
		return
	update_dialog(0)

func load_dialog():
	if FileAccess.file_exists(dialog_file):
		var file = FileAccess.open(dialog_file, FileAccess.READ)
		var content = file.get_as_text()
		return JSON.parse_string(content)
	return []

func update_dialog(index: int):
	$NinePatchRect/Name.text = dialog[index]["name"]
	type_text(dialog[index]["text"])

func type_text(new_text: String):
	if is_typing:
		return
	
	is_typing = true
	$NinePatchRect/Message.text = ""
	
	for char in new_text:
		if not is_typing:
			break
		$NinePatchRect/Message.text += char
		await get_tree().create_timer(text_speed).timeout
	
	is_typing = false

func _input(event: InputEvent):
	if event is InputEventKey and event.keycode == KEY_SPACE and event.pressed and not event.echo:
		if not can_change:
			return
		
		can_change = false
		
		if is_typing:
			# Если текст печатается - показать весь сразу
			is_typing = false
			$NinePatchRect/Message.text = dialog[current_index]["text"]
			can_change = true
		else:
			# Переход к следующему диалогу
			current_index += 1
			if current_index < dialog.size():
				update_dialog(current_index)
			else:
				queue_free()
			
			await get_tree().create_timer(0.1).timeout
			can_change = true
	
	if event is InputEventKey and event.keycode == KEY_ESCAPE and event.pressed:
		queue_free()
