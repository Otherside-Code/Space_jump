extends Node

export(NodePath) onready var jogador=get_node(jogador);
export(NodePath) onready var tempo=get_node(tempo);

var resta:int=60;
var vida:int=10;
var estado_critico:bool=0;
var vivo:bool=1;

var vida_atual:int=vida-1;


func perde_vida(quantidade:int)->bool:
	if vida_atual>0:
		vida_atual-=1;
		print('restam apenas ',vida_atual,' cargas de o²')
		
		return true;
		
	else:
		return false;
	
	

func recarrega()->void:
	if estado_critico:
		if perde_vida(1):
			resta=10;
			estado_critico=0;
		else:
			print("não tenho cargas de o²")
		
	else:
		print("não preciso disso")
	
	

func inicia_timer()->void:
	tempo.start();
	


func _on_Timer_timeout():
	resta-=1;
	
	
	if estado_critico:
		if resta:
			print(resta);
		else:
			vivo=0;
			tempo.stop();
			jogador.set_physics_process(false);
	else:
		if resta:
			pass;
		else:
			print('você entrou em estado critico');
			resta=11;
			estado_critico=1;
