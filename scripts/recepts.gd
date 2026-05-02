extends Control

@onready var toggle_btn = $Button
@onready var panel = $PanelContainer
@onready var tab1_btn = $PanelContainer/TabBar/Recepts
@onready var tab2_btn = $PanelContainer/TabBar/Instruction
@onready var recipes_tab = $PanelContainer/Control/Recepts
@onready var instruction_tab = $PanelContainer/Control/Instrution

var is_open: bool = false

func _ready():
	toggle_btn.pressed.connect(_on_toggle_pressed)
	tab1_btn.pressed.connect(func(): switch_tab(1))
	tab2_btn.pressed.connect(func(): switch_tab(2))
	
	# Инициализация первой вкладки
	switch_tab(1)
	panel.visible = false

func _on_toggle_pressed():
	is_open = !is_open
	panel.visible = is_open
	toggle_btn.text = "❌" if is_open else "📖" # Или иконка

func switch_tab(tab_index: int):
	if tab_index == 1:
		recipes_tab.visible = true
		instruction_tab.visible = false
		tab1_btn.modulate = Color.WHITE
		tab2_btn.modulate = Color.GRAY
	else:
		recipes_tab.visible = false
		instruction_tab.visible = true
		tab1_btn.modulate = Color.GRAY
		tab2_btn.modulate = Color.WHITE
