extends Node2D

@onready var click_area: Area2D = $ClickArea
@onready var highlight: ColorRect = $Highlight

func _on_click_area_mouse_entered() -> void:
	highlight.modulate = Color(1, 1, 1, 0.5)
	print("Mouse entered square")

func _on_click_area_mouse_exited() -> void:
	highlight.modulate = Color(1, 1, 1, 0)
	print("Mouse exited square")
