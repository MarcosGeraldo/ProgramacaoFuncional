module Main where

-- ============================================================================
-- 1. ÁRVORE DE SINTAXE ABSTRATA (AST) E AVALIADOR SEMÂNTICO
-- ============================================================================

-- AST recursiva para a linguagem prefixa (literais, soma e multiplicação)
data Expr = Literal Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

-- Avalia recursivamente a AST e computa o valor numérico final
avaliar :: Expr -> Int
avaliar (Literal n)   = n
avaliar (Add e1 e2)   = avaliar e1 + avaliar e2
avaliar (Mul e1 e2)   = avaliar e1 * avaliar e2


-- ============================================================================
-- 2. TIPO PARSER E FUNÇÕES AUXILIARES MANUAIS
-- ============================================================================

-- Tipo do Parser: consome o início do texto e retorna Just (dado, restante) ou Nothing
newtype Parser a = Parser { runParser :: String -> Maybe (a, String) }

-- Remove espaços em branco do início da string via recursão manual
removerEspacos :: String -> String
removerEspacos [] = []
removerEspacos (c:cs)
    | c == ' '  = removerEspacos cs
    | otherwise = c:cs

-- Extrai caracteres numéricos iniciais ('0'..'9') via recursão manual
extrairDigitos :: String -> (String, String)
extrairDigitos [] = ("", "")
extrairDigitos (c:cs)
    | c >= '0' && c <= '9' = 
        let (digitos, resto) = extrairDigitos cs
        in (c : digitos, resto)
    | otherwise = ("", c:cs)

-- Lê o número inicial do texto usando as auxiliares manuais
extrairNumero :: String -> Maybe (Int, String)
extrairNumero texto =
    let (strDigitos, resto) = extrairDigitos (removerEspacos texto)
    in if null strDigitos
       then Nothing
       else Just (read strDigitos, resto)

-- Compara caractere a caractere se o texto inicia com a palavra-chave esperada
casarPrefixo :: String -> String -> Maybe String
casarPrefixo [] resto = Just resto
casarPrefixo _ []     = Nothing
casarPrefixo (p:ps) (c:cs)
    | p == c    = casarPrefixo ps cs
    | otherwise = Nothing


-- ============================================================================
-- 3. PARSERS RECURSIVOS DE EXPRESSÕES
-- ============================================================================

-- Parser para números inteiros literais
parseInt :: Parser Int
parseInt = Parser extrairNumero

-- Processa operadores binários prefixos ("add " ou "mul ") consumindo operando a operando
parseOpBinaria :: String -> (Expr -> Expr -> Expr) -> String -> Maybe (Expr, String)
parseOpBinaria tag construtor texto =
    case casarPrefixo tag (removerEspacos texto) of
        Nothing -> Nothing
        Just