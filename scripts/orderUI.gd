extends Control

@onready var toggle_btn = $Button
@onready var orders_panel = $PanelContainer
@onready var orders_list = $PanelContainer/ScrollContainer/VBoxContainer

var orders_data: Array = []


func _process(delta: float) -> void:
	if not Global.day_increased and orders_data[0][1] and orders_data[1][1]:
		Global.day += 1
		orders_data = [
		["Светлый Лагер", false],
		["Эмбер", false],
		]
		render_orders()
		
		Global.day_increased = true 

func _ready():
	# Подключаем кнопку открытия/закрытия
	toggle_btn.pressed.connect(_on_toggle_pressed)
	#я засунул член в USB порт
	if Global.day == 1:
		orders_data = [
		["Светлый Лагер", true],
		["Летний блонд", false],
		["Эль", true]
	]
	elif Global.day == 2:
		orders_data = [
			["Мюнхенский дункeль", true],
		["Эмбер", true],
		["Венский Лагер", true]
		]
	# Генерируем список при запуске
	render_orders()

func _on_toggle_pressed():
	# Переключаем видимость панели
	orders_panel.visible = !orders_panel.visible
	
	# Меняем текст кнопки для красоты
	if orders_panel.visible:
		toggle_btn.text = "Закрыть"
	else:
		toggle_btn.text = "Заказы"

func render_orders():
	for child in orders_list.get_children():
		child.queue_free()
		
	for i in range(orders_data.size()):
		var order = orders_data[i]
		var item_name = order[0]
		var is_done = order[1]
		
		var row = HBoxContainer.new()
		row.custom_minimum_size.y = 30
		
		# --- ЛЕЙБЛ 1 ---
		var label = Label.new()
		label.text = item_name
		
		# 1. Шрифт
		var font = preload("res://assets/Font/RobotoSlab-Regular.ttf")
		label.add_theme_font_override("font", font)
		label.add_theme_font_size_override("font_size", 40)
		
		# 2. Четкость (ВАЖНО)
		label.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
		
		# 3. Выравнивание
		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		
		row.add_child(label)
		
		# --- ЛЕЙБЛ 2 (СТАТУС) ---
		var status_icon = Label.new()
		status_icon.text = "Выполнен" if is_done else "Не выполнен"
		
		status_icon.add_theme_font_override("font", font)
		status_icon.add_theme_font_size_override("font_size", 40) # Сделал одинаковым для красоты
		
		# 2. Четкость (ВАЖНО)
		status_icon.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
		
		status_icon.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		status_icon.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		status_icon.custom_minimum_size.x = 80
		status_icon.modulate = Color.GREEN if is_done else Color.GRAY
			
		row.add_child(status_icon)
		orders_list.add_child(row)
