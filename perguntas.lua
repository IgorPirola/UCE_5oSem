local Perguntas = {
    lista = {
        {text = [[1. O que é uma variável em programação?

    A. Um botão no teclado.
    B. Um número fixo.
    C. Um espaço na memória para armazenar valores.
    D. Um comando de repetição.]], ativo=true, resp=3, temp=31},

        {text = [[2. O que é um algoritmo?

    A. Uma sequência de imagens.
    B. Um erro comum de código.
    C. Uma instrução para criar tabelas.
    D. Um conjunto de passos lógicos para resolver um problema]], ativo=false, resp=4, temp=31},

        {text = [[3. UTF-8 é:

    A. Uma forma de codificação de pontos de código Unicode.
    B. A 8ª Versão do padrão UTF.
    C. Um sinônimo para byte.
    D. O nome de uma linguagem de programação]], ativo=false, resp=1, temp=31},

        {text = [[4. O que significa responsividade no contexto de web design?

    A. Capacidade de responder a eventos de clique
    B. Integração entre frontend e backend
    C. Capacidade do site se adaptar a diferentes tamanhos de telas
    D. Habilidade de usar inteligência artificial]], ativo=false, resp=3, temp=41},

        {text = [[5. O Código a seguir:

    1 | x = '\''
    2 | print(len(x)) -- imprime tamanho de x

Mostra: 

    A. 20
    B. 3
    C. 2
    D. 1]], ativo=false, resp=4, temp=41},

        {text = [[6. Para que serve o comando if em programação?

    A. Para repetir um bloco várias vezes.
    B. Para tomar decisões com base em condições.
    C. Para criar variáveis.
    D. Para armazenar dados.]], ativo=false, resp=2, temp=31},

        {text = [[7. Qual estrutura repete um bloco de código enquanto uma condição for verdadeira?

    A. try
    B. if
    C. while 
    D. switch]], ativo=false, resp=3, temp=31},

        {text = [[8. Qual é a função da tag <span> em HTML?

    A. Criar uma nova linha
    B. Agrupar pequenos trechos de texto para aplicar estilos
    C. Inserir uma imagem
    D. Definir um título principal]], ativo=false, resp=2, temp=31},

        {text = [[9. Qual elemento HTML é usado para criar um link?

    A. <link>
    B. <a>
    C. <href>
    D. <url>]], ativo=false, resp=2, temp=31},

        {text = [[10. Qual será o comportamento deste botão em HTML se não estiver dentro de um <form>?

    1 | <button type="submit">Enviar</button>

    A. O botão será desabilitado automaticamente
    B. Nada acontece ao clicar
    C. O navegador recarrega a página
    D. O botão age como um botão comum sem função associada]], ativo=false, resp=4, temp=31},

        {text = [[11. Qual dessas opções descreve melhor o CSS?

    A. Uma linguagem de programação de servidor
    B. Um sistema de controle de banco de dados
    C. Uma linguagem para estilizar o conteúdo HTML
    D. Um protocolo de comunicação entre navegadores]], ativo=false, resp=3, temp=31},

        {text = [[12. O que faz a propriedade padding em CSS?

    A. Define o espaço entre o conteúdo e a borda do elemento
    B. Define a margem externa do elemento
    C. Controla a largura do elemento
    D. Controla a opacidade]], ativo=false, resp=1, temp=31},

        {text = [[13. O que o código a seguir faz?

    1 | x = 5
    2 | if (x === "5"){
    3 |    print("Igual")
    4 | } else {
    5 |     print("Diferente")
    6 | }

    A. Compara valor e tipo e imprime "igual"
    B. Imprime "diferente", porque tipos são diferentes
    C. Gera erro, pois x é um número
    D. Imprime "igual", pois 5 é igual a "5"]], ativo=false, resp=2, temp=31},

        {text = [[14. Qual dessas linguagens é mais usada para desenvolvimento web no lado do cliente (front-end)?

    A. C#
    B. Java
    C. JavaScript
    D. Python]], ativo=false, resp=3, temp=31},

        {text = [[15. Qual comando em SQL é usado para buscar todos os dados da tabela ´clientes´?

    A. SHOW ALL clientes;
    B. SELECT * FROM clientes;
    C. SELECT count(*) FROM clientes;
    D. PRINT clientes;]], ativo=false, resp=2, temp=31},

        {text = [[16. O que o seguinte comando SQL faz?

    1 | SELECT * FROM pedidos WHERE valor > 100;

    A. Mostra a quantidade de pedidos com valor maior que 100
    B. Mostra todos os pedidos inseridos na tabela
    C. Mostra todas as informações dos pedidos com valor maior 
    que 100
    D. Atualiza todos os pedidos com valor diferente de 100]], ativo=false, resp=3, temp=36},

        {text = [[17. Qual consulta SQL retorna a quantidade de pedidos por cliente?

    A. SELECT cliente_id FROM pedidos COUNT;
    B. SELECT cliente_id, COUNT(*) FROM pedidos GROUP BY 
    cliente_id; 
    C. GROUP cliente_id FROM pedidos;
    D. SELECT COUNT(cliente_id) WHERE pedidos;]], ativo=false, resp=2, temp=36},

        {text = [[18. Qual desses comandos atualiza o valor da coluna status para 'Cancelado' apenas nos pedidos com valor menor que 100?

    A. UPDATE pedidos WHERE valor < 100 SET status = 'Cancelado';
    B. SET status = 'Cancelado' WHERE valor < 100 FROM pedidos;
    C. UPDATE pedidos SET status = 'Cancelado' WHERE valor < 100;
    D. ALTER pedidos SET status = 'Cancelado' WHERE valor < 100;]], ativo=false, resp=2, temp=46},
    },

    posX = 0,
    posY = 0,
    index = 1
}

return Perguntas
