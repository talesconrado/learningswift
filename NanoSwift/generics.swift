//implementando um tipo genérico, que será uma fila

struct Fila<Element>{
    
    var items = [Element]()
    mutating func adicionar(_ item:Element){
        items.append(item)
    }
    mutating func remover(_ item:Element){
        items.remove(at: 0)
    }
}


//usando um classico do POO........perdao
class Ser{
    var idade:Int
    final let nome:String
    var prioridade:Bool {
        if idade > 60{
            return true
        } else {
            return false
        }
    }

    init(nome:String, idade:Int){
        self.nome = nome
        self.idade = idade
    }

}

class Alien:Ser{
    let quantidadeBracos:Int

    init(nome:String, idade:Int, quantidadeBracos:Int){
        self.quantidadeBracos = quantidadeBracos
        super.init(nome: nome, idade: idade)
    }
}

class Humano:Ser{}

let tales = Humano(nome:"Tales", idade:23)
let etevaldo = Alien(nome: "Etevaldo", idade: 981, quantidadeBracos: 4)

var duplaDinamica = [tales, etevaldo]

if duplaDinamica is [Ser]{
    print("É um array de seres.")
}

for coisa in duplaDinamica{
    if let ser = coisa as? Humano{
        print("O humano \(ser.nome) te diz olá.")
    }
    if let ser = coisa as? Alien{
        print("\"Annyeong!\", disse \(coisa.nome) balançando seus \(ser.quantidadeBracos) braços.")
    }
}


