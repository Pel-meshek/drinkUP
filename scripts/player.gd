extends CharacterBody2D

enum {
	EMPTY,
	SOLOD,
	SOLODREZ,
	HMEL,
	PIVO
}

const SPEED = 200.0
@export var speed: float = 200.0
@export var rotation_speed: float = 10.0 # Скорость поворота (чем выше, тем резче)
var is_playing = false
var state = EMPTY


func _physics_process(delta: float) -> void:
	match state:
		EMPTY:
			pass
		SOLOD:
			solod_state("")
		SOLODREZ:
			pass
		HMEL:
			pass
		PIVO:
			pass
	
	if Input.is_action_just_pressed("drop"):
		Global.drop_item()
	# 1. Получаем направление ввода (-1 до 1)
	var input_dir = Input.get_vector("left", "right", "up", "down")
	
	# 2. Движение
	velocity = input_dir * speed
	
	# 3. Поворот спрайта
	if input_dir.length() > 0:
		# Вычисляем целевой угол в радианах
		var target_angle = input_dir.angle()
		$AnimatedSprite2D.play("walk")
		if not is_playing:
			$AudioStreamPlayer2D.play()
			is_playing = true
		
		# Плавный поворот к цели (lerp_angle корректно обрабатывает переход через 180/-180 градусов)
		rotation = lerp_angle(rotation, target_angle, rotation_speed * delta)
	else:
		if is_playing:
			$AudioStreamPlayer2D.stop()
			is_playing = false
		$AnimatedSprite2D.play("idle")

	move_and_slide()
	
func solod_state(solod):
	print(solod)
	$"../Camera2D/UI".arm(solod)
