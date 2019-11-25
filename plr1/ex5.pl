:-use_module(library(clpfd)).

guardas(L):-
    L=[G11,G12,G13,G14,G15, G16,
       G21, 0 , 0 , 0 , 0 , G26,
       G31, 0 , 0 , 0 , 0 , G36,
       G41, 0 , 0 , 0 , 0 , G46,
       G51, 0 , 0 , 0 , 0 , G56,
       G61,G62,G63,G64,G65, G66],

    domain(L, 0, 12),
    
    G11 + G12 + G13 + G14 + G15 + G16 #= S1,
    G11 + G21 + G31 + G41 + G51 + G61 #= S1,
    G16 + G26 + G36 + G46 + G56 + G66 #= S1,
    G61 + G62 + G63 + G64 + G65 + G66 #= S1,
    S1 #= 5,

    G11 + G12 + G13 + G14 + G15 + G16 + G21 + G31 + G41 + G51 + G61 + G26 + G36 + G46 + G56 + G66 + G62 + G63 + G64 + G65 #= S2,
    S2 #= 12,
    labeling([], L),
    write(L).
    