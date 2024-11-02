extends Node2D

const PieceScene = preload("res://src/piece.tscn")

const square_size: int = 16

@onready var TopLeft: Node2D = $TopLeft

func _ready() -> void:
	setup_pieces()

func setup_pieces() -> void:
	# Place the white pieces
	place_piece(Constants.PieceType.ROOK, Constants.PieceColor.WHITE, grid_to_position(Vector2(0, 0)))
	place_piece(Constants.PieceType.KNIGHT, Constants.PieceColor.WHITE, grid_to_position(Vector2(1, 0)))
	place_piece(Constants.PieceType.BISHOP, Constants.PieceColor.WHITE, grid_to_position(Vector2(2, 0)))
	place_piece(Constants.PieceType.QUEEN, Constants.PieceColor.WHITE, grid_to_position(Vector2(3, 0)))
	place_piece(Constants.PieceType.KING, Constants.PieceColor.WHITE, grid_to_position(Vector2(4, 0)))
	place_piece(Constants.PieceType.BISHOP, Constants.PieceColor.WHITE, grid_to_position(Vector2(5, 0)))
	place_piece(Constants.PieceType.KNIGHT, Constants.PieceColor.WHITE, grid_to_position(Vector2(6, 0)))
	place_piece(Constants.PieceType.ROOK, Constants.PieceColor.WHITE, grid_to_position(Vector2(7, 0)))
	
	# Place the white pawns
	for i in range(8):
		place_piece(Constants.PieceType.PAWN, Constants.PieceColor.WHITE, grid_to_position(Vector2(i, 1)))
	
	# Place the black pieces
	place_piece(Constants.PieceType.ROOK, Constants.PieceColor.BLACK, grid_to_position(Vector2(0, 7)))
	place_piece(Constants.PieceType.KNIGHT, Constants.PieceColor.BLACK, grid_to_position(Vector2(1, 7)))
	place_piece(Constants.PieceType.BISHOP, Constants.PieceColor.BLACK, grid_to_position(Vector2(2, 7)))
	place_piece(Constants.PieceType.QUEEN, Constants.PieceColor.BLACK, grid_to_position(Vector2(3, 7)))
	place_piece(Constants.PieceType.KING, Constants.PieceColor.BLACK, grid_to_position(Vector2(4, 7)))
	place_piece(Constants.PieceType.BISHOP, Constants.PieceColor.BLACK, grid_to_position(Vector2(5, 7)))
	place_piece(Constants.PieceType.KNIGHT, Constants.PieceColor.BLACK, grid_to_position(Vector2(6, 7)))
	place_piece(Constants.PieceType.ROOK, Constants.PieceColor.BLACK, grid_to_position(Vector2(7, 7)))

	# Place the black pawns
	for i in range(8):
		place_piece(Constants.PieceType.PAWN, Constants.PieceColor.BLACK, grid_to_position(Vector2(i, 6)))

func place_piece(piece_type: Constants.PieceType, piece_color: Constants.PieceColor, piece_position: Vector2) -> void:
	# Instance the piece scene
	var piece = PieceScene.instantiate()
	
	# Set the piece type and color
	piece.piece_type = piece_type
	piece.piece_color = piece_color
	
	# Set the piece position
	piece.position = piece_position

	# Add the piece to the board
	add_child(piece)

func grid_to_position(grid_position: Vector2) -> Vector2:
	var start_position : Vector2 = TopLeft.position
	return start_position + grid_position * square_size
