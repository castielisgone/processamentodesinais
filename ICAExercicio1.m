intervalo = .001;
t = 0:intervalo:1;
funcaoSemRuido  = load('Saudavel.mat')
funcaoSemRuido = funcaoSemRuido.val(1,1:1001)
% funcaoSemRuido = cos(2*pi*50*t) + cos(2*pi*120*t) + cos(2*pi*60*t);
% plot(t, funcaoSemRuido)
funcaoComRuido = funcaoSemRuido +40*randn(size(t));

figure(1);
subplot(2,2,1:2)
q = plot(t, funcaoComRuido, 'c')
hold on
s = plot(t, funcaoSemRuido, 'k')
title('ECG de paciente com Ritmo Sinusal Normal - Mistura')
xlabel('Tempo');
ylabel('Amplitude');
legend([q, s],'Sinal com ruído', 'Sinal sem ruído')

matriz = [funcaoSemRuido;funcaoComRuido]

%Gera dois pesos aleat]orios. Aqui varia N observacoes, se fosse 3
%misturas, n seria 3.
a = rand(2)
%Multiplicando os pesos pela matriz misturada
x = a*matriz

[y,w] = Read_data(matriz)

figure(2);
title('Aplicacao do ICA')
subplot(3, 2, 1)
plot(t, funcaoComRuido)
subplot(3, 2, 2)
plot(x(1, :))
subplot(3, 2, 3)
plot(t, funcaoSemRuido)
subplot(3, 2, 4)
plot(-y(2, :))

