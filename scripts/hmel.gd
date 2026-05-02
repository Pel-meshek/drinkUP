extends StaticBody2D

enum {
	inactive,
	cascad,
	magnum
}
var state = inactive
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event):
	if state == inactive:
		return
	if state == cascad and event.is_action_pressed("interact"):
		if Global.held_item == "": # Если руки пусты
			Global.take_item("cascad")
		else:
			$Label.text = "Руки заняты"
	if state == magnum and event.is_action_pressed("interact"):
		if Global.held_item == "": # Если руки пусты
			Global.take_item("magnum")
		else:
			print("Руки заняты!")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match state:
		inactive:
			inactive_state()
		magnum:
			magnum_state()
		cascad:
			cascad_state()

func magnum_state():
	$Label.text = "Магнум"

func inactive_state():
	$Label.text = "Хмель"

func cascad_state():
	$Label.text = "Каскад"



func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.name == "hitbox":
		state = inactive


func _on_cascad_area_entered(area: Area2D) -> void:
	if area.name == "hitbox":
		state = cascad


func _on_magnum_area_entered(area: Area2D) -> void:
	if area.name == "hitbox":
		state = magnum
