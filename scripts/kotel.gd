extends StaticBody2D

@onready var sprite = $AnimatedSprite2D # Или AnimatedSprite2D
@onready var audio = $AudioStreamPlayer2D

# Настройки
@export var brew_duration: float = 12 # Время варки

# Состояние
enum State { EMPTY, HAS_MALT, COOKING, READY }
var current_state: State = State.EMPTY
var is_active: bool = false
var brew_timer: float = 0.0
var solod = ""
var hmel = ""

func _ready():
	update_visuals()
	$TimerLabel/Skillcheck.visible = false

func _physics_process(delta):
	# Таймер варки
	if current_state == State.COOKING:
		brew_timer += delta
		$TimerLabel/Skillcheck.play("default")
		
		if brew_timer >= brew_duration:
			finish_brewing()

	# Взаимодействие
	if is_active and Input.is_action_just_pressed("interact"):
		handle_interaction()
	if is_active and Input.is_action_just_pressed("drop"):
		current_state = State.EMPTY
		$TimerLabel/Skillcheck.visible = false
		brew_timer = 0.0
		if audio.playing:
			audio.stop()
		update_visuals()

func handle_interaction():
	var held_item = Global.held_item

	match current_state:
		State.EMPTY:
			if held_item == "pilsner rez" or held_item == "munhen rez" or held_item == "caramel rez":
				current_state = State.HAS_MALT
				solod = held_item
				Global.drop_item()
				update_visuals()
				
		State.HAS_MALT:
			if held_item == "magnum" or held_item == "cascad":
				start_brewing()
				hmel = held_item
				Global.drop_item()
			elif held_item == "":
				print("Нужен хмель!")
				
		State.READY:
			if held_item == "":
				take_beer()
			else:
				print("Освободите руки!")

func start_brewing():
	current_state = State.COOKING
	brew_timer = 0.0
	audio.play()
	$TimerLabel/Skillcheck.visible = true
	update_visuals()

func finish_brewing():
	if State.COOKING:
		audio.stop()
	current_state = State.READY
	$TimerLabel/Skillcheck.visible = false
	update_visuals()
	print("Пиво готово!")

func take_beer():
	Global.take_item(recept(solod,hmel))
	current_state = State.EMPTY
	solod = ""
	hmel = ""
	update_visuals()

func update_visuals():
	match current_state:
		State.EMPTY:
			sprite.play("пустой")
		State.HAS_MALT:
			sprite.play("solod")
		State.COOKING:
			# Можно менять текстуру или играть анимацию
			sprite.play("malt")
		State.READY:
			sprite.play("solod")

func recept(solod,hmel):
	if solod == "pilsner rez" and hmel == "magnum":
		return "Светлый Лагер"
	elif solod == "pilsner rez" and hmel == "cascad":
		return "Летний блонд"
	elif solod == "munhen rez" and hmel == "magnum":
		return "Мюнхенский Дункель"
	elif solod == "caramel rez" and hmel == "cascad":
		return "Эмбер"
	else:
		return "Бурмалда"

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_active = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_active = false
