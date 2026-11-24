class_name MoveManager
extends Node

class Move:
	func _init(o: GameObject, d: Vector2i) -> void:
		obj = o
		dir = d
	
	var obj : GameObject
	var dir : Vector2i

class Turn:
	var moves : Array[Move]

var turnList : Array[Turn]

func add_turn() -> void:
	turnList.append(Turn.new())

func add_move(obj: GameObject, dir: Vector2) -> void:
	if turnList.size() == 0:
		print("Attempted to add move with empty turn list")
		return
	
	turnList[turnList.size() - 1].moves.append(Move.new(obj, dir))

func undo() -> void: # Might need to reverse the order in which the moves are undone
	if turnList.size() == 0:
		print("Attempted to undo when with empty turn list")
		return
	var grid := GameObject.GRID
	var lastTurn : Turn = turnList.pop_back()
	
	for move in lastTurn.moves:
		grid.move_by(move.obj, -move.dir)
		print(move.obj)
		print(move.dir)


func _ready() -> void:
	GameObject.GRID.moveManager = self
