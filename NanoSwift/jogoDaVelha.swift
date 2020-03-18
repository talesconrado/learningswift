import Foundation

//USANDO CONTROLES DE FLUXO 
//Learning Objectives 245, 246, 247, 249, 263, 327, 329, 330, 333, 343, 344, 345, 370, 371
//Usando pedra, papel e tesoura:

func voceGanhou(jogada:String){
    let possiveisJogadas = ["pedra", "papel", "tesoura"]
    let jogadaMaquina = Int.random(in:0..<3)
    
    print("A máquina jogou \(possiveisJogadas[jogadaMaquina])\n")
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
    default:
        print("")
    }
}

let possiveisJogadas = ["pedra", "papel", "tesoura"]

print("PEDRA, PAPEL ou TESOURA! Faça a sua jogada digitando pedra, papel ou tesoura. Digite q para sair.\n")

var loop = true

repeat {
    let jogada = readLine()
    print("")
    if jogada == "q"{
        loop = false
    } else {
        if let jogadaAux = jogada, possiveisJogadas.contains(jogadaAux){
            voceGanhou(jogada: jogadaAux)
        } else {
            print("Jogada inválida.\n")
        }
    }
} while loop

print("Adeus!")


