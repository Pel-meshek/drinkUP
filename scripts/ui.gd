extends CanvasLayer

var score = 0
@onready var item_label = $Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		# Подписываемся на сигнал изменения предмета
	Global.item_changed.connect(_on_item_changed)
	# Обновляем текст при старте (если что-то уже было)
	_on_item_changed(Global.held_item)
	day(1)

func day(number):
	for i in range(120,0,-1):
		await get_tree().create_timer(1).timeout
		if is_instance_valid($Timer):
			$Timer.text = str(i-1)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if score == 0:
		$"Score HUD".play("1")
	if score == 1:
		$"Score HUD".play("2")
	if score == 2:
		$"Score HUD".play("3")
	if score == -1:
		$"Score HUD".play("4")
	if score == -2:
		$"Score HUD".play("5")

func arm(item):
	$Label.text = "В руках: " + "caramel"

func _on_item_changed(new_item: String):
	if new_item == "":
		item_label.text = "Руки пусты"
	else:
		item_label.text = "В руках: " + new_item
