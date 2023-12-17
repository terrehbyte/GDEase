extends Control

@export var line : Line
@export var knob : Control

var time_elapsed : float = 0.0

@export var duration : float = 3.0

@export var segments : int = 20

enum EaseFunc {
	BOUNCE_OUT,
	LINEAR,
	EASE_IN_QUAD,
	EASE_OUT_QUAD,
	EASE_IN_OUT_QUAD,
	EASE_IN_CUBIC,
	EASE_OUT_CUBIC,
	EASE_IN_OUT_CUBIC,
	EASE_IN_QUART,
	EASE_OUT_QUART,
	EASE_IN_OUT_QUART,
	EASE_IN_QUINT,
	EASE_OUT_QUINT,
	EASE_IN_OUT_QUINT,
	EASE_IN_SINE,
	EASE_OUT_SINE,
	EASE_IN_OUT_SINE,
	EASE_IN_EXPO,
	EASE_OUT_EXPO,
	EASE_IN_OUT_EXPO,
	EASE_IN_CIRC,
	EASE_OUT_CIRC,
	EASE_IN_OUT_CIRC,
	EASE_IN_BACK,
	EASE_OUT_BACK,
	EASE_IN_OUT_BACK,
	EASE_IN_ELASTIC,
	EASE_OUT_ELASTIC,
	EASE_IN_OUT_ELASTIC,
	EASE_IN_BOUNCE,
	EASE_OUT_BOUNCE,
	EASE_IN_OUT_BOUNCE,
}

var ease_map = {
	#EaseFunc.BOUNCE_OUT: Ease.bounce_out
}

func set_knob_position(pos : Vector2):
	knob.set_anchor(SIDE_LEFT, pos.x, true)
	knob.set_anchor(SIDE_TOP, pos.y, true)

func _ready():
	line.clear_positions()

	var slice = 1.0 / segments

	# array of LinePosition
	var positions: Array[LinePosition] = []

	for i in range(segments+1):
		var x = i * slice
		var y = Ease.linear(x)
		y = remap(y, 0.0, 1.0, 1.0, 0.0)

		var new_pos = LinePosition.new()
		new_pos.position = Vector2(x, y)
		new_pos.color = Color.WHITE

		positions.append(new_pos)

	line.positions = positions

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	time_elapsed += _delta
	var anim_time = wrapf(time_elapsed, 0.0, duration)
	var ease_time = inverse_lerp(0.0, duration, anim_time)
	var ease_y = remap(ease_time, 0.0, 1.0, 1.0, 0.0)
	set_knob_position(Vector2(ease_time, ease_y))

