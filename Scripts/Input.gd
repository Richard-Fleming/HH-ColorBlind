extends Node2D

var currentNum = ""
var sequence = ["Blind", "5", "6", "7", "15", "26"]
var sequenceIterator = 0
var blindPlateTex = preload("res://Sprites/Blind_Plate.png")
var fivePlateTex = preload("res://Sprites/5_Plate.png")
var sixPlateTex = preload("res://Sprites/6_Plate.png")
var sevenPlateTex = preload("res://Sprites/7_Plate.png")
var fifteenPlateTex = preload("res://Sprites/15_Plate.png")
var twentySixPlateTex = preload("res://Sprites/26_Plate.png")
var numPlate
var displayedNum
var displayedTimer
var answered = false
export var maxTime: float = 15
var timer = maxTime

# Called when the node enters the scene tree for the first time.
func _ready():
	numPlate = get_node("Plate")
	displayedNum = get_node("InputUI/DisplayedNum")
	displayedTimer = get_node("Timer")
	displayedTimer.visible_characters = 5
	randomize()
	sequence.shuffle()
	match sequence[sequenceIterator]:
		"Blind":
			numPlate.set_texture(blindPlateTex)
		"5":
			numPlate.set_texture(fivePlateTex)
		"6":
			numPlate.set_texture(sixPlateTex)
		"7":
			numPlate.set_texture(sevenPlateTex)
		"15":
			numPlate.set_texture(fifteenPlateTex)
		"26":
			numPlate.set_texture(twentySixPlateTex)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(sequenceIterator > 5):
		sequenceIterator = 0
		randomize()
		sequence.shuffle()
	if answered == true:
		answered = false
		match sequence[sequenceIterator]:
			"Blind":
				numPlate.set_texture(blindPlateTex)
			"5":
				numPlate.set_texture(fivePlateTex)
			"6":
				numPlate.set_texture(sixPlateTex)
			"7":
				numPlate.set_texture(sevenPlateTex)
			"15":
				numPlate.set_texture(fifteenPlateTex)
			"26":
				numPlate.set_texture(twentySixPlateTex)

	timer -= delta
	if timer <= 0:
		answered = true
		_next_in_sequence()
	displayedTimer.text = String(timer)


func _next_in_sequence():
	currentNum = ""
	sequenceIterator += 1
	timer = maxTime

# Called whenever a button is pressed in the Numpad during the test.
func _on_Button_button_down(extra_arg_0: String):
	if(currentNum.length() < 14):
		#currentNum += "1"
		match extra_arg_0:
			"Button1":
				currentNum += "1"
			"Button2":
				currentNum += "2"
			"Button3":
				currentNum += "3"
			"Button4":
				currentNum += "4"
			"Button5":
				currentNum += "5"
			"Button6":
				currentNum += "6"
			"Button7":
				currentNum += "7"
			"Button8":
				currentNum += "8"
			"Button9":
				currentNum += "9"
			"Button0":
				currentNum += "0"
	if extra_arg_0 == "BackButton":
		currentNum.erase(currentNum.length() - 1, 1)
	if extra_arg_0 == "EnterButton":
		answered = true
		_next_in_sequence()
		
	displayedNum.text = currentNum
