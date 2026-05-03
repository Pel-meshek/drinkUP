extends CanvasLayer

var score = 0
var time_left: int = 120

@onready var item_label = $Label # Переименуйте Label в инспекторе в ItemLabel
@onready var time_label = $Timer # Создайте отдельный Label для времени и назовите его TimeLabel
@onready var score_hud = $"Score HUD"   # Ваш AnimatedSprite2D или аналогичный узел

func _ready():
	# Подписываемся на сигнал
	Global.item_changed.connect(_on_item_changed)
	_on_item_changed(Global.held_item)
	
	# Запускаем таймер дня
	start_day_timer()

func start_day_timer():
	time_left = 120
	update_time_display()
	
	# Используем встроенный таймер Godot вместо цикла await
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0
	timer.autostart = true
	
	timer.timeout.connect(func():
		time_left -= 1
		update_time_display()
		
		if time_left <= 0:
			timer.stop()
			timer.queue_free()
			print("День закончен!")
			get_tree().reload_current_scene() # Перезагрузка сцены
	)

func update_time_display():
	if is_instance_valid(time_label):
		time_label.text = str(time_left)

func _process(delta: float):
	# Оптимизация: используем match вместо кучи if
	match score:
		0: score_hud.play("1")
		1: score_hud.play("2")
		2: score_hud.play("3")
		-1: score_hud.play("4")
		-2: score_hud.play("5")

func _on_item_changed(new_item: String):
	if new_item == "":
		item_label.text = "Руки пусты"
	else:
		item_label.text = "В руках: " + new_item
