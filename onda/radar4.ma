#include(radar.inc)

[top]
components : radar gen@Generator
link : out@gen in@radar

[gen]
distribution : normal
mean : 100
deviation : 0
initial : 9
increment : 0

[radar]
type : cell
dim: (21,21,3)
delay : transport
defaultDelayTime  : 0
border : nowrapped
neighbors : radar(-1,-1,0) radar(-1,0,0) radar(-1,1,0)
neighbors : radar(0,-1,0)  radar(0,0,0)  radar(0,1,0)  radar(0,0,1) radar(0,0,2)
neighbors : radar(1,-1,0)  radar(1,0,0)  radar(1,1,0)
localtransition : pantalla
zone : onda { (0,0,1)..(19,19,1) }
zone : objetos { (0,0,2)..(19,19,2) }
initialvalue : 0

in : in
link : in in@radar(10,10,1)

[onda]
% nacimiento de la onda del radar
rule : 20 10 { (1,-1,0) = 9 or (1,0,0) = 9 or (1,1,0) = 9 }
rule : 30 10 { (-1,-1,0) = 9 or (-1,0,0) = 9 or (-1,1,0) = 9 }
rule : 40 10 { (-1,1,0) = 9 or (0,1,0) = 9 or (1,1,0) = 9 }
rule : 50 10 { (-1,-1,0) = 9 or (0,-1,0) = 9 or (1,-1,0) = 9 }

% crecimiento de la onda del radar
rule : 20 10 { (1,-1,0) = 20 or (1,0,0) = 20 or (1,1,0) = 20 }
rule : 30 10 { (-1,-1,0) = 30 or (-1,0,0) = 30 or (-1,1,0) = 30 }
rule : 40 10 { (-1,1,0) = 40 or (0,1,0) = 40 or (1,1,0) = 40 }
rule : 50 10 { (-1,-1,0) = 50 or (0,-1,0) = 50 or (1,-1,0) = 50 }

rule : 0 10 { t }

[objetos]
% colisiones
rule : 77 80{ (#Macro(Colision1) or #Macro(Colision2)) }
rule : 77 80{ (0,0,0) = 77 }
rule : 0 80{ #Macro(Colision2b) }

% cruce
rule : { #Macro(Codificacion_Cruce) } 80 { #Macro(Cruce) }
rule : 4.1 80 { (1,1,0) > 88 and trunc(Remainder((1,1,0),10) / 1) = 9 }
rule : 4.2 80 { (1,1,0) > 88 and trunc(Remainder((1,1,0),10) / 1) = 8 }
rule : 8.1 80 { (1,0,0) > 88 and trunc(Remainder((1,0,0),100) / 10) = 9 }
rule : 8.2 80 { (1,0,0) > 88 and trunc(Remainder((1,0,0),100) / 10) = 8 }
rule : 3.1 80 { (-1,1,0) > 88 and trunc(Remainder((-1,1,0),1000) / 100) = 9 }
rule : 3.2 80 { (-1,1,0) > 88 and trunc(Remainder((-1,1,0),1000) / 100) = 8 }
rule : 6.1 80 { (0,-1,0) > 88 and trunc(Remainder((0,-1,0),10000) / 1000) = 9 }
rule : 6.2 80 { (0,-1,0) > 88 and trunc(Remainder((0,-1,0),10000) / 1000) = 8 }
rule : 7.1 80 { (0,1,0) > 88 and trunc(Remainder((0,1,0),100000) / 10000) = 9 }
rule : 7.2 80 { (0,1,0) > 88 and trunc(Remainder((0,1,0),100000) / 10000) = 8 }
rule : 2.1 80 { (1,-1,0) > 88 and trunc(Remainder((1,-1,0),1000000) / 100000) = 9 }
rule : 2.2 80 { (1,-1,0) > 88 and trunc(Remainder((1,-1,0),1000000) / 100000) = 8 }
rule : 5.1 80 { (-1,0,0) > 88 and trunc(Remainder((-1,0,0),10000000) / 1000000) = 9 }
rule : 5.2 80 { (-1,0,0) > 88 and trunc(Remainder((-1,0,0),10000000) / 1000000) = 8 }
rule : 1.1 80 { (-1,-1,0) > 88 and trunc(Remainder((-1,-1,0),100000000) / 10000000) = 9 }
rule : 1.2 80 { (-1,-1,0) > 88 and trunc(Remainder((-1,-1,0),100000000) / 10000000) = 8 }

% movimiento de los objetos
rule : { (-1,-1,0) } 80 { trunc((-1,-1,0)) = 1 }
rule : { (1,-1,0) } 80 { trunc((1,-1,0)) = 2 }
rule : { (-1,1,0) } 80 { trunc((-1,1,0)) = 3 }
rule : { (1,1,0) } 80 { trunc((1,1,0)) = 4 }
rule : { (-1,0,0) } 80 { trunc((-1,0,0)) = 5 }
rule : { (0,-1,0) } 80 { trunc((0,-1,0)) = 6 }
rule : { (0,1,0) } 80 { trunc((0,1,0)) = 7 }
rule : { (1,0,0) } 80 { trunc((1,0,0)) = 8 }

rule : 0 80 { t }

[pantalla]
rule : 2 0 { ((0,0,2) = 1.1 or (0,0,2) = 2.1 or (0,0,2) = 3.1 or (0,0,2) = 4.1 or (0,0,2) = 5.1 or (0,0,2) = 6.1 or (0,0,2) = 7.1 or (0,0,2) = 8.1) and 9 <= (0,0,1) and (0,0,1) <= 50 }
rule : 4 0 { ((0,0,2) = 1.2 or (0,0,2) = 2.2 or (0,0,2) = 3.2 or (0,0,2) = 4.2 or (0,0,2) = 5.2 or (0,0,2) = 6.2 or (0,0,2) = 7.2 or (0,0,2) = 8.2) and 9 <= (0,0,1) and (0,0,1) <= 50 }
rule : 2 0 { (0,0,2) > 88 }
rule : 5 0 { 1 <= (0,0,2) and (0,0,2) < 9 }
rule : 3 0 { (0,0,2) = 77 } 
rule : 1 0 { 9 <= (0,0,1) and (0,0,1) <= 50 }

rule : 0 0 { t }


%  Direcciones objetos
%
%   482
%   7 6
%   351
%
%  Direcciones onda radar (x10)
%
%  22222
%  42225
%  44155
%  43335
%  33333