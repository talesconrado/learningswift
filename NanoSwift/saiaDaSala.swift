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

    //inicializador de tamanho padrao escolhido como 5
    convenience init(){
        self.init(tamanho:5)
    }

    //possiveis situacoes a serem triggeradas
    enum MapaSituations{
        case encontrouMonstro
        case encontrouPorta
        case chegouNaParede
        case lugarVazio
    }

    //caso ache uma parede ele diz que está lá
    func achouParede(posicaoPersonagem:Coordenadas)->Bool{
        if posicaoPersonagem.x == tamanho || posicaoPersonagem.y == tamanho{
            return true
        }
        return false
    }

    //caso encontre um monstro ele retorna true e fala que vai ter algo
    func achouMonstro(posicaoPersonagem:Coordenadas)->Bool{
        if monstros.contains(posicaoPersonagem){
            return true
        }
        return false
    }

    //caso ache a porta ele diz para o jogador e ele pode tentar entrar
    func achouPorta(posicaoPersonagem:Coordenadas)->Bool{
        if posicaoPersonagem.x == porta.x && posicaoPersonagem.y == porta.y{
            return true
        }
        return false
    }

    //uniao de todas as situacoes em uma funcao unica
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

    //caso o jogador ganhe a luta com o monstro ele pode ser removido
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

    func lutando(posicaoPersonagem:Coordenadas){
        
        var ganhou = false

        repeat {
            print("Atacando monstro!")
            ganhou = jogador.atacarMonstro(posicaoPersonagem: posicaoPersonagem)
            if ganhou{
                print("Você o derrotou!")
            } else {
                print("Você perdeu vida... mas não o derrotou ainda. Vida atual: \(jogador.vida)")
                if jogador.vida == 0{
                    print("FIM DE JOGO")
                    break
                }
            }
        } while !(ganhou)

    }

    func loopPrincipal()->Bool{
        
        var escolha:Direcao?

        repeat {
            escolha = escolhas()
        } while escolha == nil

        jogador.andar(direcao: escolha!)

        let evento = try? mapa.eventosNoMapa(posicaoPersonagem: jogador.posicaoPersonagem)

        switch evento{
            case .encontrouMonstro:
            lutando(posicaoPersonagem: jogador.posicaoPersonagem)
            case .chegouNaParede:
            print("Você consegue ver uma parede perto...")
            case .encontrouPorta:
            print("Você chegou até a saída! Parabéns!")
            return false
            case .lugarVazio:
            print("Nada demais por aqui... apenas escuridão.")
            case nil:
            print("Erro.")
        }
        return true
    }
}

let jogo = Jogo()

var continuar = true

repeat {
    continuar = jogo.loopPrincipal()
    print("Posicao personagem: \(jogo.jogador.posicaoPersonagem)")
    print("Posicao porta: \(jogo.mapa.porta)")
    print("Vida atual: \(jogo.jogador.vida)")
    print("\n\n")
} while continuar
