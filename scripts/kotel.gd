extends StaticBody2D

# Ссылки на узлы
@onready var sprite = $AnimatedSprite2D# Или $AnimatedSprite2D
@onready var audio = $AudioStreamPlayer

# Настройки внешнего вида (назначьте в инспекторе)
@export var texture_empty: Texture2D
@export var texture_with_malt: Texture2D # Вид с солодом
@export var animation_cooking: String = "boiling" # Имя анимации варки (если AnimatedSprite2D)

# Состояние
var has_malt: bool = false
var is_cooking: bool = false
var is_active: bool = false

func _ready():
	sprite.play("пустой")

func _physics_process(delta):
	if is_active and Input.is_action_just_pressed("interact"):
		handle_interaction()
	if is_active and Input.is_action_just_pressed("drop"):
		reset_cauldron()

func handle_interaction():
	var item = Global.held_item
	
	# 1. Если руки пусты — ничего не делаем (или можно выбрасывать содержимое)
	if item == "":
		return

	# 2. Логика добавления ингредиентов
	if not has_malt and not is_cooking:
		if item == "caramel" or item == "pilsner" or item == "munhen":
			add_malt()
			Global.drop_item() # Убираем предмет из рук
			
	elif has_malt and not is_cooking:
		if item == "Хмель":
			start_brewing()
			Global.drop_item()
		else:
			print("Сначала нужно добавить солод!")

func add_malt():
	has_malt = true
	# Меняем вид
	sprite.play("solod")
	print("Добавлен солод")

func start_brewing():
	is_cooking = true
	# Запуск анимации и звука
	sprite.play("malt")
	
	audio.play()
	print("Варка началась!")
	
	# Здесь можно запустить таймер на завершение варки через create_timer

func reset_cauldron():
	if is_cooking:
		audio.stop()
	# Функция для сброса (например, когда еда готова)
	has_malt = false
	is_cooking = false
	sprite.play("пустой")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_active = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_active = false
