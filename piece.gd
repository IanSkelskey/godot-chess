@tool
extends Node2D

# Create enums for piece types and colors
enum PieceType {
	PAWN,
	KNIGHT,
	ROOK,
	BISHOP,
	QUEEN,
	KING
}

enum PieceColor {
	WHITE,
	BLACK
}

# Access the Sprite2D node
@onready var sprite = $Sprite2D

# Export variables for the piece type and color
@export var piece_type: PieceType : 
	set(value):
		piece_type = value
		sprite.frame = piece_type

@export var piece_color: PieceColor : 
	set(value):
		piece_color = value
		match piece_color:
			PieceColor.WHITE:
				sprite.texture = load("res://assets/WhitePieces_Wood.png")
			PieceColor.BLACK:
				sprite.texture = load("res://assets/BlackPieces_Wood.png")
