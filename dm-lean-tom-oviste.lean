/- -------
Tom OVISTE 
ATIAM-FPA
2023
LEAN4
------- -/

/- 
Auxiliary functions 
-/

section auxiliary_functions

def repeat_function_n_times {α : Type} (f : α → α) (x : α) (n : Nat) : α :=
  -- Apply the function `f` to the argument `x` a given `n` times.
  match n with
  | 0     => x
  | m+1   => repeat_function_n_times (f) (f x) (m)

def nat_to_int (n : Nat) : Int := n
  -- Convert `n` from type `Nat` to type `Int`.

def int_to_float (n : Int) : Float := 
  -- Convert `n` from type `Int` to type `Float`.
  if n>=0 then Nat.toFloat (Int.toNat n) 
  else - Nat.toFloat (Int.toNat (-n))

def find_element_in_list_on_condition {α : Type} (myList : List α) (myCond : α → Bool) (myIndex : Nat) (myDefault : Nat × α) : (Nat × α) :=
  -- Find the first element in `myList` that satisfies the condition `myCond`.
  -- The index `myIndex` should start at `0` and increase one-by-one.
  -- Return a (found_index, found_element) tuple.
  -- If no correct element is found, return `myDefault`.
  match myList with
  | []    => myDefault
  | x::l  => if (myCond x) then (myIndex, x) else find_element_in_list_on_condition l myCond (myIndex+1) myDefault

def number_of_f_steps_to_reach_condition {α : Type} (myFun : α → α) (x : α) (myCond : α → Bool) (nbSteps : Nat) (maxSteps : Nat) (myDefault : Nat) : Nat :=
  -- Compute the number of times to apply a function `myFun` to an argument `x` until the condition `myCond` is satisfied.
  -- Try a maximum of `maxSteps` times.
  -- The `nbSteps` should start at `0` and increase one-by-one.
  -- If the condition has not been satisfied, return `myDefault`.
  match maxSteps with
  | 0   => myDefault
  | n+1 => if (myCond x) then nbSteps else number_of_f_steps_to_reach_condition (myFun) (myFun x) (myCond) (nbSteps+1) (n) (myDefault)

def find_nth_element_of_list {α : Type} (myList : List α) (n : Nat) (myIndex : Nat) (myDefault : α) : α :=
  -- Parse the `myList` list.
  -- Return the element at index `n`.
  -- If no such element exists, return `myDefault`.
  -- The argument `myIndex` starts at `0` and increases one-by-one to parse the list.
  match myList with
  | []    => myDefault
  | x::l  => if (myIndex == n) then x else find_nth_element_of_list l n (myIndex+1) myDefault

-- Try out the functions.
section tests

#check 5
#check nat_to_int 5
#check int_to_float 5

#eval repeat_function_n_times (λ x => x+5) (4) (7)      -- 39
#eval repeat_function_n_times (λ x => not x) (true) (3) -- false

#eval find_element_in_list_on_condition ([1, 1, 2, 3, 5, 8, 13, 21]) (λ x => x>10) (0) (0,100)   -- (6, 13)
#eval find_element_in_list_on_condition ([1, 1, 2, 3, 5, 8, 13, 21]) (λ x => x==10) (0) (0,100)  -- (0, 100)

#eval number_of_f_steps_to_reach_condition (λ x => x*2) (1) (λ x => x>50) (0) (10) (100)  -- 6
#eval number_of_f_steps_to_reach_condition (λ x => x+2) (1) (λ x => x>50) (0) (10) (100)  -- 100
#eval number_of_f_steps_to_reach_condition (λ (x,y) => (x+5,y)) (2, 16) (λ (x,y) => x>y) (0) (10) (100) -- 3

#eval find_nth_element_of_list ([2, 3, 5, 7, 11, 13, 17]) (4) (0) (100) -- 11
#eval find_nth_element_of_list ([2, 3, 5, 7, 11, 13, 17]) (8) (0) (100) -- 100

end tests

/-
Chroma
-/

-- Define a `Chroma` type.
inductive Chroma where
  | A   : Chroma
  | As  : Chroma
  | B   : Chroma
  | C   : Chroma
  | Cs  : Chroma
  | D   : Chroma
  | Ds  : Chroma
  | E   : Chroma
  | F   : Chroma
  | Fs  : Chroma
  | G   : Chroma
  | Gs  : Chroma

-- Open a namespace to simplify the definition of functions.
namespace Chroma

