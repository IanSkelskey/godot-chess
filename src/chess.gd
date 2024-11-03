extends Node2D

const PieceScene = preload("res://src/piece.tscn")
const SquareScene = preload("res://src/board_square.tscn")

const square_size: int = 16

@onready var TopLeft: Node2D = $TopLeft

var selected_piece = null  # Stores the currently selected piece
var is_white_turn = true   # Tracks the turn; white always starts

func _ready() -> void:
	setup_pieces()
	setup_squares()
	set_process_input(true)

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

func setup_squares() -> void:
	for i in range(8):
		for j in range(8):
			var square = SquareScene.instantiate()
			square.position = grid_to_position(Vector2(i, j))
			add_child(square)

func place_piece(piece_type: Constants.PieceType, piece_color: Constants.PieceColor, piece_position: Vector2) -> void:
	var piece = PieceScene.instantiate()
	piece.piece_type = piece_type
	piece.piece_color = piece_color
	piece.position = piece_position
	add_child(piece)

func grid_to_position(grid_position: Vector2) -> Vector2:
	var start_position : Vector2 = TopLeft.position
	return start_position + grid_position * square_size

func position_to_grid(pos: Vector2) -> Vector2:
	var start_position : Vector2 = TopLeft.position
	return (pos - start_position) / square_size

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos = event.position
		print("Mouse clicked at position: ", mouse_pos)  # Debug: Log mouse click position

		var clicked_piece = get_piece_at_position(mouse_pos)
		
		if clicked_piece:
			print("Piece clicked: ", clicked_piece.piece_type, clicked_piece.piece_color)  # Debug: Log piece type and color
		else:
			print("No piece at clicked position")

		if clicked_piece and clicked_piece.piece_color == (Constants.PieceColor.WHITE if is_white_turn else Constants.PieceColor.BLACK):
			selected_piece = clicked_piece  # Select the piece if it belongs to the current player
			print("Piece selected: ", selected_piece.piece_type)  # Debug: Log selected piece
		elif selected_piece:
			var target_grid = position_to_grid(mouse_pos)
			print("Attempting move to grid: ", target_grid)  # Debug: Log target grid
			attempt_move(selected_piece, target_grid)

func get_piece_at_position(pos: Vector2) -> Node2D:
	# Iterate through all children to check if there's a piece at the specified position
	for child in get_children():
		if child is Node2D and child.has_meta("piece_type"):
			var piece_top_left = child.global_position
			var piece_bottom_right = piece_top_left + Vector2(square_size, square_size)

			# Check if the position is within the boundaries of this piece's "box"
			if pos.x >= piece_top_left.x and pos.x <= piece_bottom_right.x and pos.y >= piece_top_left.y and pos.y <= piece_bottom_right.y:
				return child
	return null


func attempt_move(piece, target_grid):
	var target_position = grid_to_position(target_grid)
	piece.position = target_position
	print("Moved piece to: ", target_position)  # Debug: Log piece movement

	selected_piece = null
	is_white_turn = not is_white_turn  # Switch turns
