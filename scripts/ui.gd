extends CanvasLayer

var score = 0
var time_left: int = 120

@onready var item_label = $Label
@onready var time_label = $TimerLabel
@onready var day_timer = $Timer # Ссылка на узел Timer в сцене
@onready var score_hud = $"Score HUD"

func _ready():
	if not item_label or not time_label or not day_timer:
		push_error("Проверьте имена узлов: ItemLabel, TimeLabel, DayTimer")
		return

	Global.item_changed.connect(_on_item_changed)
	_on_item_changed(Global.held_item)
	
	start_new_day()

func start_new_day():
	time_left = 120
	update_time_display()
	day_timer.start() # Запускаем таймер

# Эта функция вызывается каждый раз, когда таймер тикает (раз в секунду)
func _on_day_timer_timeout():
	time_left -= 1
	update_time_display()
	print("Тик таймера: ", time_left) # Проверка в консоли
	
	if time_left <= 0:
		day_timer.stop()
		print("День закончен!")
		get_tree().reload_current_scene()

func update_time_display():
	if is_instance_valid(time_label):
		time_label.text = str(time_left)

func _process(delta: float):
	if score_hud:
		match score:
			0: score_hud.play("1")
			1: score_hud.play("2")
			2: score_hud.play("3")
			-1: score_hud.play("4")
			-2: score_hud.play("5")

func _on_item_changed(new_item: String):
	if is_instance_valid(item_label):
		item_label.text = "В руках: " + new_item if new_item != "" else "Руки пусты"
