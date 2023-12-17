extends Node

class_name Ease

const c1 := 1.70158;
const c2 := c1 * 1.525;
const c3 := c1 + 1;
const c4 := (2 * PI) / 3;
const c5 := (2 * PI) / 4.5;

static func bounce_out(x):
	var n1 = 7.5625
	var d1 = 2.75
	if x < 1 / d1:
		return n1 * x * x
	elif x < 2.0 / d1:
		x -= 1.5 / d1
		return n1 * x * x + 0.75
	elif x < 2.5 / d1:
		x -= 2.25 / d1
		return n1 * x * x + 0.9375
	else:
		x -= 2.625 / d1
		return n1 * x * x + 0.984375

static func linear(x):
	return x

static func in_quad(x):
	return x * x

static func out_quad(x): 
	return 1 - (1 - x) * (1 - x)

static func in_out_quad(x): 
	return 2 * x * x if x < 0.5 else 1 - pow(-2 * x + 2, 2) / 2

static func in_cubic(x): 
	return x * x * x

static func out_cubic(x): 
	return 1 - pow(1 - x, 3)

static func in_out_cubic(x): 
	return 4 * x * x * x if x < 0.5 else 1 - pow(-2 * x + 2, 3) / 2

static func in_quart(x): 
	return x * x * x * x

static func out_quart(x): 
	return 1 - pow(1 - x, 4)

static func in_out_quart(x): 
	return 8 * x * x * x * x if x < 0.5 else 1 - pow(-2 * x + 2, 4) / 2

static func in_quint(x): 
	return x * x * x * x * x

static func out_quint(x): 
	return 1 - pow(1 - x, 5)

static func in_out_quint(x): 
	return 16 * x * x * x * x * x if x < 0.5 else  1 - pow(-2 * x + 2, 5) / 2

static func in_sine(x): 
	return 1 - cos((x * PI) / 2)

static func out_sine(x): 
	return sin((x * PI) / 2)

static func in_out_sine(x): 
	return -(cos(PI * x) - 1) / 2

static func in_expo(x): 
	return 0.0 if x == 0.0 else pow(2, 10 * x - 10)

static func out_expo(x): 
	return 1.0 if x == 1.0 else 1 - pow(2, -10 * x)

static func in_out_expo(x): 
	if x == 0:
		return 0
	elif x == 1:
		return 1
	elif x < 0.5:
		return pow(2, 20 * x - 10) / 2
	else:
		return (2 - pow(2, -20 * x + 10)) / 2

static func in_circ(x): 
	return 1 - sqrt(1 - pow(x, 2))

static func out_circ(x): 
	return sqrt(1 - pow(x - 1, 2))

static func in_out_circ(x):
	if x < 0.5:
		return (1 - sqrt(1 - pow(2 * x, 2))) / 2
	else:
		return (sqrt(1 - pow(-2 * x + 2, 2)) + 1) / 2

static func in_back(x): 
	return c3 * x * x * x - c1 * x * x

static func out_back(x): 
	return 1 + c3 * pow(x - 1, 3) + c1 * pow(x - 1, 2)

static func in_out_back(x): 
	if x < 0.5:
		return (pow(2 * x, 2) * ((c2 + 1) * 2 * x - c2)) / 2
	else:
		return (pow(2 * x - 2, 2) * ((c2 + 1) * (x * 2 - 2) + c2) + 2) / 2

static func in_elastic(x): 
	if x == 0:
		return 0
	elif x == 1:
		return 1
	else:
		return -pow(2, 10 * x - 10) * sin((x * 10 - 10.75) * c4)

static func out_elastic(x):
	if x == 0:
		return 0
	elif x == 1:
		return 1
	else:
		return pow(2, -10 * x) * sin((x * 10 - 0.75) * c4) + 1

static func in_out_elastic(x):
	if x == 0:
		return 0
	elif x == 1:
		return 1
	elif x < 0.5:
		return -(pow(2, 20 * x - 10) * sin((20 * x - 11.125) * c5)) / 2
	else:
		return (pow(2, -20 * x + 10) * sin((20 * x - 11.125) * c5)) / 2 + 1

static func in_bounce(x): 
	return 1 - bounce_out(1 - x)

static func out_bounce(x):
	return bounce_out(x)

static func in_out_bounce(x): 
	if x < 0.5:
		return (1 - out_bounce(1 - 2 * x)) / 2
	else:
		return (1 + out_bounce(2 * x - 1)) / 2
