//protocolo para implementar um quadrado
protocol Quadrado {
    var tamanhoDoLado: Int { get }
}

//classe Tabuleiro, que recebe um tamanho do lado
class Tabuleiro: Quadrado{
    var tamanhoDoLado: Int
    
    init(tamanhoDoLado:Int){
        self.tamanhoDoLado = tamanhoDoLado
    }
}

//Classe jogo da velha que aplica a criaçao de um tabuleiro na tela do usuario
class TabuleiroDeJogoDaVelha: Tabuleiro {
    var linhasDoTabuleiro: [[String]] = []
    
    //usando override
    override init(tamanhoDoLado:Int){
        super.init(tamanhoDoLado:tamanhoDoLado)
        for _ in 1...tamanhoDoLado{
            linhasDoTabuleiro.append(["_", "|", "_", "|", "_"])
        }
    }

    //printando o tabuleiro
    func mostrarTabuleiro(){
        for linha in linhasDoTabuleiro{
            print(linha.joined())
        }
    }

    //usando closure
    func limparTabuleiro(){
        let limpo = linhasDoTabuleiro.map{ (linha) -> [String] in
            var count = 0
            var novaLinha : [String] = []
            for _ in linha{
                if count % 2 == 0{
                    novaLinha.append("_")
                } else {
                    novaLinha.append("|")
                }
                count += 1
            }
            return novaLinha
        }
        linhasDoTabuleiro = limpo
    }
}

let novoJogo = TabuleiroDeJogoDaVelha(tamanhoDoLado: 3)
novoJogo.mostrarTabuleiro()
novoJogo.limparTabuleiro()
novoJogo.mostrarTabuleiro()