instance : ToString Chroma where
  -- Define a `ToString` instance to display the `Chroma` type.
  toString : Chroma → String 
    | A   => "La"
    | As  => "La#"
    | B   => "Si"
    | C   => "Do"
    | Cs  => "Do#"
    | D   => "Ré"
    | Ds  => "Ré#"
    | E   => "Mi"
    | F   => "Fa"
    | Fs  => "Fa#"
    | G   => "Sol"
    | Gs  => "Sol#"

def semitone_up : Chroma → Chroma
  -- Go up a semitone from a given chroma.
  | A   => As
  | As  => B
  | B   => C
  | C   => Cs
  | Cs  => D
  | D   => Ds
  | Ds  => E
  | E   => F
  | F   => Fs
  | Fs  => G
  | G   => Gs
  | Gs  => A

def semitone_down : Chroma → Chroma
-- Go down a semitone from a given chroma.
  | A   => Gs
  | As  => A
  | B   => As
  | C   => B
  | Cs  => C
  | D   => Cs
  | Ds  => D
  | E   => Ds
  | F   => E
  | Fs  => F
  | G   => Fs
  | Gs  => G

def inverse : Chroma → Chroma
-- Compute the negative of a given chroma.
  | A   => Ds
  | As  => D
  | B   => Cs
  | C   => C
  | Cs  => B
  | D   => As
  | Ds  => A
  | E   => Gs
  | F   => G
  | Fs  => Fs
  | G   => F
  | Gs  => E

def eq : Chroma → Chroma → Bool
  -- Define an equality condition between two given chromas.
  | A, A    => true
  | As, As  => true
  | B, B    => true
  | C, C    => true
  | Cs, Cs  => true
  | D, D    => true
  | Ds, Ds  => true
  | E, E    => true
  | F, F    => true
  | Fs, Fs  => true
  | G, G    => true
  | Gs, Gs  => true
  | _, _    => false

def distance (c1 c2 : Chroma) : Nat :=
  -- Compute the number of semitones to reach chroma `c2` from chroma `c1`.
  number_of_f_steps_to_reach_condition (semitone_up) (c1) (eq c2) (0) (12) (100)

def n_transpose_up (c : Chroma) (n : Nat) : Chroma :=
  -- Go up `n` semitones from chroma `c`.
  repeat_function_n_times (semitone_up) (c) (n)

def n_transpose_down (c : Chroma) (n : Nat) : Chroma :=
  -- Go down `n` semitones from chroma `c`.
  repeat_function_n_times (semitone_down) (c) (n)

def n_inverse (c : Chroma) (n : Nat) : Chroma :=
  -- Compute the `n`th inversion of chroma `c`.
  n_transpose_up (inverse c) n

-- Close the namespace.
end Chroma

-- Try out the functions.
section tests

#eval Chroma.As                     -- La#
#eval Chroma.eq Chroma.A Chroma.As  -- false

#eval Chroma.semitone_up Chroma.Gs  -- La
#eval Chroma.semitone_down Chroma.C -- Si
#eval Chroma.inverse Chroma.F       -- Sol

#eval Chroma.distance Chroma.G Chroma.A -- 2
#eval Chroma.distance Chroma.A Chroma.G -- 10

#eval Chroma.n_transpose_up Chroma.A 5    -- Ré
#eval Chroma.n_transpose_down Chroma.A 3  -- Fa#
#eval Chroma.n_inverse (Chroma.Ds) 0      -- La
#eval Chroma.n_inverse (Chroma.Fs) 6      -- Do

end tests


/-
Pitch
-/

-- Define a `Pitch` type: a (chroma, octave) tuple.
def Pitch := Chroma × Int

-- Open a namespace to simplify the definition of functions.
namespace Pitch

-- Basic functions to handle the tuple.
def chroma : Pitch → Chroma := λ p => p.fst
def octave : Pitch → Int    := λ p => p.snd

instance : ToString Pitch where
  -- Define a `ToString` instance to display the `Pitch` type.
  toString : Pitch → String := λ p => s!"{chroma p}{octave p}"

def semitone_up : Pitch → Pitch
  -- Go up a semitone from a given pitch.
  | (Chroma.B, o) => (Chroma.C, o+1)
  | (c, o)        => (Chroma.semitone_up c, o)

def semitone_down : Pitch → Pitch
  -- Go down a semitone from a given pitch.
  | (Chroma.C, o) => (Chroma.B, o-1)
  | (c, o)        => (Chroma.semitone_down c, o)

def n_transpose_up (p : Pitch) (n : Nat) : Pitch :=
  -- Go up `n` semitones from pitch `p`.
  repeat_function_n_times (semitone_up) p n

def n_transpose_down (p : Pitch) (n : Nat) : Pitch :=
  -- Go down `n` semitones from chroma `p`.
  repeat_function_n_times (semitone_down) p n

