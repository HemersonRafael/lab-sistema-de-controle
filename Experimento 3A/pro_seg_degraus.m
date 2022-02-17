% Projeto seguidor de degraus
%
% A partir de um par de p�los armazenados nas vari�veis p1, p2 e p3
% no espa�o de trabalho (workspace) do matlab, calcula os ganhos K1 e K2
% que s�o usados no Simulink para realizar a realimenta��o de estados do 
% tipo seguidor de degraus.

% Dados dos Tanques
g = 981;                        % Gravidade em cm/s^2
Km = 4.5 * 3;                   % Constante da Bomba vezes Constante do m�dulo
A1 = 15.5179;                   % �rea do Tanque 1
A2 = A1;                        % �rea do Tanque 2
a1 = 0.17813919765; a2 = a1;	% �rea dos orif�cios de sa�da
L20 = 15;                       % Ponto de opera��o para lineariza��o
L10 = a2^2/a1^2*L20;

% Modelo dos Tanques em Espa�o de estados
A = [-(a1/A1)*sqrt(g/(2*L10)) 0;
	(a1/A2)*sqrt(g/(2*L10)) (-a2/A2)*sqrt(g/(2*L20))];
B = [Km/A1; 0];
C = [0 1]; 
% polos
%p1= -0.3+0.1i; p2 = -0.3-0.1i; p3 = -1;
p1 = -0.5; p2 = -0.1 + 0.1i; p3 = -0.1 - 0.1i;
Aa = [0 -C;[0; 0] A];
Ba = [0;B];
delta_s = poly([p1 p2 p3]);
qcAa = Aa^3 + delta_s(2)*Aa^2 + delta_s(3)*Aa + delta_s(4)*eye(size(Aa));
Ua = ctrb(Aa, Ba);
Ka = -[0 0 1]*inv(Ua)*qcAa;
K1 = real(Ka(1));
K2 = real([Ka(2) Ka(3)]);

