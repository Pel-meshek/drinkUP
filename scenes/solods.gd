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
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match state:
		inactive:
			pass
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

func _on_pilsner_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		state = pilsner


func _on_munhen_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		state = munhen


func _on_caramel_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		state = caramel


func _on_pilsner_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		state = inactive


func _on_munhen_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		state = inactive


func _on_caramel_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		state = inactive