def eq (p1 p2 : Pitch) : Bool :=
  -- Define an equality condition between pitches `p1` and `p2`.
  (octave p1 = octave p2) && (Chroma.eq (chroma p1) (chroma p2))

def distance (p1 p2 : Pitch) : Int :=
  -- Compute the number of semitones to reach pitch `p2` from pitch `p1`.
  let defaultDistance : Nat := 0
  let distanceDown := number_of_f_steps_to_reach_condition (semitone_down) (p1) (eq p2) (0) (100) (defaultDistance)
  let distanceUp := number_of_f_steps_to_reach_condition (semitone_up) (p1) (eq p2) (0) (100) (defaultDistance)
  if distanceUp == defaultDistance then (- nat_to_int distanceDown) else (nat_to_int distanceUp)

def frequency_in_hertz (p : Pitch) : Float :=
  -- Compute the frequency in Hertz of given pitch `p`, considering A3 to be 440Hz.
  let a := (Chroma.A, 3)
  let twelthRootOf2 := 1.0594630943592952646
  let semitoneDistance := distance a p
  440.0 * (Float.pow twelthRootOf2 (int_to_float semitoneDistance))

-- Close the namespace.
end Pitch

-- Try out the functions.
section tests

def myPitch : Pitch := (Chroma.D, 1)
#eval myPitch                                     -- Ré1
#eval (Chroma.D, 1)                               -- (Ré, 1)
#eval Pitch.n_transpose_up (myPitch) 50           -- Mi5

#eval Pitch.eq (Chroma.As, 4) (Chroma.Cs, 4)      -- false
#eval Pitch.eq (Chroma.As, 4) (Chroma.As, 2)      -- false
#eval Pitch.eq (Chroma.As, 3) (Chroma.As, 3)      -- true

#eval Chroma.distance (Chroma.C) (Chroma.A)       -- 9
#eval Chroma.distance (Chroma.A) (Chroma.C)       -- 3
#eval Pitch.distance (Chroma.C, 3) (Chroma.A, 3)  -- 9
#eval Pitch.distance (Chroma.A, 3) (Chroma.C, 3)  -- -9

#eval s!"The frequency of a piano's {myPitch} is {Pitch.frequency_in_hertz myPitch} Hz."

end tests


/-
Triad
-/

-- Define a `Triad` type: a (chroma, chroma, chroma) tuple.
def Triad := Chroma × Chroma × Chroma

-- Open a namespace to simplify the definition of functions.
namespace Triad

-- Basic functions to handle the tuple.
def one : Triad → Chroma := λ t => t.fst
def two : Triad → Chroma := λ t => t.snd.fst
def tre : Triad → Chroma := λ t => t.snd.snd

instance : ToString Triad where
  -- Add a `ToString` instance to display the `Triad` type.
  toString : Triad → String := λ t => s!"{one t}-{two t}-{tre t}"

def list_all_voicings (t : Triad) : (List Triad) :=
  -- Return a list of all possible chord inversions of the triad `t`.
  let c1 := one t; let c2 := two t; let c3 := tre t;
  [t, (c1, c3, c2), (c2, c1, c3), (c2, c3, c1), (c3, c1, c2), (c3, c2, c1)]  

def eval_intervals (t : Triad) : (Int × Int) :=
  -- Compute the intervals between the notes of the triad `t`.
  let c1 := one t; let c2 := two t; let c3 := tre t;
  (Chroma.distance c1 c2, Chroma.distance c1 c3)

def eval_chord_name : (Int × Int) → String
  -- Determine the chord quality of a given triad.
  | (0, 0)  => "unisson"
  | (0, 2)  => "sus2"
  | (0, 3)  => "mineur"
  | (0, 4)  => "majeur"
  | (0, 7)  => "power chord"
  | (2, 3)  => "mineur add9"
  | (2, 4)  => "majeur add9"
  | (2, 7)  => "sus2"
  | (3, 6)  => "diminué"
  | (3, 7)  => "mineur"
  | (3, 10) => "mineur 7"
  | (3, 11) => "mineur-majeur 7"
  | (4, 7)  => "majeur"
  | (4, 8)  => "augmenté"
  | (4, 10) => "dominante 7"
  | (4, 11) => "majeur 7"
  | (5, 7)  => "sus4"
  | (7, 7)  => "power chord"
  | _       => "?"

