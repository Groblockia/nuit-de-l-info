extends Node2D

var start_area: Area2D
var current_line: Line2D


var connections: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is Area2D:
			child.input_event.connect(_on_input_event.bind(child))

func _process(_delta: float) -> void:
	if start_area:
		current_line.set_point_position(1, start_area.get_local_mouse_position())

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int, area: Area2D) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			start_area = area
			current_line = Line2D.new()
			area.add_child(current_line)
			current_line.z_index = 1
			current_line.add_point(Vector2.ZERO)
			current_line.add_point(area.get_local_mouse_position())
		else:
			if area != start_area:  
				current_line.set_point_position(1, start_area.to_local(area.position))
				record_connection(start_area, area) 
				perform_action_on_connection(start_area, area)  
			else:
				current_line.queue_free()

			start_area = null

func record_connection(area1: Area2D, area2: Area2D) -> void:
	if area1 not in connections:
		connections[area1] = []
	if area2 not in connections:
		connections[area2] = []
	connections[area1].append(area2)
	connections[area2].append(area1)

func perform_action_on_connection(area1: Area2D, area2: Area2D) -> void:
	print(area1.name, " est connecté a ", area2.name)
