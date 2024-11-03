extends Object
class_name Constants  # Adds this as a globally accessible class

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

const PIECE_ORDER = [
	PieceType.ROOK,
	PieceType.KNIGHT,
	PieceType.BISHOP,
	PieceType.QUEEN,
	PieceType.KING,
	PieceType.BISHOP,
	PieceType.KNIGHT,
	PieceType.ROOK
]