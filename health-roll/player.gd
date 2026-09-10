extends CharacterBody2D
var speed = 777
var direction = Vector2.ZERO

signal HealthChanged

@export var MaxHealth = 10
@onready var CurrentHealth: int = 5


func _process(delta: float) -> void:
	direction = Input.get_vector("left","right","up","down")
	position += speed * direction * delta
	move_and_slide()
	animation()
	
func animation():
	if direction:
		if direction.x:
			$AnimatedSprite2D.play("Right")
			if direction.x < 0: $AnimatedSprite2D.flip_h = true
			else: $AnimatedSprite2D.flip_h = false
		if direction.y:
			if direction.y < 0: $AnimatedSprite2D.animation = "Up" 
			else: $AnimatedSprite2D.play("Down")
	else: $AnimatedSprite2D.frame = 0

func _on_hurtbox_area_entered(area: Area2D) -> void:
	CurrentHealth -= 1
	if CurrentHealth < 0:
		CurrentHealth = MaxHealth
	
	HealthChanged.emit(CurrentHealth)
		
		
