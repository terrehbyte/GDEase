extends Node

class_name Ease

const c1 := 1.70158;
const c2 := c1 * 1.525;
const c3 := c1 + 1;
const c4 := (2 * PI) / 3;
const c5 := (2 * PI) / 4.5;

static func bounceOut(x):
	var n1 = 7.5625
	var d1 = 2.75
	if x < 1 / d1:
		return n1 * x * x
	elif x < 2 / d1:
		x -= 1.5 / d1
		return n1 * x + 0.75
	elif x < 2.5 / d1:
		x -= 2.25 / d1
		return n1 * x + 0.9375
	else:
		x -= 2.625 / d1
		return n1 * x + 0.984375

static func linear(x):
	return x

static func easeInQuad(x):
	return x * x

static func easeOutQuad(x): 
	return 1 - (1 - x) * (1 - x)

static func easeInOutQuad(x): 
	return 2 * x * x if x < 0.5 else 1 - pow(-2 * x + 2, 2) / 2

static func easeInCubic(x): 
	return x * x * x

static func easeOutCubic(x): 
	return 1 - pow(1 - x, 3)

static func easeInOutCubic(x): 
	return 4 * x * x * x if x < 0.5 else 1 - pow(-2 * x + 2, 3) / 2

static func easeInQuart(x): 
	return x * x * x * x

static func easeOutQuart(x): 
	return 1 - pow(1 - x, 4)

static func easeInOutQuart(x): 
	return 8 * x * x * x * x if x < 0.5 else 1 - pow(-2 * x + 2, 4) / 2

static func easeInQuint(x): 
	return x * x * x * x * x

static func easeOutQuint(x): 
	return 1 - pow(1 - x, 5)

static func easeInOutQuint(x): 
	return 16 * x * x * x * x * x if x < 0.5 else  1 - pow(-2 * x + 2, 5) / 2

static func easeInSine(x): 
	return 1 - cos((x * PI) / 2)

static func easeOutSine(x): 
	return sin((x * PI) / 2)

static func easeInOutSine(x): 
	return -(cos(PI * x) - 1) / 2

static func easeInExpo(x): 
	return 0.0 if x == 0.0 else pow(2, 10 * x - 10)

static func easeOutExpo(x): 
	return 1.0 if x == 1.0 else 1 - pow(2, -10 * x)

static func easeInOutExpo(x): 
	if x == 0:
		return 0
	elif x == 1:
		return 1
	elif x < 0.5:
		return pow(2, 20 * x - 10) / 2
	else:
		return (2 - pow(2, -20 * x + 10)) / 2

static func easeInCirc(x): 
	return 1 - sqrt(1 - pow(x, 2))

static func easeOutCirc(x): 
	return sqrt(1 - pow(x - 1, 2))

static func easeInOutCirc(x):
	if x < 0.5:
		return (1 - sqrt(1 - pow(2 * x, 2))) / 2
	else:
		return (sqrt(1 - pow(-2 * x + 2, 2)) + 1) / 2

static func easeInBack(x): 
	return c3 * x * x * x - c1 * x * x

static func easeOutBack(x): 
	return 1 + c3 * pow(x - 1, 3) + c1 * pow(x - 1, 2)

static func easeInOutBack(x): 
	if x < 0.5:
		return (pow(2 * x, 2) * ((c2 + 1) * 2 * x - c2)) / 2
	else:
		return (pow(2 * x - 2, 2) * ((c2 + 1) * (x * 2 - 2) + c2) + 2) / 2

static func easeInElastic(x): 
	if x == 0:
		return 0
	elif x == 1:
		return 1
	else:
		return -pow(2, 10 * x - 10) * sin((x * 10 - 10.75) * c4)

static func easeOutElastic(x):
	if x == 0:
		return 0
	elif x == 1:
		return 1
	else:
		return pow(2, -10 * x) * sin((x * 10 - 0.75) * c4) + 1

static func easeInOutElastic(x):
	if x == 0:
		return 0
	elif x == 1:
		return 1
	elif x < 0.5:
		return -(pow(2, 20 * x - 10) * sin((20 * x - 11.125) * c5)) / 2
	else:
		return (pow(2, -20 * x + 10) * sin((20 * x - 11.125) * c5)) / 2 + 1

static func easeInBounce(x): 
	return 1 - bounceOut(1 - x)

static func easeOutBounce(x):
	return bounceOut(x)

static func easeInOutBounce(x): 
	if x < 0.5:
		return (1 - bounceOut(1 - 2 * x)) / 2
	else:
		return (1 + bounceOut(2 * x - 1)) / 2
