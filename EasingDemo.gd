extends Control

enum EaseFunc {
	BOUNCE_OUT,
	
	LINEAR,
	
	IN_QUAD,
	OUT_QUAD,
	IN_OUT_QUAD,
	
	IN_CUBIC,
	OUT_CUBIC,
	IN_OUT_CUBIC,
	
	IN_QUART,
	OUT_QUART,
	IN_OUT_QUART,
	
	IN_QUINT,
	OUT_QUINT,
	IN_OUT_QUINT,
	
	IN_SINE,
	OUT_SINE,
	IN_OUT_SINE,
	
	IN_EXPO,
	OUT_EXPO,
	IN_OUT_EXPO,
	
	IN_CIRC,
	OUT_CIRC,
	IN_OUT_CIRC,
	
	IN_BACK,
	OUT_BACK,
	IN_OUT_BACK,
	
	IN_ELASTIC,
	OUT_ELASTIC,
	IN_OUT_ELASTIC,

	IN_BOUNCE,
	OUT_BOUNCE,
	IN_OUT_BOUNCE,
}

@export_group("Controls")
@export var knob : Control
@export var notch : Control
@export_subgroup("Line")
@export var line : Line
@export var segments : int = 20
@export var line_color : Color = Color.BLACK


@export_group("Easing")
@export var ease_func : EaseFunc = EaseFunc.LINEAR
var cur_ease_func : Callable
@export var duration : float = 3.0
var time_elapsed : float = 0.0
var is_hovered : bool = false


var ease_map = {
	EaseFunc.BOUNCE_OUT: Ease.bounce_out,
	EaseFunc.LINEAR: Ease.linear,
	EaseFunc.IN_QUAD: Ease.in_quad,
	EaseFunc.OUT_QUAD: Ease.out_quad,
	EaseFunc.IN_OUT_QUAD: Ease.in_out_quad,
	EaseFunc.IN_CUBIC: Ease.in_cubic,
	EaseFunc.OUT_CUBIC: Ease.out_cubic,
	EaseFunc.IN_OUT_CUBIC: Ease.in_out_cubic,
	EaseFunc.IN_QUART: Ease.in_quart,
	EaseFunc.OUT_QUART: Ease.out_quart,
	EaseFunc.IN_OUT_QUART: Ease.in_out_quart,
	EaseFunc.IN_QUINT: Ease.in_quint,
	EaseFunc.OUT_QUINT: Ease.out_quint,
	EaseFunc.IN_OUT_QUINT: Ease.in_out_quint,
	EaseFunc.IN_SINE: Ease.in_sine,
	EaseFunc.OUT_SINE: Ease.out_sine,
	EaseFunc.IN_OUT_SINE: Ease.in_out_sine,
	EaseFunc.IN_EXPO: Ease.in_expo,
	EaseFunc.OUT_EXPO: Ease.out_expo,
	EaseFunc.IN_OUT_EXPO: Ease.in_out_expo,
	EaseFunc.IN_CIRC: Ease.in_circ,
	EaseFunc.OUT_CIRC: Ease.out_circ,
	EaseFunc.IN_OUT_CIRC: Ease.in_out_circ,
	EaseFunc.IN_BACK: Ease.in_back,
	EaseFunc.OUT_BACK: Ease.out_back,
	EaseFunc.IN_OUT_BACK: Ease.in_out_back,
	EaseFunc.IN_ELASTIC: Ease.in_elastic,
	EaseFunc.OUT_ELASTIC: Ease.out_elastic,
	EaseFunc.IN_OUT_ELASTIC: Ease.in_out_elastic,
	EaseFunc.IN_BOUNCE: Ease.in_bounce,
	EaseFunc.OUT_BOUNCE: Ease.out_bounce,
	EaseFunc.IN_OUT_BOUNCE: Ease.in_out_bounce
}

func set_knob_position(pos : Vector2):
	knob.set_anchor(SIDE_LEFT, pos.x, true)
	knob.set_anchor(SIDE_TOP, pos.y, true)

func set_notch_height(height : float):
	notch.position.y = line.size.y*height
	#notch.set_anchor(SIDE_TOP, height, true)
	#notch.set_anchor(SIDE_BOTTOM, height, true)

func reset():
	time_elapsed = 0.0
	set_knob_position(Vector2(0.0, 0.0))
	set_notch_height(0.0)
	notch.modulate.a = 0.0

func _ready():
	cur_ease_func = ease_map[ease_func]

	line.clear_positions()

	var slice = 1.0 / segments

	# array of LinePosition
	var positions: Array[LinePosition] = []

	for i in range(segments+1):
		var x = i * slice
		var	y = cur_ease_func.call(x)
		y = remap(y, 0.0, 1.0, 1.0, 0.0)

		var new_pos = LinePosition.new()
		new_pos.position = Vector2(x, y)
		new_pos.color = line_color

		positions.append(new_pos)

	line.positions = positions

	reset()

	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_elapsed += (delta if is_hovered else -delta)

	# skip ease if not hovered
	if !is_hovered:
		return

	var anim_time = wrapf(time_elapsed, 0.0, duration)
	var ease_time = inverse_lerp(0.0, duration, anim_time)
	var ease_y = cur_ease_func.call(ease_time)
	ease_y = remap(ease_y, 0.0, 1.0, 1.0, 0.0)
	set_knob_position(Vector2(ease_time, ease_y))
	set_notch_height(ease_y)

func _on_mouse_entered():
	time_elapsed = 0.0
	is_hovered = true
	notch.modulate.a = 1.0
	knob.modulate.a = 1.0
	
func _on_mouse_exited():
	is_hovered = false
	notch.modulate.a = 0.0
	knob.modulate.a = 0.0
