extends Node2D

class_name CaixaDeDialogo

export(String) onready var texto;
export(NodePath) onready var caixa=get_node(caixa);
export(NodePath) onready var linha=get_node(linha);

var jogador:Player=null;


func _ready():
	linha.text=texto;


func _on_Area2D_body_entered(body):
	if body is Player:
		jogador=body;
		caixa.visible=true;


func _on_Area2D_body_exited(body):
	if body==jogador:
		jogador=null;
		caixa.visible=false;
