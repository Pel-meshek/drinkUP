extends CanvasLayer

@export var text_speed: float = 0.05
var is_typing: bool = false
var current_index: int = 0
@export_file("*.json") var dialog_file: String = "res://assets/Dialog.json"
var dialog: Array = []

func play():
	dialog = load_dialog()
	if dialog == null or dialog.is_empty():
		push_error("Диалоги не загружены!")
		return
	
	$NinePatchRect/Name.text = dialog[current_index]["name"]
	type_text(dialog[current_index]["text"])

func load_dialog():
	if FileAccess.file_exists(dialog_file):
		var file = FileAccess.open(dialog_file, FileAccess.READ)
		var content = file.get_as_text()
		return JSON.parse_string(content)
	return null

func _ready() -> void:
	play()

func _input(event: InputEvent):
	if event is InputEventKey and event.keycode == KEY_SPACE and not event.echo:
		next_dialog()

<<<<<<< Updated upstream
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not stop:
		type_text("бухай мразь")
	if Input.is_action_just_pressed("skip"):
		queue_free()
=======
func next_dialog():
	if is_typing:
		# Если текст печатается - показать ВЕСЬ текст и остановить печать
		complete_text()
	else:
		# Переход к следующему диалогу
		current_index += 1
		if current_index < dialog.size():
			$NinePatchRect/Name.text = dialog[current_index]["name"]
			type_text(dialog[current_index]["text"])
		else:
			queue_free()

func complete_text():
	# Останавливаем печать и показываем полный текст
	is_typing = false
	$NinePatchRect/Message.text = dialog[current_index]["text"]  # Полный текст из JSON
>>>>>>> Stashed changes

func type_text(new_text: String):
	if is_typing:
		return
	
	is_typing = true
	$NinePatchRect/Message.text = ""
	
	for char in new_text:
		if not is_typing:  # Если нажали пробел во время печати
			break
		$NinePatchRect/Message.text += char
		await get_tree().create_timer(text_speed).timeout
	
	# Если цикл завершился естественным путём (не прерван)
	if is_typing:
		is_typing = false
