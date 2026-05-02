extends StaticBody2D

@onready var timer_label = $TimerLabel
var is_active = false
var is_timer_active = false
var is_polnyi = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer_label.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if not is_active:
		return 
	elif event.is_action_pressed("interact"):
		start_timer()

func start_timer():
	if not is_polnyi:
		$AnimatedSprite2D.play("default")
		is_polnyi = true
	$AudioStreamPlayer2D.play()
	$TimerLabel/Skillcheck.play()
	is_timer_active = true
	is_active = false
	timer_label.visible = true
	timer_label.text = "10"
	
	for i in range(10, 0, -1):
		await get_tree().create_timer(1).timeout
		if is_instance_valid(timer_label):
			timer_label.text = str(i - 1)
	
	# Завершение
	timer_label.visible = false
	is_active = false
	is_timer_active = false
	$AudioStreamPlayer2D.stop()
	$AnimatedSprite2D.play("пустой")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if not is_timer_active:
			is_active = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_active = false
