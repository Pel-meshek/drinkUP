extends StaticBody2D

@export var brew_duration: float = 15
enum state { empty, brod, ready}
var current_state: state = state.empty
var is_active = false
var brew_timer: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$skillchek.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_state == state.brod:
		brew_timer+=delta
		if brew_timer>= brew_duration:
			finish()
	if is_active and Input.is_action_just_pressed("interact"):
		handle_interaction()

func handle_interaction():
	var held_item = Global.held_item
	
	match current_state:
		state.empty:
			if held_item == "Пиво":
				current_state = state.brod
				Global.drop_item()
				brew_timer = 0.0
				$skillchek.visible = true
				$skillchek/AnimatedSprite2D.play("default")
		state.ready:
			if held_item == "":
				Global.take_item("Готовое Пиво")
				current_state = state.empty
	
func finish():
	current_state = state.ready
	$skillchek.visible = false
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "hitbox":
		is_active = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.name == "hitbox":
		is_active = false
