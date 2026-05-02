extends StaticBody2D

enum {
	inactive,
	pilsner,
	munhen,
	caramel
}
var state = inactive
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event):
	if state == inactive:
		return
	if state == caramel and event.is_action_pressed("interact"):
		if Global.held_item == "": # Если руки пусты
			Global.take_item("caramel")
		else:
			print("Руки заняты!")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match state:
		inactive:
			inactive_state()
		pilsner:
			pilsner_state()
		munhen:
			munhen_state()
		caramel:
			caramel_state()

func pilsner_state():
	$Label.text = "Пильзнер"

func munhen_state():
	$Label.text = "Мюнхенский"
	
func caramel_state():
	$Label.text = "Карамельный"

func inactive_state():
	$Label.text = "Солоды"


func _on_pilsner_area_entered(area: Area2D) -> void:
	if area.name == "hitbox":
		state = pilsner

func _on_munhen_area_entered(area: Area2D) -> void:
	if area.name == "hitbox":
		state = munhen


func _on_caramel_area_entered(area: Area2D) -> void:
	if area.name == "hitbox":
		state = caramel


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.name == "hitbox":
		state = inactive
