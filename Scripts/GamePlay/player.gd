extends CharacterBody2D

const SPEED = 300.0

var dragon: CharacterBody2D #nessa variavel vamos salvar o dragão selecionado para fazer qualquer coisa nele (curar, etc..)

func _ready():
	Global.player = self


func _physics_process(delta):
	
	velocity.x = Input.get_axis("left", "right")
	velocity.y = Input.get_axis('up', "down")
	
	velocity = velocity.normalized() * SPEED

	move_and_slide()
