Tom OVISTE

# ATIAM - FPA
## LEAN4

### Contexte
En feuilletant la documentation de Lean4 (https://lean-lang.org/lean4/doc/), je suis tombé sur un exemple de code, consistant à créer un type *Weekday*. Les jours de la semaine étant cycliques, cela m'a rappelé les notes de musique, et m'a donné l'idée d'implémenter un type *Chroma*, similaire, qui représenterait les douze notes de la gamme chromatique.  
Petit à petit, j'ai entrepris d'y ajouter diverses fonctionnalités, et fini par vouloir implémenter plusieurs notions vues en cours de FPA-Musicologie.  
Une contrainte que je me suis imposée, était que je ne souhaitais pas bêtement passer par une représentation en nombre entiers `[0, 1, ..., 11]` pour réaliser mes opérations. J'ai souhaité définir des types dont je décrirais moi-même rigoureusement les relations d'égalité, de succession, les opérations, etc.

J'ai donc implémenté 3 types, que je décris plus bas : 
- le type *Chroma*, représentant les douze notes de la gamme chromatique ;
    - ex : *C*, *D*, *F*, etc.
- le type *Pitch* , représentant une hauteur de note, définie à partir d'un *Chroma* et d'une valeur (entière) d'octave   ;
    - ex : *(C, 3)*, *(A, 5)*, etc.
- le type *Triad*, représentant un triplet de notes, donc un accord trois-sons ;
    - ex : *(C, E, G)*, *(A, A, B)*, etc.

Tout ce code se trouve dans un unique fichier, __dm-lean-tom-oviste.lean__, joint à ce document.

### Fonctions auxiliaires
Afin de créer et de manipuler ces objets, j'ai eu recours à quelques fonctions auxiliaires.  
Elles servent à réaliser diverses opérations sur les nombres entiers ou sur les listes. Pour la plupart, ce sont des fonctions abstraites, que j'ai écrites de telle sorte qu'elles puissent manipuler n'importe quel type : des entiers, des booléens, des *Chromas*, etc. Elles mettent en valeur la capacité de *Lean* à réaliser de *l'abstraction* (au sens du λ-calcul).  
Le rôle de ces fonctions est documenté dans le code, je ne vais donc pas rentrer dans le détail de leur fonctionnement ici.  

### Type Chroma
Comme expliqué plus haut, j'ai créé un type `Chroma` qui permet de représenter les douze notes de la gamme chromatique.  
Je définis sur ce type des opérations de base : l'incrémentation et la décrémentation d'un demi-ton, l'égalité. Je définis également le négatif : si l'on représente la gamme chromatique sur un cercle, le négatif d'une note correspond à son symétrique par rapport à l'axe *Do-Fa#*. La méthode `match` de Lean4 est particulièrement pratique pour ces définitions.  
J'utilise mes fonctions auxiliaires pour définir des opérations plus complexes : la distance (en demi-tons) entre deux notes, la transposition de `n` demi-tons, la `n`-ième inversion.  
Les explications de code et les fonctions sont commentés, je ne rentre donc pas davantage dans les détails ici.

### Type Pitch
Pour définir complètement la hauteur d'une note, le chroma n'est pas suffisant. Afin de distinguer un *Do3* d'un *Do5*, par exemple, je définis le type `Pitch` comme étant un couple `(Chroma, Nat)`, représentant la note et son octave.  
Je définis sur ce type des opérations similaires à celles que j'ai définies sur le type `Chroma`. Je définis également `Pitch.frequency_in_hertz`, qui permet de calculer la fréquence d'une note donnée. Toutes les fonctions sont relativement simple à comprendre, et documentées dans le code ; je ne rentre pas davantage dans les détails ici non plus.  

Seule particularité : la fonction `Pitch.distance`.
En effet, pour le type `Pitch`, et contrairement au type `Chroma`, il faut pouvoir gérer des quantités de demi-tons **négatives**, et il faut pouvoir distinguer une montée de demi-tons d'une descente. Sans implémenter des conversions de `[C, Cs, D, ...]` vers `[0, 1, 2, ...]`, cela est complexe.  
Après quelques réflexions, j'ai finalement retenu l'implémentation suivante : on "définit une distance jusqu'où chercher", on "cherche une égalité en bas", "on cherche une égalité en haut", et on renvoie le résultat trouvé.

### Type Triad
Tout naturellement, après avoir défini une représentation des notes (avec le type `Chroma`), j'ai souhaité définir une représentation des accords : j'ai donc défini le type `Triad`, comme étant un triplet `(Chroma, Chroma, Chroma)`. Je me suis donc limité aux accords trois-sons, par souci de simplicité ; mais l'implémentation devrait être généralisable facilement à n'importe quelle longueur d'accord. 
Je définis encore une fois, sur ce type, des opérations simples, similaires à celles du type `Chroma`. Enfin, je définis aussi une méthode `Triad.find_chord_name` qui détermine la qualité d'un accord.

### ChatGPT
Lors de ce projet, j'ai, à quelques occasions, demandé de l'aide à ChatGPT. Notamment pour des définitions relativement simples, mais dont je ne connaissais pas la syntaxe exacte.  
Par inattention et par habitude, j'ai supprimé la plupart de mes échanges avec l'outil. Voici un exemple qu'il me reste de *prompt* adressé à ChatGPT :  
"*In Lean, I have a custom type Chroma.  
I want to create a new type, called Note, which is a (Chroma, Nat) pair.*"