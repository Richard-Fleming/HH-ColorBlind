extends Node2D

var currentNum = ""
var sequence = ["Blind 45", "5", "6", "7", "15", "26"]
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
var inputUIGroup
var endUI
var menuUI
var verdict = 0
var answered = false
export var maxTime: float = 15
var timer = maxTime
var endTest = false

# Called when the node enters the scene tree for the first time.
func _ready():
	inputUIGroup = get_node("InputUI")
	inputUIGroup.visible = false
	numPlate = get_node("Plate")
	numPlate.visible = false
	displayedNum = get_node("InputUI/DisplayedNum")
	displayedTimer = get_node("Timer")
	displayedTimer.visible_characters = 5
	displayedTimer.visible = false
	endUI = get_node("EndUI")
	endUI.visible = false
	endUI.get_node("RestartButton").set_process(false)
	endUI.get_node("MenuReturn").set_process(false)
	menuUI = get_node("MainMenu")
	menuUI.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if sequenceIterator > 5 && !endTest:
		inputUIGroup.visible = false
		numPlate.visible = false
		displayedTimer.visible = false
		endUI.visible = true
		endUI.get_node("DisplayedVerdict").text = "Verdict: " + String(verdict) + "/6"
		endUI.get_node("RestartButton").set_process(true)
		endUI.get_node("MenuReturn").set_process(true)
		endTest = true
	if answered == true && sequenceIterator < 6:
		answered = false
		match sequence[sequenceIterator]:
			"Blind 45":
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
	if timer <= 0 && sequenceIterator < 6:
		answered = true
		_check_answer()
		_next_in_sequence()
	displayedTimer.text = String(timer)


func _next_in_sequence():
	currentNum = ""
	sequenceIterator += 1
	timer = maxTime

func _check_answer():
	match sequence[sequenceIterator]:
		"Blind 45":
			if(currentNum == ""):
				verdict += 1
		"5":
			if(currentNum == "5"):
				verdict += 1
		"6":
			if(currentNum == "6"):
				verdict += 1
		"7":
			if(currentNum == "7"):
				verdict += 1
		"15":
			if(currentNum == "15"):
				verdict += 1
		"26":
			if(currentNum == "26"):
				verdict += 1

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
		_check_answer()
		_next_in_sequence()
		
	displayedNum.text = currentNum


func _on_Restart_button_down():
	inputUIGroup.visible = true
	numPlate.visible = true
	displayedTimer.visible = true
	endUI.visible = false
	endUI.get_node("RestartButton").set_process(false)
	endUI.get_node("MenuReturn").set_process(false)
	currentNum = ""
	verdict = 0
	sequenceIterator = 0
	timer = maxTime
	endTest = false
	randomize()
	sequence.shuffle()
	match sequence[sequenceIterator]:
		"Blind 45":
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


func _on_Start_button_down():
	menuUI.get_node("StartButton").set_process(false)
	menuUI.visible = false
	_on_Restart_button_down()


func _on_MenuReturn_button_down():
	menuUI.get_node("StartButton").set_process(true)
	menuUI.visible = true
	endUI.visible = false
	endUI.get_node("RestartButton").set_process(false)
	endUI.get_node("MenuReturn").set_process(false)
