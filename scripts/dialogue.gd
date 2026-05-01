extends CanvasLayer

@export var text_speed: float = 0.05 # Секунд на букву
var is_typing: bool = false
var stop = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not stop:
		type_text("привет")
	if Input.is_action_just_pressed("skip"):
		queue_free()

# Эффект печатной машинки
func type_text(new_text: String):
	if is_typing:
		return # Защита от повторного запуска
	
	is_typing = true
	$NinePatchRect/Message.text = "" # Очистка
	
	for char in new_text:
		$NinePatchRect/Message.text += char
		await get_tree().create_timer(text_speed).timeout
		
	is_typing = false
	stop = true
