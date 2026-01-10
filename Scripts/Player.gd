extends KinematicBody2D

class_name Player

var velocidade:int=32;
var gravidade_player:int=32;
var movimento:Vector2;
var velocidade_pulo:int=-64;
var no_chao:bool=0;

func _physics_process(delta:float):
	movimento_horizontal();
	movimento_vertical();
	gravidade(delta);
	
	movimento=move_and_slide(movimento,Vector2.UP);
	
	
	
func movimento_horizontal()->void:
	var direcao=Input.get_action_strength("dir")-Input.get_action_strength("esq");
	movimento.x=direcao*velocidade;


	
func movimento_vertical()->void:
	if is_on_floor():
		no_chao=1;

	
	if no_chao and movimento.y>=6:
		no_chao=0

	
	if Input.is_action_just_pressed("pulo") and no_chao:
		no_chao=0;
		movimento.y=velocidade_pulo
	


func gravidade(delta:float)->void:
	movimento.y+=delta*gravidade_player;
	
	if movimento.y>=gravidade_player:
		movimento.y=gravidade_player;
