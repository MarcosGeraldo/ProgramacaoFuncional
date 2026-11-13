-- ============================================================================
-- DISCIPLINA: Programação Funcional / Verificação Formal
-- TÓPICO ESPECIAL: Introdução à Verificação de Programas em Lean 4
-- Prof. Marcos Emiliano
-- ============================================================================

-------------------------------------------------------------------------------
-- BLOCO 1: TIPOS DE DADOS E FUNÇÕES (PARALELO HASKELL vs. LEAN 4)
-------------------------------------------------------------------------------

-- 1. Definição Indutiva de Lista Customizada
inductive MinhaLista (α : Type) where
  | nil  : MinhaLista α
  | cons : α → MinhaLista α → MinhaLista α
  deriving Repr

-- 2. Função Recursiva Pura para Soma de Elementos
def somaLista : List Nat → Nat
  | []      => 0
  | x :: xs => x + somaLista xs

-- 3. Função Map Genérica
def meuMap {α β : Type} (f : α → β) : List α → List β
  | []      => []
  | x :: xs => f x :: meuMap f xs

#eval somaLista [1, 2, 3, 4]             -- Saída: 10
#eval meuMap (fun x => x * 2) [1, 2, 3]  -- Saída: [2, 4, 6]


-------------------------------------------------------------------------------
-- BLOCO 2: TEOREMAS DE LÓGICA PROPOSICIONAL (MATEMÁTICA DISCRETA)
-------------------------------------------------------------------------------

-- F → F = T
-- T → T = T
-- Teorema 1: Comutatividade da Conjunção (P ∧ Q → Q ∧ P)
theorem conj_comm (P Q : Prop) : P ∧ Q → Q ∧ P := by
  intro ⟨hp, hq⟩
  exact ⟨hq, hp⟩

-- Teorema 2: Silogismo Hipotético / Transitividade da Implicação
theorem silogismo_hipotetico (P Q R : Prop) : (P → Q) → (Q → R) → (P → R) := by
  intro hpq hqr hp
  exact hqr (hpq hp)

-- Teorema 3: Comutatividade da Disjunção (P ∨ Q → Q ∨ P)
theorem disj_comm (P Q : Prop) : P ∨ Q → Q ∨ P := by
  intro h
  cases h with
  | inl hp => exact Or.inr hp
  | inr hq => exact Or.inl hq


-------------------------------------------------------------------------------
-- BLOCO 3: PROVAS DE PROPRIEDADES DE PROGRAMAS
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- PROVA 1: Comutatividade da Soma de Números Naturais (x + y = y + x)
-------------------------------------------------------------------------------

theorem soma_comutativa (x y : Nat) : x + y = y + x := by
  induction x with
  | zero => simp
  | succ x ih =>
    simp [Nat.succ_add]
    simp [ ih]
    simp [Nat.add_assoc]


-------------------------------------------------------------------------------
-- PROVA 2: Correção da Inversão de Lista (xs.reverse.reverse = xs)
-------------------------------------------------------------------------------

theorem reverse_append_demo {α : Type} (xs ys : List α) :
    (xs ++ ys).reverse = ys.reverse ++ xs.reverse := by
  induction xs with
  | nil => simp
  | cons x xs ih => simp [ih]

theorem reverse_reverse_demo {α : Type} (xs : List α) :
    xs.reverse.reverse = xs := by
  induction xs with
  | nil => simp
  | cons x xs ih => simp [ih]


-------------------------------------------------------------------------------
-- PROVA 3: Correção Total do Insertion Sort (Tamanho + Ordenação)
-------------------------------------------------------------------------------

-- Implementação do Insertion Sort
def insercao (x : Nat) : List Nat → List Nat
  | []      => [x]
  | y :: ys => if x ≤ y then x :: y :: ys else y :: insercao x ys

def insertionSort : List Nat → List Nat
  | []      => []
  | x :: xs => insercao x (insertionSort xs)

-- Propriedade A: Preservação do tamanho da lista
theorem length_insercao (x : Nat) (xs : List Nat) :
    (insercao x xs).length = xs.length + 1 := by
  induction xs with
  | nil => simp [insercao]
  | cons y ys ih =>
    simp [insercao]
    split <;> simp [ih]

theorem length_insertionSort (xs : List Nat) :
    (insertionSort xs).length = xs.length := by
  induction xs with
  | nil => simp [insertionSort]
  | cons x xs ih => simp [insertionSort, length_insercao, ih]

-- Propriedade B: Garantia de Ordenação (Predicado Formal)
def Sorted : List Nat → Prop
  | []           => True
  | [_]          => True
  | x :: y :: zs => x ≤ y ∧ Sorted (y :: zs)

theorem sorted_insercao (x : Nat) (xs : List Nat) (h : Sorted xs) :
    Sorted (insercao x xs) := by
  induction xs with
  | nil => simp [insercao, Sorted]
  | cons y ys ih =>
    simp only [insercao]
    split
    · simp_all [Sorted]
    · cases ys with
      | nil => simp [insercao, Sorted]; omega
      | cons z zs =>
        simp only [Sorted] at h
        have ih_z := ih h.2
        simp only [insercao] at ih_z ⊢
        split <;> simp_all [Sorted] <;> omega

theorem sorted_insertionSort (xs : List Nat) : Sorted (insertionSort xs) := by
  induction xs with
  | nil => simp [insertionSort, Sorted]
  | cons x xs ih =>
    simp only [insertionSort]
    exact sorted_insercao x (insertionSort xs) ih

#eval insertionSort [7, 2, 9, 1, 5, 3] -- Saída: [1, 2, 3, 5, 7, 9]
