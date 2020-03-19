import Foundation

//USANDO CONTROLES DE FLUXO 
//Learning Objectives 245, 246, 247, 249, 263, 327, 329, 330, 333, 343, 344, 345, 370, 371...
//Aplicando em pedra, papel e tesoura:

func jogo(jogadaAux:String, loop: inout Bool){
    let possiveisJogadas = ["pedra", "papel", "tesoura"]
    let jogadaMaquina = Int.random(in:0..<3)
    
    print("A máquina jogou \(possiveisJogadas[jogadaMaquina])\n")
    let jogada = jogadaAux.lowercased()

    switch jogada {
    case "pedra":
        if jogadaMaquina == 0{
            print("Empate!")
        } else if jogadaMaquina == 1{
            print("Você perdeu!")
        } else if jogadaMaquina == 2 {
            print("Você ganhou!")
        }
    case "papel":
        if jogadaMaquina == 0{
            print("Você ganhou!")
        } else if jogadaMaquina == 1{
            print("Empate!")
        } else if jogadaMaquina == 2 {
            print("Você perdeu!")
        }
    case "tesoura":
        if jogadaMaquina == 0{
            print("Você perdeu!")
        } else if jogadaMaquina == 1{
            print("Você ganhou!")
        } else if jogadaMaquina == 2 {
            print("Empate!")
        }
    case "q":
        loop = false
        print("Mas você não quer jogar mais...")
    default:
        print("Mas a sua jogada foi inválida! Tente novamente.")
    }
    print("------------------------")
}


//FLUXO PRINCIPAL

print("PEDRA, PAPEL ou TESOURA! Escolha digitando pedra, papel ou tesoura. Digite q para sair.\n")

var loop = true

repeat {
    print("\nFaça sua jogada:")
    let jogada = readLine()
    print("------------------------")
    if let jogadaAux = jogada{ 
        jogo(jogadaAux: jogadaAux, loop: &loop)
    }
} while loop

print("Adios!")


