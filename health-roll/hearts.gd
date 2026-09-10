extends HBoxContainer
@onready var Heart_GUI = preload("res://heart_gui.tscn")


func setMaxHearts(max: int):
	for i in range(max):
		var heart = Heart_GUI.instantiate()
		add_child(heart)
		
func updateHearts(CurrentHealth: int):
	var hearts = get_children()
	
	for i in range(CurrentHealth):
		hearts[i].update(true)
	
	for i in range(CurrentHealth, hearts.size()):
		hearts[i].update(false)
	
	
