extends Area2D

@onready var line2d = $Line2D
@onready var fin = $fin

var click :bool = false

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_released("clicGauche"):
		click = false
		line2d.clear_points()
		
	if (click):
		if line2d.get_point_count() == 2:
			line2d.remove_point(1)
		line2d.add_point(get_local_mouse_position())
		fin.position = get_local_mouse_position()

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("clicGauche"):
		click = true
		line2d.z_index = 100
		line2d.add_point(get_node("Center").position)
