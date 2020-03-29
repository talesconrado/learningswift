import Foundation

//struct para armazenar as coordenadas
struct Coordenadas{
    var x, y: Int
}

//direçao de movimento, para fins de facilitar as funçoes
enum Direcao{
    case norte, sul, leste, oeste
}

//Alguns erros possiveis de se acontecer no mapa
enum MapaErrors:Error{
    case foraDosLimites
    case portaNaoEncontrada
}

//definindo a classe Mapa que irá conter a localizaçao dos montros e da porta
class Mapa{
    let tamanho:Int
    let porta:Coordenadas
    var monstros:[Coordenadas]

    init(tamanho:Int){
        self.tamanho = tamanho
        //gera uma posicao aleatoria para a porta, mas mantendo ela na parte superior
        porta = Coordenadas(x: Int.random(in: 0...tamanho), y: tamanho)
        //gera uma quantidade aleatoria 
        monstros = (0...tamanho).map {
            _ in Coordenadas(x:Int.random(in: 0...tamanho), y:Int.random(in: 0...tamanho))
        }
    }

    convenience init(){
        self.init(tamanho:5)
    }

    

}

let mapa = Mapa()
print(mapa.monstros)

