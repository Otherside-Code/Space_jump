extends Node

export(NodePath) onready var jogador=get_node(jogador);
export(NodePath) onready var tempo=get_node(tempo);
export(NodePath) onready var tempo_revive=get_node(tempo_revive);
export(NodePath) onready var dano=get_node(dano);
export(NodePath) onready var olha_colisao=get_node(olha_colisao);
export(NodePath) onready var invensivel=get_node(invensivel);

var resta:int=10;
var vida:int=10;
var sufocando:bool=0;
var vivo:bool=1;

var vida_atual:int=vida;



func sem_ar()->void:
	resta=11;
	sufocando=1;
	tempo.wait_time=1;


func morre()->void:
	vivo=0;
	tempo.stop();
	jogador.set_physics_process(false);
	tempo_revive.start();
	
	
func machuca()->void:
	olha_colisao.set_deferred("monitoring",false);
	dano.set_deferred("monitoring",false);
	invensivel.start();
	
	
	if not sufocando:
		sem_ar();
		jogador.atualiza_hud(sufocando);
		
	else:
		if not perde_vida(1):
			morre()
		else:
			jogador.dano();
	


func recupera()->void:
	recarrega();
	vida_atual=vida;
	if vivo:pass;
	else:
		vivo=1;

func perde_vida(quantidade:int)->bool:
	if vida_atual>0:
		vida_atual-=quantidade;
		
		return true;
		
	else:
		return false;
	
	

func recarrega()->bool:
	if sufocando:
		if perde_vida(1):
			resta=10;
			sufocando=0;
			tempo.wait_time=6;
			return true;
		else:
			return false;
		
	else:
		return false;
	
	

func inicia_timer()->void:
	tempo.start();
	
	
	
	
func para_timer()->void:
	tempo.stop();
	


func _on_Timer_timeout():
	resta-=1;
	
	if sufocando:
		if !resta:
			morre();
			
			
	else:
		if !resta:
			sem_ar();
			
	
	jogador.atualiza_hud(sufocando);
	
	


func _on_Revive_timeout():
	jogador.retorna_ponto();
	vivo=1;
	jogador.set_physics_process(true);


func _on_recupera_timeout():
	olha_colisao.set_deferred("monitoring",true);
	dano.set_deferred("monitoring",true);
