extends StaticBody2D

# Настройки
@export var cut_time: float = 5.0

# Узлы
@onready var progress_bar = $StolTimerLabel/AnimatedSprite2D # Добавьте ProgressBar как дочерний узел
@onready var audio = $AudioStreamPlayer2D # Звук нарезки (опционально)

# Состояние
var is_active: bool = false
var cut_progress: float = 0.0
var is_cutting: bool = false

func _ready():
	$StolTimerLabel.visible = false

func _physics_process(delta):
	if not is_active:
		reset_process()
		return

	# Проверка: в руках Солод?
	var held_item = Global.held_item
	if held_item != "caramel" and held_item != "pilsner" and held_item != "munhen":
		reset_process()
		return

	# Логика удержания E
	if Input.is_action_pressed("interact"):
		if not is_cutting:
			is_cutting = true
			audio.play() # Запуск звука
		
		cut_progress += delta
		$StolTimerLabel.visible = true
		$StolTimerLabel/AnimatedSprite2D.play("default")
		
		# Завершение нарезки
		if cut_progress >= cut_time:
			finish_cutting(held_item)
	else:
		# Кнопка отпущена — сброс
		reset_process()

func finish_cutting(item):
	Global.drop_item() # Убираем целый солод
	Global.take_item(item + " rez") # Даем разрезанный
	
	reset_process()
	print("Солод нарезан!")

func reset_process():
	is_cutting = false
	cut_progress = 0.0
	$StolTimerLabel.visible = false
	if audio:
		audio.stop()



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_active = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_active = false
		reset_process()
