//Vou criar um dicionário com base nas associaçoes do que o usuario disser 
//sobre o que uma cor remete para ele

var dictCores = [String: Set<String>]()

for _ in 1...3{
    print("Digite uma cor: ")
    let novaCor = readLine()
    var memorias: Set<String> = []
    if let novaCor = novaCor{
        for _ in 1...4{
            print("Digite algo que te remete essa cor: ")
            let memoria = readLine()
            if let memoria = memoria{
                memorias.insert(memoria)
            }
        }
        dictCores[novaCor] = memorias
    }
}    

print(dictCores)

//Agora vamos testar se o usuário realmente lembra o q ele associou a cada cor (????) Estou sem muita criatividade
