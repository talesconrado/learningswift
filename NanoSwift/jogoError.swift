import Foundation

//Esse será um jogo que a pessoa é colocada numa sala e ela tem que ir andando
//até o outro lado tentando desviar dos monstros e tentando achar a porta de saída

//struct para segurar os dados de posicao
struct Cartesiano: Equatable{
    var posicaoX:Int
    var posicaoY:Int
}

//classe mapa que retornará os dados sobre o ambiente e armazena os monstros
class Map{
    var tamanhoDoLado: Int
    var porta:Int
    var posicaoDosMonstros: [Cartesiano] = []
    
    init(tamanhoDoLado:Int) {
        self.tamanhoDoLado = tamanhoDoLado
        porta = Int.random(in: 0...tamanhoDoLado)
        for _ in 1...3{
            let x = Int.random(in: 0...tamanhoDoLado)
            let y = Int.random(in: 0...tamanhoDoLado)
            let monstro = Cartesiano(posicaoX:x, posicaoY:y)
            if !(posicaoDosMonstros.contains(monstro)){
                posicaoDosMonstros.append(monstro)
            }
        }
    }
    
    //funcao informando se é possivel ir ate lugar X
    func possoAndarAteAqui(posicaoPersonagem: Cartesiano)->Bool{
        if posicaoPersonagem.posicaoX <= tamanhoDoLado && posicaoPersonagem.posicaoY <= tamanhoDoLado{
            return true
        } else {
            return false
        }
    }
    
    //funcao dizendo se o jogador chegou até a porta ou não
    func possoEntrarAqui(posicaoPersonagem:Cartesiano)->Bool{
        if posicaoPersonagem.posicaoY == porta && posicaoPersonagem.posicaoX == tamanhoDoLado{
            return true
        } else {
            return false
        }
    }
    
    func temMonstroAqui(posicaoPersonagem:Cartesiano)->Bool{
        if posicaoDosMonstros.contains(posicaoPersonagem){
            return true
        } else {
            return false
        }
    }
    
    
}

enum MapErrors{
    case foraDosLimites
    case issoNaoEhUmaPorta
}



