extends KinematicBody2D

class_name Player

var velocidade:int=32;
var gravidade_player:int=48;
var movimento:Vector2;
var velocidade_pulo:int=-80;
var no_chao:bool=0;
var pulando:bool=0;
var direcao_parede:int=1;
var na_parede:bool=0;
var pulo_parede:bool=0;
var morrendo:bool=0;
var ponto_de_controle:Vector2;
var bate:CollisionObject;


export(NodePath) onready var parede=get_node(parede);
export(NodePath) onready var status=get_node(status);
export(NodePath) onready var sprite=get_node(sprite);
export(NodePath) onready var hud=get_node(hud);

func _physics_process(delta:float):
	movimento_horizontal();
	movimento_vertical(delta);
	desliza_parede();
	sprite.toca_animacao(movimento);
	
	movimento=move_and_slide(movimento,Vector2.UP);
	
	
	
func movimento_horizontal()->void:
	var direcao=Input.get_action_strength("dir")-Input.get_action_strength("esq");
	movimento.x=direcao*velocidade;
	
	if direcao:
		direcao_parede=direcao;


	
func movimento_vertical(delta:float)->void:
	
	if pulando:
		sprite.animacao_cai();
	
	if not is_on_floor():
		gravidade(delta);
	
	if is_on_floor():
		no_chao=1;
		pulando=0;
		pulo_parede=0;
	else:pass;
	
	if not no_chao and not pulo_parede:
		if Input.is_action_just_pressed("pulo"):
			if status.perde_vida(1):
				movimento.y=velocidade_pulo*0.7;
				hud.tira_capsula();
			
	
	
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
			
			sprite.animacao_pulo(movimento);
			
			movimento.y=velocidade_pulo*0.5;
			
		else:
			if Input.is_action_pressed("pulo") and pulando and movimento.y<=velocidade_pulo:
				movimento.y=velocidade_pulo;
				
	else:
		if Input.is_action_just_pressed("pulo") and not pulando:
			pulando=1;
			direcao_parede*=-1;
			
			movimento.y=velocidade_pulo*0.6;

			
		if movimento.x<16:
			movimento.x+=direcao_parede*48;
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
	parede.cast_to.x=5*direcao_parede;
	
	if parede.is_colliding():
		sprite.modulate="#55e33d"
		if not na_parede and not no_chao :
			movimento.y=0;
			na_parede=1;
		
		return true;
		
	else:
		sprite.modulate="#ffffff"
		na_parede=0;
		
		return false;
		
		

func _input(event)->void:
	if event.is_action_pressed("recarrega_oxg"):
		if status.recarrega():
			hud.recarrega_oxg();
			hud.tira_capsula();
			morrendo=0;
		


func dano()->void:
	hud.tira_capsula();


func atualiza_hud(sufocando:bool)->void:
	if not morrendo and sufocando:
		morrendo=1;
		hud.perigo();
	else:
		hud.tira_oxg();
		
	if morrendo and not sufocando:
		morrendo=0;
	
	
func salvo()->void:
	status.para_timer();
	status.recupera();
	hud.recarrega_capsulas();
	hud.recarrega_oxg();
	morrendo=0;
	


func correndo()->void:
	status.inicia_timer();
	
	
	
func define_ponto(posicao:Vector2)->void:
	ponto_de_controle=posicao;
	


func retorna_ponto()->void:
	position=ponto_de_controle;


func _on_OlhaColisao_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name == "Espinhos":
		status.machuca();


func _on_Dano_area_entered(area):
	if area.name=="Ataque":
		status.machuca();
