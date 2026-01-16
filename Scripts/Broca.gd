extends KinematicBody2D

class_name Broca

export(NodePath) onready var chao=get_node(chao);
export(NodePath) onready var textura=get_node(textura);
export(NodePath) onready var ataque=get_node(ataque);
export(NodePath) onready var bate=get_node(bate);


var lado:int=1;
var velocidade:int=48;
var gravidade_inimigo:int=48;
var movimento:Vector2;


func _physics_process(delta):

	if not chao.is_colliding() or bate.get_collider()!=Player and bate.get_collider()!=null:
		lado*=-1;
		if lado==-1:
			chao.position.x=-17;
			ataque.position.x=-12
			bate.cast_to.x=-22
			bate.position.x=position.x*lado
		if lado==1:
			ataque.position.x=12
			bate.cast_to.x=22
			bate.position.x=position.x*lado
			chao.position.x=17;
		
	textura.vira(movimento);
		
	movendo(delta);
	movimento=move_and_slide(movimento,Vector2.UP);



func movendo(delta):
	if not is_on_floor():
		gravidade(delta)
	
	else:
		movimento.x=lado*velocidade;
		
		
func gravidade(delta):
	movimento.y+=delta*gravidade_inimigo;
