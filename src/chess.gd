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
	for i in Constants.PIECE_ORDER.size():
		place_piece(Constants.PIECE_ORDER[i], Constants.PieceColor.WHITE, grid_to_position(Vector2(i, 0)))
		place_piece(Constants.PieceType.PAWN, Constants.PieceColor.WHITE, grid_to_position(Vector2(i, 1)))
	
	for i in Constants.PIECE_ORDER.size():
		place_piece(Constants.PIECE_ORDER[i], Constants.PieceColor.BLACK, grid_to_position(Vector2(i, 7)))
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
		
		if clicked_piece and clicked_piece.piece_color == (Constants.PieceColor.WHITE if is_white_turn else Constants.PieceColor.BLACK):
			selected_piece = clicked_piece  # Select the piece if it belongs to the current player
			print("Piece selected: ", selected_piece.piece_type)  # Debug: Log selected piece
		elif selected_piece:
			var target_grid = position_to_grid(mouse_pos)
			print("Attempting move to grid: ", target_grid)  # Debug: Log target grid

func get_square_grid_coordinates_from_click(pos: Vector2) -> Vector2:
	var start_position : Vector2 = TopLeft.position
	var grid_position = (pos - start_position) / square_size
	grid_position.x = round(grid_position.x)
	grid_position.y = round(grid_position.y)
	return grid_position

func get_piece_at_position(pos: Vector2):
	var grid_position = get_square_grid_coordinates_from_click(pos)
	for child in get_children():
		if child.has_method("piece_type") and child.position == grid_to_position(grid_position):
			return child
	return null
