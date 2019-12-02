:-use_module(library(clpfd)).

fila_carros(Colors):-
    Colors = [_, _, _, _],
    Sizes = [_, _, _, _],
    domain(Colors, 1, 4), domain(Sizes, 1, 4), Yellow = 1, Blue = 2, Green = 3, Black = 4,
    all_distinct(Colors), all_distinct(Sizes),
    
   element(PosYellow, Colors, Yellow),
   element(PosBlue, Colors, Blue),
   element(PosGreen, Colors, Green),
   element(PosBlack, Colors, Black),

   element(SizeYellow, Sizes, PosYellow),
   element(SizeBlue, Sizes, PosBlue),
   element(SizeGreen, Sizes, PosGreen),
   element(SizeBlack, Sizes, PosBlack),

   % o carro que está imediatamente antes do carro azul é menor do que o que está imediatamente depois do carro azul
   element(PosBefBlue, Sizes, SizeBefBlue), 
   element(PosAftBlue, Sizes, SizeAftBlue), 
   PosBefBlue #= PosBlue - 1, 
   PosAftBlue #= PosBlue + 1, 
   SizeBefBlue #< SizeAftBlue,

   % o carro verde é o menor de todos
   SizeGreen #< SizeBlue,
   SizeGreen #< SizeYellow,
   SizeGreen #< SizeBlack,

   % o carro verde está depois do carro azul
   PosGreen #= PosBlue + 1,

   % o carro amarelo está depois do preto
   PosYellow #> PosBlack,

   labeling([], Colors),
   labeling([], Sizes).
   