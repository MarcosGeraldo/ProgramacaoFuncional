-- ============================================================================
-- DISCIPLINA: Programação Funcional
-- ============================================================================

import Data.Char (toUpper)

-- ----------------------------------------------------------------------------
-- Exercício 1: Função Pura e Cálculo Aritmético
-- ----------------------------------------------------------------------------
-- Objetivo: Computar o Índice de Massa Corporal (IMC). A função deve receber 
-- o peso em quilogramas e a altura em metros, aplicando a fórmula: peso / altura^2.
calculaIMC :: Double -> Double -> Double
calculaIMC peso altura = undefined

-- ----------------------------------------------------------------------------
-- Exercício 2: Controle de Fluxo via Equações Guardadas (Guards)
-- ----------------------------------------------------------------------------
-- Objetivo: Classificar o valor numérico do IMC retornado no exercício anterior 
-- segundo as categorias clínicas padrão.
-- Regras de classificação:
-- Menor que 18.5 - "Abaixo do peso"
-- Entre 18.5 e 24.89 - "Peso normal"
-- Entre 24.9 e 29.89 - "Sobrepeso"
-- Maior ou igual a 29.9 - "Obesidade"

classificaIMC :: Double -> String
classificaIMC imc = undefined

-- ----------------------------------------------------------------------------
-- Exercício 3: Recursão Estrutural e Desestruturação de Listas
-- ----------------------------------------------------------------------------
-- Objetivo: Projetar uma função recursiva que percorra uma lista de inteiros 
-- e retorne a frequência absoluta de ocorrências do valor zero (0).
-- Restrição: Não utilize funções prontas como 'length' ou 'filter'. Aplique 
-- exclusivamente pattern matching sobre a cabeça (head) e cauda (tail) da lista.

contaZeros :: [Int] -> Int
contaZeros = undefined

-- ----------------------------------------------------------------------------
-- Exercício 4: Abstração de Mapeamento (Map)
-- ----------------------------------------------------------------------------
-- Objetivo: Elevar o nível de abstração utilizando a função de ordem superior 'map'.
-- Dada uma lista de temperaturas aferidas em graus Celsius, a função deve 
-- retornar uma nova lista com os valores convertidos para Fahrenheit.
-- Fórmula de conversão: F = C * 1.8 + 32

celsiusParaFahrenheit :: [Double] -> [Double]
celsiusParaFahrenheit temps = undefined

-- ----------------------------------------------------------------------------
-- Exercício 5: Abstração de Filtragem (Filter)
-- ----------------------------------------------------------------------------
-- Objetivo: Empregar a função de ordem superior 'filter' associada a uma 
-- expressão lambda. A função deve receber uma lista de cadeias de caracteres 
-- (Strings) e preservar estritamente aquelas cujo comprimento seja igual ou 
-- superior a 5 caracteres. Permitido o uso do length.

palavrasLongas :: [String] -> [String]
palavrasLongas palavras = undefined

-- ----------------------------------------------------------------------------
-- Exercício 6: Composição Funcional (Mini-Desafio Integrador)
-- ----------------------------------------------------------------------------
-- Objetivo: Orquestrar a execução de 'map' e 'filter' em uma mesma estrutura.
-- A entrada consiste em um banco de dados representado por uma lista de tuplas,
-- onde cada tupla contém o nome de um discente e sua respectiva nota final.
-- A função deve:
-- 1. Filtrar os registros, retendo apenas os discentes aprovados (Nota >= 60.0).
-- 2. Mapear a estrutura resultante, descartando as notas e preservando os nomes.
-- 3. Transmutar todos os caracteres dos nomes para caixa alta (maiúsculas).

nomesAprovados :: [(String, Double)] -> [String]
nomesAprovados alunos = undefined


-- ============================================================================
-- ROTINA PRINCIPAL (SUÍTE DE TESTES AUTOMATIZADOS)
-- ============================================================================

-- Função auxiliar para validar os retornos e formatar a saída no terminal.
testa :: (Eq a, Show a) => String -> a -> a -> IO ()
testa descricao obtido esperado = do
    putStr $ descricao ++ " ... "
    if obtido == esperado
        then putStrLn "[OK]"
        else putStrLn $ "[FALHOU] \n    Esperado: " ++ show esperado ++ "\n    Obtido:   " ++ show obtido

main :: IO ()
main = do
    putStrLn "======================================================="
    putStrLn "INICIANDO BATERIA DE TESTES DE LABORATÓRIO"
    putStrLn "=======================================================\n"
    
    putStrLn "--- Testes do Exercicio 1: calculaIMC ---"
    testa "calculaIMC 100.0 2.0" (calculaIMC 100.0 2.0) 25.0
    testa "calculaIMC 50.0  2.0" (calculaIMC 50.0 2.0) 12.5
    
    putStrLn "\n--- Testes do Exercicio 2: classificaIMC ---"
    testa "IMC 17.5" (classificaIMC 17.5) "Abaixo do peso"
    testa "IMC 22.0" (classificaIMC 22.0) "Peso normal"
    testa "IMC 27.5" (classificaIMC 27.5) "Sobrepeso"
    testa "IMC 31.0" (classificaIMC 31.0) "Obesidade"
    
    putStrLn "\n--- Testes do Exercicio 3: contaZeros ---"
    testa "Lista [0, 1, 0, 2, 0]" (contaZeros [0, 1, 0, 2, 0]) 3
    testa "Lista [1, 2, 3]"       (contaZeros [1, 2, 3]) 0
    testa "Lista Vazia []"        (contaZeros []) 0
    
    putStrLn "\n--- Testes do Exercicio 4: celsiusParaFahrenheit ---"
    testa "Temperaturas [0.0, 10.0, 20.0]" 
          (celsiusParaFahrenheit [0.0, 10.0, 20.0]) 
          [32.0, 50.0, 68.0]
    testa "Lista Vazia []" 
          (celsiusParaFahrenheit []) 
          []
    
    putStrLn "\n--- Testes do Exercicio 5: palavrasLongas ---"
    testa "Filtrando [\"C\", \"Haskell\", \"Java\", \"Go\"]" 
          (palavrasLongas ["C", "Haskell", "Java", "Go"]) 
          ["Haskell"]
    testa "Filtrando [\"Um\", \"Dois\"]" 
          (palavrasLongas ["Um", "Dois"]) 
          []
    
    putStrLn "\n--- Testes do Exercicio 6: nomesAprovados ---"
    let turma1 = [("Ada", 85.5), ("Alan", 45.0), ("Grace", 60.0)]
    let turma2 = [("Linus", 92.0), ("Dennis", 40.0)]
    testa "Turma 1 (Ada aprovada, Grace no limite)" 
          (nomesAprovados turma1) 
          ["ADA", "GRACE"]
    testa "Turma 2 (Apenas Linus)" 
          (nomesAprovados turma2) 
          ["LINUS"]
    testa "Turma Vazia []" 
          (nomesAprovados []) 
          []
          
    putStrLn "\n======================================================="
    putStrLn "TESTES FINALIZADOS"
    putStrLn "======================================================="