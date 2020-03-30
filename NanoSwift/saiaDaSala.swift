import Foundation

//struct para armazenar as coordenadas
struct Coordenadas: Equatable{
    var x, y: Int
}

//direçao de movimento, para fins de facilitar as funçoes
enum Direcao{
    case norte, sul, leste, oeste
}

//Alguns erros possiveis de se acontecer no mapa
enum MapaErrors:Error{
    case foraDosLimites
    case escolhaInvalida
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

    enum MapaSituations{
        case encontrouMonstro
        case encontrouPorta
        case chegouNaParede
        case lugarVazio
    }

    func achouParede(posicaoPersonagem:Coordenadas)->Bool{
        if posicaoPersonagem.x == tamanho || posicaoPersonagem.y == tamanho{
            return true
        }
        return false
    }

    func achouMonstro(posicaoPersonagem:Coordenadas)->Bool{
        if monstros.contains(posicaoPersonagem){
            return true
        }
        return false
    }

    func achouPorta(posicaoPersonagem:Coordenadas)->Bool{
        if posicaoPersonagem.x == porta.x && posicaoPersonagem.y == porta.y{
            return true
        }
        return false
    }

    func eventosNoMapa(posicaoPersonagem:Coordenadas)throws ->MapaSituations{
        if achouMonstro(posicaoPersonagem: posicaoPersonagem){
            return .encontrouMonstro
        }
        if achouPorta(posicaoPersonagem: posicaoPersonagem){
            return .encontrouPorta
        }
        if achouParede(posicaoPersonagem: posicaoPersonagem){
            return .chegouNaParede
        }
        if posicaoPersonagem.x > tamanho || posicaoPersonagem.y > tamanho{
            throw MapaErrors.foraDosLimites
        }
        return .lugarVazio
    }

    func removerMonstro(posicaoMonstro:Coordenadas)->Bool{
        if let index = monstros.firstIndex(of: posicaoMonstro){
            monstros.remove(at: index)
            return true
        }
        return false
    }
}

class Personagem{

    var posicaoPersonagem = Coordenadas(x:0, y:0)
    var vida:Int

    init(vida:Int){
        self.vida = vida
    }

    convenience init(){
        self.init(vida:5)
    }

    func andar(direcao:Direcao){
        switch direcao{
            case .norte:
            posicaoPersonagem.y += 1
            case .sul:
            posicaoPersonagem.y -= 1
            case .leste:
            posicaoPersonagem.x += 1
            case .oeste:
            posicaoPersonagem.x -= 1
        }
    }

    func atacarMonstro(posicaoPersonagem:Coordenadas)->Bool{
        let ataque = Int.random(in: 0...vida)
        
        if ataque == 0{
            vida -= 1
            return false
        } else {
            return true
        }
    }
}

class Jogo{
    let mapa:Mapa
    let jogador:Personagem

    init(mapa:Int){
        self.mapa = Mapa(tamanho:mapa)
        jogador = Personagem(vida:mapa)
    }

    init(){
        self.mapa = Mapa()
        jogador = Personagem(vida:mapa.tamanho)
    }

    func escolhas() -> Direcao?{
        print("""
        Para onde você deseja ir agora?
        1. Andar para o norte
        2. Andar para o sul
        3. Andar para o oeste
        4. Andar para o leste

        Digite o número seguido de enter:
        """)

        let escolha = readLine(strippingNewline: true)
        if let escolhaAux = escolha, let escolhaInt = Int(escolhaAux), escolhaInt <= 4 && escolhaInt >= 1{
            switch escolhaInt{
                case 1:
                return .norte
                case 2:
                return .sul
                case 3:
                return .oeste
                case 4:
                return .leste
                default:
                print("")
            }
        }
        return nil
    }

    func loopPrincipal(){
        
        var escolha:Direcao?

        repeat {
            escolha = escolhas()
        } while escolha == nil

        

    }

}

let mapa = Mapa()
print(mapa.porta)
let posicaoPersonagem = mapa.monstros[0]
print(try mapa.eventosNoMapa(posicaoPersonagem: posicaoPersonagem))
