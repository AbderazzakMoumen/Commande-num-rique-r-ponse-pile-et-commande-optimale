Te = 0.35; % A partir de l'auto-oscillation on donne 0.35 avant c'est 0.01
Km = 6.82/4;
Tau = 0.6; % Correspond au temps au on a 63 de la valeur finale donc quand on a 4.29
zo = exp(-Te/Tau);
num = Km;
den = [Tau,1];
G = tf(num,den);
num_z =  Km*(1-zo);
den_z = [1 -zo];
G_z = tf(num_z,den_z,Te);
%% Auto-oscillations

T = linspace(0,1,500) ;
K = (1/Km)*((1+exp(-T/Tau))./(1-exp(-T/Tau)));
figure
plot(T,K, 'b');

Klim = 2.1;

%% Erreur Statique
Klim = 1;
Erreur = 1/(1+Km*Klim);

%% Mise en œuvre d’une commande à réponse pile
% d = 0 et kdamp = {0.5 0.8 1}.
Kdamp = 1;
Num_z = Kdamp*[1 -zo];
Den_z = Km*(1-zo)*[1 -1];
R = tf(Num_z,Den_z,Te);

%% Mise en œuvre d’une commande LQ à horizon infini
A = -1/Tau;
B = Km/Tau;
C = 1;
D = 0;
sys = ss (A,B,C,D);
Q = 50;
% Faire varier pour voir les changements sur l énergie commande
R = 1;
K =lqr (A,B,Q,R);
Abf = A-B*K;
sys_corrige = ss (Abf, B, C, D);
nyquist (sys_corrige);





