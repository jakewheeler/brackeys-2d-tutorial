extends Node

var score = 0

@onready var score_label: Label = $ScoreLabel
@onready var coins: Node = $"../Coins"

func _ready() -> void:
	for coin in coins.get_children():
		coin.collected.connect(_add_point)

func _add_point() -> void:
	score += 1
	score_label.text = "You collected " + str(score) + " coins"
