@tool
extends Node2D

# Access the Sprite2D node
@onready var sprite = $Sprite2D

# Export variables for the piece type and color
@export var piece_type: Constants.PieceType = Constants.PieceType.PAWN:
	set(value):
		piece_type = value
		if sprite:  # Null check for sprite
			sprite.frame = piece_type

@export var piece_color: Constants.PieceColor = Constants.PieceColor.WHITE:
	set(value):
		piece_color = value
		if sprite:  # Null check for sprite
			match piece_color:
				Constants.PieceColor.WHITE:
					sprite.texture = load("res://assets/WhitePieces_Wood.png")
				Constants.PieceColor.BLACK:
					sprite.texture = load("res://assets/BlackPieces_Wood.png")

func _ready():
	if sprite:
		# Set the initial values based on the exported properties
		sprite.frame = piece_type
		match piece_color:
			Constants.PieceColor.WHITE:
				sprite.texture = load("res://assets/WhitePieces_Wood.png")
			Constants.PieceColor.BLACK:
				sprite.texture = load("res://assets/BlackPieces_Wood.png")
