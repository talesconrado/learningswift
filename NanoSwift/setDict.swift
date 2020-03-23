//Vou criar um dicionário com base nas associaçoes do que o usuario disser 
//sobre o que uma cor remete para ele

var dictCores = [String: Set<String>]()

for _ in 1...2{
    print("Digite uma cor: ")
    let novaCor = readLine()
    var memorias: Set<String> = []
    if let novaCor = novaCor{
        for _ in 1...2{
            print("Digite algo que te remete essa cor: ")
            let memoria = readLine()
            if let memoria = memoria{
                memorias.insert(memoria)
            }
        }
        dictCores[novaCor] = memorias
    }
}    

//Agora vamos testar se o usuário realmente lembra o q ele associou a cada cor (????) 
//Estou sem muita criatividade :/
enum Lembrando{
    case pouco
    case medio
    case tudo
}

var contador = 0

for (cor, conjuntoDeMemorias) in dictCores{
    print("Diga que cor isso te lembra: ")
    for memoria in conjuntoDeMemorias{
        print(memoria)
    }
    let resposta = readLine()
    if let resposta = resposta, resposta == cor{
        contador += 1
    }
    print("Próxima.")
}

var resultado:Lembrando

if contador == 0 {
    resultado = .pouco
} else if contador==1 {
    resultado = .medio
} else {
    resultado = .tudo
}

switch resultado {
case .pouco:
    print("Memória fraca.")
case .medio:
    print("Tá até ok.")
case .tudo:
    print("Boa.")
}


