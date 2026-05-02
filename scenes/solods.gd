extends StaticBody2D

var is_active_p = false
var is_active_m = false
var is_active_c = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event):
	if not is_active_c and not is_active_c and not is_active_c:
		return 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pilsner_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_active_p = true


func _on_munhen_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_active_m = true


func _on_caramel_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_active_c = true


func _on_pilsner_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_active_p = false


func _on_munhen_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_active_m = false


func _on_caramel_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_active_c = false
