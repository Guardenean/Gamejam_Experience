extends Node
class_name Perguntas

const p1 : Dictionary = {
	"natureza":"esporte",
	"topico":"atleta",
	"pergunta":"TOMÁS GAVIÃO SE APOSENTOU DO SKATE?"
}
const p2 = {
	"natureza":"esporte",
	"topico":"futebol",
	"pergunta":"NOVO ATACANTE DO BASCO"
}
const p3 = {
	"natureza":"esporte",
	"topico":"basquete",
	"pergunta":"FRAQUENGO BASQUETE"
}
const p4 = {
	"natureza":"entretenimento",
	"topico":"social",
	"pergunta":"DANCINHAS PARA PARAR A GUERRA DE NINIUS"
}
const p5 = {
	"natureza":"entretenimento",
	"topico":"jogos",
	"pergunta":"QUANDO VAI LANÇAR GAMESFERA DA GIGASOFT"
}
const p6 = {
	"natureza":"entretenimento",
	"topico":"cinema",
	"pergunta":"QUAL O NOVO TRAILER DO KING KONGA"
}
const p7 = {
	"natureza":"compras",
	"topico":"moda",
	"pergunta":"NOVA LINHA DE INVERNO DA SNAKE HEAD"
}
const p8 = {
	"natureza":"compras",
	"topico":"util",
	"pergunta":"NOVO IPEAR X35+ CELULAR COMPRAR"
}
const p9 = {
	"natureza":"compras",
	"topico":"comida",
	"pergunta":"ONDE TEM X-TUDÃO?"
}
const p10 = {
	"natureza":"noticia",
	"topico":"trabalho",
	"pergunta":"TIGUER MOTORS TROCA EMPREGADOS POR MÁQUINAS"
}
const p11 = {
	"natureza":"noticias",
	"topico":"mundo",
	"pergunta":"KARKA DECLAROU GUERRA CONTRA NINIUS"
}
const p12 = {
	"natureza":"noticias",
	"topico":"politica",
	"pergunta":"RESPONSÁVEL PELA MORTE DO MINISTRO HECTOR SALAMANDRO?"
}
const p13 = {
	"natureza":"saude",
	"topico":"corpo",
	"pergunta":"COMO EMAGRECER RÁPIDO"
}
const p14 = {
	"natureza":"saude",
	"topico":"mente",
	"pergunta":"POSSO TER DEPRESSÃO POR REDE SOCIAL?"
}
const p15 = {
	"natureza":"saude",
	"topico":"remedio",
	"pergunta":"ANTICONCEPCIONAL ONDE COMPRAR"
}

const  perguntas = {
	1 : p1,
	2 : p2,
	3 : p3,
	4 : p4,
	5 : p5,
	6 : p6,
	7 : p7,
	8 : p8,
	9 : p9,
	10 : p10,
	11 : p11,
	12 : p12,
	13 : p13,
	14 : p14,
	15 : p15,
}

var array = [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15]

func _get_pergunta():
	var num = randi_range(0, array.size() - 1)
	var resp = array[num]
	array.remove_at(num)
	return resp
	
func _get_array_count():
	return array.size()
