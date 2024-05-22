extends CharacterBody2D

var movement_speed = 60.0
var hp = 80
@onready var sprite = $sprite

func _physics_process(_delta):
	movement()
	
func movement():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(x_mov, y_mov)
	
	if mov.x > 0:
		sprite.flip_h = true
	elif mov.x < 0: 
		sprite.flip_h = false
		
	if mov != Vector2.ZERO:
		sprite.play()
	else:
		sprite.pause()
	
	velocity = mov.normalized()*movement_speed
	move_and_slide()


func _on_hurt_box_hurt(damage):
	hp -= damage
	print(hp)