def find_chord_name (t : Triad) : String :=
  -- Find the quality of the chord `t`.
  -- If unable to find it, return `"?"`.
  let listAllVoicings   := list_all_voicings t                          -- List all possible voicings of t (ex: `[(C, G, E), (C, E, G), ...]`).
  let listAllIntervals  := List.map eval_intervals (listAllVoicings)    -- Compute the chord intervals for each voicing (ex: `[(7,4), (4,7), ...]`).
  let listAllChordNames := List.map eval_chord_name (listAllIntervals)  -- Try to find the chord quality of each voicing (ex: `["?", "majeur", "?", ...]`)
  let validChordName    := find_element_in_list_on_condition (listAllChordNames) (λ x => x != "?") (0) (0,"?")  -- Fetch the one voicing whose quality has been found. (ex: `(1, "majeur")`).
  let validChordIndex   := validChordName.fst                           -- Get the found index (ex: `1`).
  let validChordString  := validChordName.snd                           -- Get the found chord-quality string (ex: `"majeur"`).
  let validChordRoot    := one (find_nth_element_of_list listAllVoicings validChordIndex 0 t) -- Get the corresponding triad's first element (ex: `C`): it's the chord's root note.
  s!"{validChordRoot} {validChordString}"

def semitone_up (t : Triad) : Triad :=
  -- Go up a semitone from the chord `t`.
  (Chroma.semitone_up (one t), Chroma.semitone_up (two t), Chroma.semitone_up (tre t))

def semitone_down (t : Triad) : Triad :=
  -- Go down a semitone from the chord `t`.
  (Chroma.semitone_down (one t), Chroma.semitone_down (two t), Chroma.semitone_down (tre t))

def inverse (t : Triad) : Triad :=
  -- Compute the negative of the chord `t`.
  (Chroma.inverse (one t), Chroma.inverse (two t), Chroma.inverse (tre t))

def n_transpose_up (t : Triad) (n : Nat) : Triad :=
  -- Go up `n` semitones from the chord `t`.
  repeat_function_n_times (semitone_up) t n

def n_transpose_down (t : Triad) (n : Nat) : Triad :=
  -- Go down `n` semitones from the chord `t`.
  repeat_function_n_times (semitone_down) t n

def n_inverse (t : Triad) (n : Nat): Triad :=
  -- Compute the `n`th inverse of the chord `t`.
  n_transpose_up (inverse t) n

end Triad

-- Try out the functions.
section tests

def myTriad1 : Triad := (Chroma.A, Chroma.C, Chroma.G)
#eval myTriad1                        -- La-Do-Sol
#eval Triad.find_chord_name myTriad1  -- La mineur 7

def myTriad2 : Triad := (Chroma.C, Chroma.Fs, Chroma.Ds)
#eval myTriad2                                            -- Do-Fa#-Ré#   
#eval Triad.semitone_up myTriad2                          -- Do#-Sol-Mi
#eval Triad.find_chord_name myTriad2                      -- Do diminué
#eval Triad.find_chord_name (Triad.semitone_up myTriad2)  -- Do# diminué

def myTriad3 : Triad := (Chroma.B, Chroma.C, Chroma.F)
#eval myTriad3                        -- Si-Do-Fa
#eval Triad.find_chord_name myTriad3  -- Si ?

-- Example:
-- Let's define the famous "vi-IV-I-V" chord progression
def myChord6 : Triad := (Chroma.G, Chroma.As, Chroma.D)
#eval myChord6                        -- Sol-La-Ré
#eval Triad.find_chord_name myChord6  -- Sol mineur

def myChord4 : Triad := (Chroma.Ds, Chroma.G, Chroma.As)
#eval myChord4                        -- Ré#-Sol-La
#eval Triad.find_chord_name myChord4  -- Ré# majeur

def myChord1 : Triad := (Chroma.D, Chroma.F, Chroma.As)
#eval myChord1                        -- Ré-Fa-La#
#eval Triad.find_chord_name myChord1  -- La# majeur

def myChord5 : Triad := (Chroma.F, Chroma.A, Chroma.C)
#eval myChord5                        -- Fa-La-Do
#eval Triad.find_chord_name myChord5  -- Fa majeur

-- We can now compute the negative harmony of this chord progression.
-- Since it is in the key of A# major, the axis of major-to-minor symmetry is the 3rd inverse.
#eval Triad.find_chord_name (Triad.n_inverse myChord6 3)  -- Do# majeur
#eval Triad.find_chord_name (Triad.n_inverse myChord4 3)  -- Fa mineur
#eval Triad.find_chord_name (Triad.n_inverse myChord1 3)  -- La# mineur
#eval Triad.find_chord_name (Triad.n_inverse myChord5 3)  -- Ré# mineur

-- It becomes a "III-v-i-iv" progression.
end tests

/- 
END
-/