extends Node

@export var timeElapsed : Label

@export var lerpRight : ProgressBar
@export var rightLabel : Label
@export var rightStatus : Label

@export var lerpWrong : ProgressBar
@export var wrongLabel : Label
@export var wrongStatus : Label

@export var startValue : float = 0.0
@export var endValue : float = 100.0

var rightValue : float = 0.0
var wrongValue : float = 0.0
@export var wrongSpeed : float = 1.0

@export var lerpDuration : float = 1.0
var lerpTimer : float = 0.0

@export var frameRateOverride : int = 60

@export var completeFudge : float = 0.01
@export var allowFudge : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.max_fps = frameRateOverride


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	lerpTimer += delta;

	# update if end value is not yet reached
	if rightValue <= endValue:
		rightValue = lerp(startValue, endValue, lerpTimer / lerpDuration)
		
		rightLabel.text = str(snapped(lerpTimer, 0.01))
		rightStatus.text = str(snapped(floor(rightValue), 0.01))
	
	# update if end value is not yet reached
	if wrongValue <= endValue && (!allowFudge || wrongValue + completeFudge <= endValue):
		wrongValue = lerp(wrongValue, endValue, delta * wrongSpeed)

		wrongLabel.text = str(snapped(lerpTimer, 0.01))
		wrongStatus.text = str(snapped(floor(wrongValue), 0.01))


	# Update progress bar based on current value vs. end value
	lerpRight.value = Ease.easeInOutElastic(rightValue / endValue)
	lerpWrong.value = wrongValue / endValue
	
	# set time elapsed to two digits after the decimal point
	timeElapsed.text = str(snapped(lerpTimer, 0.01))
