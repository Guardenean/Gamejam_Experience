extends Node
class_name CaixaResposta

@export var natureza : String
@export var topico : String


#enum Natureza {
	#esporte,
	#moda,
	#entretenimento,
#}
#
#enum Topico {
	#t1,
	#t2,
	#t3
#}
#
#@export var natureza : Natureza
#@export var topico : Topico
#var _nat
#var _top
#
#func _ready():
	#match natureza:
		#Natureza.esporte:
			#_nat = "ESPORTE!!!"
		#Natureza.moda:
			#_nat = "MODA!!!!!!"
		#Natureza.entretenimento:
			#_nat = "FUN!!!!!!!"
	#match topico:
		#Topico.t1:
			#_top = "Topico 1"
		#Topico.t2:
			#_top = "Topico 2"
		#Topico.t3:
			#_top = "Topico 3"
