extends CanvasLayer

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if score == 0:
		$"Score HUD".play("1")
	if score == 1:
		$"Score HUD".play("2")
	if score == 2:
		$"Score HUD".play("3")
	if score == -1:
		$"Score HUD".play("4")
	if score == -2:
		$"Score HUD".play("5")
