extends Node2D

class_name Checkpoint

export(NodePath) onready var textura=get_node(textura);

var posicao:Vector2
var jogador:Player

func _ready():
	posicao=global_position;



func _on_Area2D_body_entered(body):
	if body is Player:
		jogador=body
		jogador.salvo()
		jogador.define_ponto(posicao)
		textura.frame=1;

func _on_Area2D_body_exited(body):
	if body==jogador:
		jogador.correndo();
		jogador=null;
