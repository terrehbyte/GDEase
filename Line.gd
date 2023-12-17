@tool
extends Control

class_name Line
## Draws a polyline defined by an array of positions and colors.

# array of LinePosition that prints on set
var _positions : Array[LinePosition]
@export var positions : Array[LinePosition]:
	set(value):
		_positions = value
		_refresh_packed_arrays()
	get:
		return _positions
@export var width : float = 1.0
@export var use_anti_aliasing : bool = false

@export var is_relative_to_size : bool = false

# TODO: add an option to discard the positions at runtime
#		or preprocess the packed values to avoid cost on startup

var _packedPositions : PackedVector2Array
var _packedColors : PackedColorArray

func add_position(pos : Vector2, col : Color) -> void:
	var newPos = LinePosition.new()
	newPos.position = pos
	newPos.color = col
	# bypass the setter to avoid refreshing the packed arrays
	_positions.append(newPos)

	# add it manually to the packed arrays
	_packedPositions.append(pos)
	_packedColors.append(col)

func clear_positions() -> void:
	_positions.clear()
	_packedPositions.clear()
	_packedColors.clear()	

func _refresh_packed_arrays() -> void:
	_packedPositions = PackedVector2Array()
	_packedColors = PackedColorArray()
	for element in positions:
		var pos = element.position
		var col = element.color

		if is_relative_to_size:
			pos *= size

		_packedPositions.append(pos)
		_packedColors.append(col)

func _ready():
	if size == Vector2.ZERO:
		# HACK: wait for the next frame to get the correct size - children run before parents
		print_verbose("Line: Size is zero, possibly need to wait for the next frame to get the correct size.")
		await get_tree().process_frame
	_refresh_packed_arrays()

func _process(_delta):
	# TODO: check if we can just limit this to only in-editor
	queue_redraw()

func _draw():
	# HACK: always refresh the packed arrays in editor
	if Engine.is_editor_hint():
		_refresh_packed_arrays()
		pass

	if _packedPositions.size() > 1:
		draw_polyline_colors(_packedPositions, _packedColors, width, use_anti_aliasing)
