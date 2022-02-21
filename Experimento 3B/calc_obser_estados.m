% Projeto Observadores de estados
%
% A partir de um par de p�los armazenados nas vari�veis p1, p2
% no espa�o de trabalho (workspace) do matlab, calcula a matriz ganhos do
% observador, L que e usada no Simulink para realizar a estima��o dos
% estados do sistema.

% Dados dos Tanques
g = 981;			% Gravidade em cm/s^2
Km = 4.5 * 3;			% Constante da Bomba vezes Constante do m�dulo
A1 = 15.5179;			% �rea do Tanque 1
A2 = A1;			% �rea do Tanque 2
a1 = 0.17813919765; a2 = a1;	% �rea dos orif�cios de sa�da
L20 = 15;			% Ponto de opera��o para lineariza��o
L10 = a2^2/a1^2*L20;

% Modelo dos Tanques em Espa�o de estados
A = [-(a1/A1)*sqrt(g/(2*L10)) 0;
	(a1/A2)*sqrt(g/(2*L10)) (-a2/A2)*sqrt(g/(2*L20))];
B = [Km/A1; 0];
C = [0 1];
D = 0;
% polos
%p1= -1+2i; p2 = -1-2i;
%p1= 1+0.02i; p2 = 1-0.02i;
%p1= -0.2+0.02i; p2 = -0.2-0.02i;
%p1= -0.1+0.01i; p2 = -0.1-0.01i;
p1= -8+1i; p2 = -8-1i;



% Projeto de um Seguidor de Degraus
delta_s = conv([1 -p1], [1 -p2]);
qlA = A^2 + delta_s(2)*A + delta_s(3)*eye(size(A));
V = obsv(A,C);
L =  qlA*inv(V)*[0;1];