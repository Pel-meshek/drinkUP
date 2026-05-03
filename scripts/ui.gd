extends CanvasLayer


var score = 0
var time_left: int = 60
var cutscene: bool = false # Флаг катсцены




@onready var item_label = $Label
@onready var time_label = $TimerLabel
@onready var day_timer = $Timer
@onready var score_hud = $"Score HUD"

func _ready():
	Global.item_changed.connect(_on_item_changed)
	_on_item_changed(Global.held_item)
	
	start_new_day()

# Вызывайте эту функцию, когда начинается катсцена
func start_cutscene():
	cutscene = true
	day_timer.stop() # Останавливаем таймер
	time_label.visible = false # Скрываем текст таймера (опционально)
	print("Катсцена началась, таймер остановлен")

# Вызывайте эту функцию, когда катсцена заканчивается
func end_cutscene():
	cutscene = false
	time_label.visible = true # Показываем таймер обратно
	start_new_day() # Перезапускаем отсчет (или продолжайте с того же места, если нужно)
	print("Катсцена закончена, таймер запущен")

func start_new_day():
	time_left = 120 # Или 120, как вам нужно
	cutscene = false
	update_time_display()
	if day_timer:
		day_timer.start()

# Эта функция подключена к сигналу timeout узла DayTimer
func _on_day_timer_timeout():
	# Если идет катсцена, игнорируем тики таймера
	if cutscene:
		return

	time_left -= 1
	update_time_display()
	
	if time_left <= 0:
		day_timer.stop()
		print("День закончен!")
		get_tree().reload_current_scene()

func update_time_display():
	if not is_instance_valid(time_label):
		return
	$Label2.text = ""
	$Label2.text = "День: " + str(Global.day)
	if cutscene:
		# При катсцене можно скрыть таймер или показать "--:--"
		time_label.text = "--:--" 
	else:
		var minutes = time_left / 60
		var seconds = time_left % 60
		# Форматируем красиво: 01:05 вместо 1:5
		time_label.text = "%02d:%02d" % [minutes, seconds]

func _process(delta: float):
	if score_hud:
		match Global.score:
			0: score_hud.play("1")
			1: score_hud.play("2")
			2: score_hud.play("3")
			-1: score_hud.play("4")
			-2: score_hud.play("5")


	if Global.day == 7:
		item_label.text = ""
	# Оптимизация: используем match вместо кучи if
	match Global.score:
		0: score_hud.play("1")
		1: score_hud.play("2")
		2: score_hud.play("3")
		-1: score_hud.play("4")
		-2: score_hud.play("5")

func _on_item_changed(new_item: String):
	if is_instance_valid(item_label):
		if new_item == "":
			item_label.text = "Руки пусты"
		else:
			item_label.text = "В руках: " + new_item
