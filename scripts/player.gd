extends CharacterBody2D


const SPEED = 200.0
@export var speed: float = 200.0
@export var rotation_speed: float = 10.0 # Скорость поворота (чем выше, тем резче)
var is_playing_sound = false


func _physics_process(delta: float) -> void:

	# 1. Получаем направление ввода (-1 до 1)
	var input_dir = Input.get_vector("left", "right", "up", "down")
	
	# 2. Движение
	velocity = input_dir * speed

	# 3. Поворот спрайта
	if input_dir.length() > 0:
		# Вычисляем целевой угол в радианах
		var target_angle = input_dir.angle()
		$AnimatedSprite2D.play("walk")
		# Плавный поворот к цели (lerp_angle корректно обрабатывает переход через 180/-180 градусов)
		rotation = lerp_angle(rotation, target_angle, rotation_speed * delta)
	else:
		$AnimatedSprite2D.play("idle")
		if is_playing_sound:
			$AudioStreamPlayer2D.stop()
			is_playing_sound = false
	
	if not is_playing_sound:
		$AudioStreamPlayer2D.play()
		is_playing_sound = true
	move_and_slide()
