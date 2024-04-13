extends Node
class_name Perguntas

const p1 : Dictionary = {
	"natureza":"esporte",
	"topico":"hockey",
	"pergunta":"Qual foi o resultado do jogo entre Black Pegasus e os Red Titans"
}
const p2 = {
	"natureza":"esporte",
	"topico":"futebol",
	"pergunta":"Qual a opinião pública sobre o novo atacante do Basco"
}
const p3 = {
	"natureza":"esporte",
	"topico":"esport",
	"pergunta":"Fraquengo e-sports"
}
const p4 = {
	"natureza":"entretenimento",
	"topico":"social",
	"pergunta":"Dancinhas para parar a guerra de Ninius"
}
const p5 = {
	"natureza":"entretenimento",
	"topico":"jogos",
	"pergunta":"nova gamesfera será lançada em julho pela gigasoft"
}
const p6 = {
	"natureza":"entretenimento",
	"topico":"cinema",
	"pergunta":"Qual o novo trailer do King Konga"
}
const p7 = {
	"natureza":"compras",
	"topico":"moda",
	"pergunta":"Nova linha de inverno da Snake Head"
}
const p8 = {
	"natureza":"compras",
	"topico":"util",
	"pergunta":"Qual o novo trailer do King Konga"
}
const p9 = {
	"natureza":"compras",
	"topico":"comida",
	"pergunta":"Qual o novo trailer do King Konga"
}
const p10 = {
	"natureza":"noticias",
	"topico":"trabalho",
	"pergunta":"Montadora Tiguer Motors troca empregados por máquinas"
}
const p11 = {
	"natureza":"noticias",
	"topico":"mundo",
	"pergunta":"Karka declarou guerra contra Ninius"
}
const p12 = {
	"natureza":"noticias",
	"topico":"cinema",
	"pergunta":"Quem foi o responsável pela morte do ministro Hector Salamandro?"
}
const p13 = {
	"natureza":"saude",
	"topico":"corpo",
	"pergunta":"Como emagrecer rápido"
}
const p14 = {
	"natureza":"saude",
	"topico":"mente",
	"pergunta":"Posso ter depressão por rede social?"
}
const p15 = {
	"natureza":"saude",
	"topico":"remedio",
	"pergunta":"Anticoncepcional onde comprar"
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
