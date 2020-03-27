import Foundation

//Esse será um jogo que a pessoa é colocada numa sala e ela tem que ir andando
//até o outro lado tentando desviar dos monstros e tentando achar a porta de saída

//struct para segurar os dados de posicao
struct Cartesiano: Equatable{
    var posicaoX:Int
    var posicaoY:Int
}

//Errors possiveis
enum MapaErrors:Error{
    case foraDosLimites
    case issoNaoEhUmaPorta
    case monstroNaoExiste
}

//classe mapa que retornará os dados sobre o ambiente e armazena os monstros
class Mapa{
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
    func possoAndarAteAqui(posicaoPersonagem: Cartesiano)throws->Bool{
        if posicaoPersonagem.posicaoX <= tamanhoDoLado && posicaoPersonagem.posicaoY <= tamanhoDoLado{
            return true
        } else {
            throw MapaErrors.foraDosLimites
        }
    }
    
    //funcao dizendo se o jogador chegou até a porta ou não
    func possoEntrarAqui(posicaoPersonagem:Cartesiano)throws->Bool{
        if posicaoPersonagem.posicaoY == porta && posicaoPersonagem.posicaoX == tamanhoDoLado{
            return true
        } else {
            throw MapaErrors.issoNaoEhUmaPorta
        }
    }
    
    //funcao que verifica a posicao do jogador para ver se existe um monstro no lugar
    func temMonstroAqui(posicaoPersonagem:Cartesiano)->Bool{
        if posicaoDosMonstros.contains(posicaoPersonagem){
            return true
        } else {
            return false
        }
    }

    //funcao que remove monstro apos ser derrotado
    func monstroDerrotado(monstro:Cartesiano) throws {
        let monstroMorto = posicaoDosMonstros.firstIndex(of: monstro )
        
        guard let monstroMortoAux = monstroMorto else{
            throw MapaErrors.monstroNaoExiste
        }
        posicaoDosMonstros.remove(at: monstroMortoAux)
    }
    
}

class Personagem{
    var vida = 3
    var posicao = Cartesiano(posicaoX:0, posicaoY:0)
 
    func andarParaCima(){
        posicao.posicaoY += 1        
    }

    func andarParaBaixo(){
        posicao.posicaoY -= 1
    }

    func andarParaDireita(){
        posicao.posicaoX += 1
    }

    func andarParaEsquerda(){
        posicao.posicaoX -= 1
    }

    func vencerMonstro()->Bool{
        let tentativa = Int.random(in: 0...vida)
        if tentativa > 0{
            return true
        } else {
            return false
        }
    }

    func continuaVivo()->Bool{
        if vida <= 1{
            vida = 0
            return true
        } else {
            vida -= 1
            return false
        }
    }

}

class Jogo{

    let personagem = Personagem()
    let mapa:Mapa

    init?(){
        print("Para começar digite o tamanho do mapa que você deseja jogar, um dígito: ")
        let tamanhoMapa = readLine(strippingNewline: true)
        guard let tamanhoAux = tamanhoMapa, let tamanhoInt = Int(tamanhoAux) else{
            return nil
        }
        mapa = Mapa(tamanhoDoLado: tamanhoInt)
    }
    
    func esperarJogada(){
        print("O que você quer fazer?")
        print("""
        1. Andar para frente
        2. Andar para trás
        3. Andar para a direita
        4. Andar para a esquerda
        
        Digite sua escolha:
        """)
    
    }


}

print("O que você quer fazer?")
print("""
1. Andar para frente
2. Andar para trás
3. Andar para a direita
4. Andar para a esquerda

Digite sua escolha:
""")



