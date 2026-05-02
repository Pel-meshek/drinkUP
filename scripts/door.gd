extends StaticBody2D

var is_active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_active and Input.is_action_just_pressed("interact"):
		chek_out(Global.held_item)
	else:
		return

func chek_out(item):
	var orders = $"../../Camera2D/Control".orders_data
	for i in range(orders.size()):
		if "Готовый " + orders[i][0] == item:
			$"../../Camera2D/Control".orders_data[i][1] = true
			$"../../Camera2D/Control".render_orders()
			Global.drop_item()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "hitbox":
		$"../../Camera2D/Control".visible = true
		is_active = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.name == "hitbox":
		$"../../Camera2D/Control".visible = false
		is_active = false
