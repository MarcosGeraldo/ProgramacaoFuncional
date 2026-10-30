-- ============================================================================
-- DISCIPLINA: Programação Funcional
-- ============================================================================

import Control.Monad.State

-- ----------------------------------------------------------------------------
-- Exercício 1: Criação de Tipo Algébrico de Dados
-- ----------------------------------------------------------------------------
-- Objetivo: Definir o tipo 'Forma' capaz de representar um 'Circulo' (que possui um raio)
-- ou um 'Retangulo' (que possui largura e altura). Em seguida, implementar a função
-- 'criaQuadrado' que recebe a medida do lado e constrói um 'Retangulo' com lados iguais.

data _ = _
    

criaQuadrado :: _
criaQuadrado _ = undefined

-- ----------------------------------------------------------------------------
-- Exercício 2: Manipulação de TAD via Pattern Matching
-- ----------------------------------------------------------------------------
-- Objetivo: Implementar a função 'calculaArea' que computa a área de uma 'Forma'.
-- Para 'Circulo r': pi * r^2 (utilize a constante 'pi' nativa do Prelude).
-- Para 'Retangulo l a': l * a.

calculaArea :: _
calculaArea _ = undefined

-- ----------------------------------------------------------------------------
-- Exercício 3: Encadeamento Computacional com a Mônada Maybe
-- ----------------------------------------------------------------------------
-- Objetivo: Projetar a função 'processaRaizDaDivisao' que realiza duas operações
-- potencialmente falhas em sequência utilizando a notação 'do' (ou o operador >>=):
-- 1. Divide o dividendo pelo divisor usando 'divisaoSegura'.
-- 2. Extrai a raiz quadrada do resultado obtido usando 'raizSegura'.
-- Se qualquer uma das etapas falhar (retornar Nothing), o resultado global deve ser Nothing.

divisaoSegura :: _

raizSegura :: _

processaRaizDaDivisao :: Double -> Double -> Maybe Double
processaRaizDaDivisao dividendo divisor = undefined

-- ----------------------------------------------------------------------------
-- Exercício 4: Mapeamento em Contexto Opcional (Functor sobre Maybe)
-- ----------------------------------------------------------------------------
-- Objetivo: Aplicar o conceito de Functor ('fmap' ou o operador '<$>') para
-- transformar um valor envelopado em um 'Maybe' sem realizar pattern matching manual.
-- A função 'aplicaDesconto' recebe a taxa de desconto (ex: 0.20 para 20%)
-- e um preço opcional ('Maybe Double'). Se houver um preço ('Just p'), aplica o desconto;
-- caso contrário, preserva 'Nothing'.

aplicaDesconto :: _

-- ----------------------------------------------------------------------------
-- Exercício 5: Instância da Typeclass Functor para Estrutura Recursiva
-- ----------------------------------------------------------------------------
-- Objetivo: Implementar a instância da typeclass 'Functor' para a estrutura
-- de dados 'Lista a' definida abaixo. A função 'fmap' deve percorrer a lista
-- aplicando a transformação 'f' a cada elemento, preservando a estrutura original.

data Lista a = Nil | Cons a (Lista a)
    deriving (Show, Eq)

instance Functor Lista where

-- ----------------------------------------------------------------------------
-- Exercício 6: Manipulação de Estado Puro via Mônada State
-- ----------------------------------------------------------------------------
-- Objetivo: Utilizar a Mônada 'State' (do módulo Control.Monad.State) para criar
-- uma computação estado-dependente. A função 'acumulaValor' deve receber um valor
-- numérico, somá-lo ao estado atual (acumulador) e retornar o novo estado atualizado.
-- Dica: Utilize 'get' e 'put', ou a função 'modify'.

acumulaValor :: _



-- ============================================================================
-- ROTINA PRINCIPAL (SUÍTE DE TESTES AUTOMATIZADOS)
-- ============================================================================

testa :: (Eq a, Show a) => String -> a -> a -> IO ()
testa descricao obtido esperado = do
    putStr $ descricao ++ " ... "
    if obtido == esperado
        then putStrLn "[OK]"
        else putStrLn $ "[FALHOU] \n    Esperado: " ++ show esperado ++ "\n    Obtido:   " ++ show obtido

main :: IO ()
main = do
    putStrLn "======================================================="
    putStrLn "INICIANDO BATERIA DE TESTES DE LABORATÓRIO - MÓDULO 2"
    putStrLn "=======================================================\n"
    
    putStrLn "--- Testes do Exercicio 1: criaQuadrado ---"
    testa "Quadrado de lado 5.0" (criaQuadrado 5.0) (Retangulo 5.0 5.0)
    testa "Quadrado de lado 2.5" (criaQuadrado 2.5) (Retangulo 2.5 2.5)
    
    putStrLn "\n--- Testes do Exercicio 2: calculaArea ---"
    testa "Area de Retangulo (3x4)" (calculaArea (Retangulo 3.0 4.0)) 12.0
    testa "Area de Circulo (raio 2.0)" (calculaArea (Circulo 2.0)) (pi * 4.0)
    
    putStrLn "\n--- Testes do Exercicio 3: processaRaizDaDivisao ---"
    testa "Divisao 32 / 2 e Raiz (Sucesso)" (processaRaizDaDivisao 32.0 2.0) (Just 4.0)
    testa "Divisao por Zero (Falha)"        (processaRaizDaDivisao 32.0 0.0) Nothing
    testa "Raiz de Numero Negativo (Falha)"  (processaRaizDaDivisao (-16.0) 1.0) Nothing
    
    putStrLn "\n--- Testes do Exercicio 4: aplicaDesconto ---"
    testa "Desconto de 20% em Just 100.0" (aplicaDesconto 0.20 (Just 100.0)) (Just 80.0)
    testa "Desconto de 15% em Nothing"    (aplicaDesconto 0.15 Nothing) Nothing
    
    putStrLn "\n--- Testes do Exercicio 5: Functor Lista ---"
    let listaNumeros = Cons 1 (Cons 2 (Cons 3 Nil))
    testa "fmap (*2) em Lista" (fmap (*2) listaNumeros) (Cons 2 (Cons 4 (Cons 6 Nil)))
    testa "fmap (+5) em Nil"   (fmap (+5) Nil) (Nil :: Lista Int)
    
    putStrLn "\n--- Testes do Exercicio 6: acumulaValor (State) ---"
    testa "runState (acumulaValor 15) 50" (runState (acumulaValor 15) 50) (65, 65)
    testa "execState (acumulaValor 20) 10" (execState (acumulaValor 20) 10) 30
    
    putStrLn "\n======================================================="
    putStrLn "TESTES FINALIZADOS"
    putStrLn "======================================================="