
# Lógica

## Tipos básicos de dados em C# - PARTE 1
- C# é uma linguagem estaticamente tipada
- Tipos valor pré-definidos em C#
- Tipos referência pré-definidos em C#
- Variável não atribuída
- Overflow
- Padrão para float: sufixo "f"
- Padrão para char: aspas simples
- Padrão para string: aspas duplas
- Padrão para bool: true, false
- Opção: inferência de tipos com palavra "var" (dentro de métodos)

|C# Type    |.Net Framework Type |Signed     |Bytes  | Possible Values                                              |
|:---------:|:------------------:|:---------:|:-----:|:------------------------------------------------------------:|
|sbyte      |System.Sbyte        |   Yes     |  1    |-128 to 127                                                   |
|short      |System Int16        |   Yes     |  2    | -32768 to 32767                                              |
|int        |System. Int32       |   Yes     |  4    |-2^31 to 2^31. 1                                              |
|long       |System.Int64        |   Yes     |  8    | -2^63 to 2^63.1                                              |
|byte       |System.Byte         |   No      |  1    |0 to 255                                                      |
|ushort     |System.Uint16       |   No      |  2    | 0 to 65535                                                   |
|uint       |System.Uint32       |   No      |  4    | 0 to 2^32-1                                                  |
|ulong      |System.Uint64       |   No      |  8    |0 to 2^64-1                                                   |
|float      |System. Single      |   Yes     |  4    | 11.5x 10-to 3.4 x 103 with 7 significant figures             |
|double     |System.Double       |   Yes     |  8    | 5.0 x 10 to 11.7 x 10.0with 15 or 16 significant figures     |
|decimal    |System.Decimal      |   Yes     |  12   |+1.0 x 10-2 to 37.9 x 10' with 28 or 29 significant figures   |
|char       |System.Char         |   N/A     |  2    |Any Unicode character                                         |
|bool       |System.Boolean      |   N/A     |  1/2  |true or false                                                 |


## Tipos básicos de dados em C# - PARTE 2

```
bool completo = false;
char genero = 'F';
char letra = '\u0041';
byte n1 = 126;
int n2 = 1000;
int n3 = 2147483647;
long n4 = 2147483648L;
float n5 = 4.5f;
double n6 = 4.5;
String nome = "Maria Green";
Object obj1 = "Alex Brown";
Object obj2 = 4.5f;
Console.WriteLine(completo);
Console.WriteLine(genero);
Console.WriteLine(letra);
Console.WriteLine(n1);
Console.WriteLine(n2);
Console.WriteLine(n3);
Console.WriteLine(n4);
Console.WriteLine(n5);
Console.WriteLine(n6);
Console.WriteLine(nome);
Console.WriteLine(obj1);
Console.WriteLine(obj2);
```

- Funções para valores mínimos e máximos
    - int.MinValue
    - int.MaxValue
    - sbyte.MaxValue
    - long.MaxValue
    - decimal.MaxValue
## Restrições e convenções para nomes
- Restrições e convenções para nomes
    - Não pode começar com dígito: use uma letra ou _
    - Não usar acentos ou til
    - Não pode ter espaço em branco
    - Sugestão: use nomes que tenham um significado

- Convenções
    - Camel Case: lastName (parâmetros de métodos, variáveis dentro de métodos)
    - Pascal Case: LastName (namespaces, classe, properties e métodos)
    - Padrão _lastName (atributos "internos" da classe)
## Saída de dados em C#
- Comandos
    - Console.WriteLine( valor );
    - Console.Write( valor );
- Arredonda as casas decimais
    - .ToString("F4");
- Formatar o número com um format provider     10,53555145 para 10.54
    - Tem que adicionar um using
```
using System.Globalization;
```
    - Console.WriteLine(saldo.ToString("F4", CultureInfo.InvariantCulture));

- Interpolação
```
int idade = 32;
double saldo = 10.35784;
String nome = "Maria";
Console.WriteLine("{0} tem {1} anos e tem saldo igual a {2:F2} reais", nome, idade, saldo);
Console.WriteLine($"{nome} tem {idade} anos e tem saldo igual a {saldo:F2} reais");
```
## Operadores de atribuição
| Operador |    Exemplo |   Significado     |
|:--------:|:----------:|:-----------------:|
|   =      |   a = 10;  | a **RECEBE** 10   |  
|   +=     |   a += 2;  | a **RECEBE** a + 2|   
|   -=     |   a -= 2;  | a **RECEBE** a - 2|   
|   *=     |   a *= 2;  | a **RECEBE** a * 2|   
|   /=     |   a /= 2;  | a **RECEBE** a / 2|   
|   %=     |   a %= 2;  | a **RECEBE** a % 2|   

- Operadores aritméticos / Atribuição

| Operador |        Exemplo  | Significado |
|:--------:|:---------------:|:-----------:|
|   ++     |   a++; ou ++a;  | a = a + 1   |  
|   --     |   a--; ou --a;  | a = a - 1   |  

## Conversão implícita e casting
|De	    | Para|
|:-----:|:---:|
|sbyte	| short, int, long, float, double, decimal ou nint|
|byte	| short, ushort, int, uint, long, ulong, float, double, decimal, nint ou nuint|
|short	| int, long, float, doubleou , ou decimal, ou nint|
|ushort	| int, uint, long, ulong, , float, doubleou decimal, nintou , ou nuint|
|int	| long, floatou doubledecimal,nint|
|Uint	| long, ulong, float, doubleou , ou decimal, ou nuint|
|longo	| float, double ou decimal|
|ulong	| float, double ou decimal|
|float	| double|
|nint	| long, float, double ou decimal|
|nuint	| ulong, float, double ou decimal|

- **Conversão implícita**
```  
float a = 10.569F;
double b = a;
Console.WriteLine(b);
```  
- Sem problemas, pois vai de uma capacidade menor para maior
- **Conversão explícita**
```  
double a = 10.848484;
int b = (int)a;
Console.WriteLine(b);
```  
- pode ocorrer perda de informações

## Operadores aritméticos

| Operador |     Significado  |
|:--------:|:----------------:|
|    +     | Adição           |  
|    -     | Subtração        |  
|    *     | Multiplicação    |  
|    /     | Divisão          |  
|    %     | Resto da divisão |  
## Entrada de dados em C# - PARTE 1
- Console.ReadLine();
    - Lê da entrada padrão até a quebra de linha.
    - Retorna os dados lidos na forma de string.

```
string s = Console.ReadLine();
//"batata tomate abacaxi"
string[] vet = s.Split(' ');
// ou
string[] vet = Console.ReadLine().Split(' ');

string p1 = vet[0];
string p2 = vet[1];
string p3 = vet[2];  
```  
## Entrada de dados em C# - PARTE 2

## Exercícios propostos - PARTE 1

## Operadores comparativos

## Operadores lógicos

## Estrutura condicional (if-else)

## Escopo e inicialização

## Exercícios propostos - PARTE 2

## Funções (sintaxe)

## Debugging com Visual Studio

## Estrutura repetitiva enquanto (while)

## Exercícios propostos - PARTE 3

## Estrutura repetitiva para (for)

## Exercícios propostos - PARTE 4


## Referências
[Tabela de conversão](https://docs.microsoft.com/pt-br/dotnet/csharp/language-reference/builtin-types/numeric-conversions)