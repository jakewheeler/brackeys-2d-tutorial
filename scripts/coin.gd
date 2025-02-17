extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal collected

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(_body: Node2D) -> void:
	collected.emit()
	animation_player.play("pickup")
	
