extends Node2D

@onready var click_area: Area2D = $ClickArea
@onready var highlight: ColorRect = $Highlight

var active = false
var _current_color = [1, 1, 1]

func _on_click_area_mouse_entered() -> void:
	highlight.modulate = Color(_current_color[0], _current_color[1], _current_color[2], 0.5)

func _on_click_area_mouse_exited() -> void:
	if active:
		highlight.modulate = Color(_current_color[0], _current_color[1], _current_color[2], 0.5)
	else:
		highlight.modulate = Color(_current_color[0], _current_color[1], _current_color[2], 0)

func _on_click_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		active = !active
		if active:
			_current_color = [0.866667, 1, 0.870588]
		else:
			_current_color = [1, 1, 1]
