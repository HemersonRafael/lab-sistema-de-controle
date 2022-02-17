% Projeto seguidor de degraus + Projeto Observadores de estados

% Dados dos Tanques
g = 981;			% Gravidade em cm/s^2
Km = 4.5 * 3;			% Constante da Bomba vezes Constante do módulo
A1 = 15.5179;			% Área do Tanque 1
A2 = A1;			% Área do Tanque 2
a1 = 0.17813919765; a2 = a1;	% Área dos orifícios de saída
L20 = 15;			% Ponto de operação para linearização
L10 = a2^2/a1^2*L20;

% Modelo dos Tanques em Espaço de estados
A = [-(a1/A1)*sqrt(g/(2*L10)) 0;
	(a1/A2)*sqrt(g/(2*L10)) (-a2/A2)*sqrt(g/(2*L20))];
B = [Km/A1; 0];
C = [0 1];
D = 0;
% polos
ps1 = -1; ps2 = -0.3+0.1i; ps3 = -0.3-0.1i;

% Projeto de um Seguidor de Degraus
Aa = [0 -C;[0; 0] A];
Ba = [0;B];
delta_s = poly([ps1 ps2 ps3]);
qcAa = Aa^3 + delta_s(2)*Aa^2 + delta_s(3)*Aa + delta_s(4)*eye(size(Aa));
Ua = ctrb(Aa, Ba);
Ka = -[0 0 1]*inv(Ua)*qcAa;
K1 = real(Ka(1));
K2 = real([Ka(2) Ka(3)]);

% polos
po1= -0.1+0.1i; po2 = -0.1-0.1i;
%Projeto seguidor de degraus
delta_o = conv([1 -po1], [1 -po2]);
qlA = A^2 + delta_o(2)*A + delta_o(3)*eye(size(A));
V = obsv(A,C);
L =  qlA*inv(V)*[0;1];