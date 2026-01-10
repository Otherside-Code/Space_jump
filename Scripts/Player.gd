extends KinematicBody2D

class_name Player

var velocidade:int=32;
var gravidade_player:int=32;
var movimento:Vector2;
var velocidade_pulo:int=-64;
var no_chao:bool=0;
var pulando:bool=0;
var direcao_parede:int=1;
var na_parede:bool=0;
var pulo_parede:bool=0;

export(NodePath) onready var parede=get_node(parede);

func _physics_process(delta:float):
	movimento_horizontal();
	movimento_vertical();
	gravidade(delta);
	desliza_parede()
	
	movimento=move_and_slide(movimento,Vector2.UP);
	
	
	
func movimento_horizontal()->void:
	var direcao=Input.get_action_strength("dir")-Input.get_action_strength("esq");
	movimento.x=direcao*velocidade;
	
	if direcao:
		direcao_parede=direcao;


	
func movimento_vertical()->void:
	if is_on_floor():
		no_chao=1;
		pulando=0;
		pulo_parede=0;
	else:pass;
	
	
	if desliza_parede():
		pulo_parede=1;
		pulando=0;

	
	if no_chao and movimento.y>=6:
		no_chao=0;
		pulo_parede=0;
	else:pass;
	
	if movimento.y>=6 and not desliza_parede():
		pulo_parede=0;
		pulando=0;

	if not pulo_parede:
		if Input.is_action_just_pressed("pulo") and no_chao:
			no_chao=0;
			pulando=1;
			
			movimento.y=velocidade_pulo*0.5;
			
		else:
			if Input.is_action_pressed("pulo") and pulando and movimento.y<=velocidade_pulo:
				movimento.y=velocidade_pulo;
				
	else:
		if Input.is_action_just_pressed("pulo") and not pulando:
			pulando=1;
			direcao_parede*=-1;
			
			movimento.y=velocidade_pulo*0.4;
			
		if movimento.x<32:
			movimento.x+=direcao_parede*16;
		else:
			pulo_parede=0;


func gravidade(delta:float)->void:
	
	if not desliza_parede():
		if pulando and Input.is_action_pressed("pulo"):
			movimento.y+=delta*(gravidade_player*0.5);
		else:
			movimento.y+=delta*gravidade_player;
		
		if movimento.y>=gravidade_player:
			movimento.y=gravidade_player;
	
	else:
		movimento.y+=delta*(gravidade_player*0.4);
		
		if movimento.y>=gravidade_player*0.7:
			movimento.y=gravidade_player*0.7;
		
		
		
func desliza_parede()->bool:
	parede.cast_to.x=20*direcao_parede;
	
	if parede.is_colliding():
		if not na_parede and not no_chao :
			movimento.y=0;
			na_parede=1;
		
		return true;
		
	else:
		na_parede=0;
		
		return false;
