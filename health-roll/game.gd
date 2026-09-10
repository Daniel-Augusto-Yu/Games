extends Node2D

@onready var heartsContainer = $CanvasLayer/Hearts
@onready var Player = $Player

func _ready() -> void:
	heartsContainer.setMaxHearts(Player.MaxHealth)
	heartsContainer.updateHearts(Player.CurrentHealth)
	Player.HealthChanged.connect(heartsContainer.updateHearts)
