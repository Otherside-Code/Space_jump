extends Node

export(NodePath) onready var jogador=get_node(jogador);
export(NodePath) onready var tempo=get_node(tempo);

var resta:int=10;
var vida:int=10;
var sufocando:bool=0;
var vivo:bool=1;

var vida_atual:int=vida;



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
		if resta:
			jogador.atualiza_hud(sufocando);
		else:
			vivo=0;
			tempo.stop();
			jogador.set_physics_process(false);
	else:
		if resta:
			jogador.atualiza_hud(sufocando);
		else:
			resta=11;
			sufocando=1;
			tempo.wait_time=1;
			jogador.atualiza_hud(sufocando);
	
	
