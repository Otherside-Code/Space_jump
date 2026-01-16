extends Control

class_name HUD

export(NodePath) onready var cilindro=get_node(cilindro);

var oxigenio:Array=[];
var capsulas:Array=[];
var conta_oxg:int=9;
var conta_capsula:int=9;

func _ready():
	for i in range(10):
		cria_objs("res://Sprites/hud/oxigenio.png",Vector2(20+(15*i),13),90,oxigenio);
		cria_objs("res://Sprites/hud/capsula.png",Vector2(20+(15*i),30),0,capsulas);
		


func tira_capsula()->void:
	capsulas[conta_capsula].visible=false;
	conta_capsula-=1;
	
	

func recarrega_capsulas()->void:
	conta_capsula=9;
	for i in capsulas:
		i.visible=true;



func cria_objs(textura:String,posicao:Vector2,rotacao:int,lista:Array)->void:
	var obj=Sprite.new();
	obj.texture=load(textura);
	obj.position=posicao;
	obj.rotation_degrees=rotacao;
	obj.z_index=-1;
	add_child(obj)
	lista.append(obj);



func tira_oxg()->void:
	oxigenio[conta_oxg].visible=false;
	conta_oxg-=1;


	
func perigo()->void:
	conta_oxg=9;
	for i in oxigenio:
		i.visible=true;
		i.modulate="#e92121"
	
	cilindro.modulate="#e92121"



func recarrega_oxg()->void:
	conta_oxg=9;
	for i in oxigenio:
		i.visible=true;
		i.modulate="#ffffff"
	
	cilindro.modulate="#ffffff"
