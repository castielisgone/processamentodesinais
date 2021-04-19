clc
clear all
close all


intervalo = .001;
t = 0:intervalo:1;
funcaoSemRuido  = load('Saudavel.mat')
funcaoSemRuido = funcaoSemRuido.val(1,1:1001)
% funcaoSemRuido = cos(2*pi*50*t) + cos(2*pi*120*t) + cos(2*pi*60*t);
% plot(t, funcaoSemRuido)
funcaoComRuido = funcaoSemRuido +10*randn(size(t));
% funcaoComRuido = funcaoSemRuido +2.5*randn(size(t));
figure(1);
subplot(2,2,1:2)
q = plot(t, funcaoComRuido, 'c')
hold on
s = plot(t, funcaoSemRuido, 'k')
title('ECG de paciente com Ritmo Sinusal Normal')
xlabel('Tempo');
ylabel('Amplitude');
legend([q, s],'Sinal com ruído', 'Sinal sem ruído')
n = length(t);
transformadaRapida = fft(funcaoComRuido, n);
PSD =  transformadaRapida.*conj(transformadaRapida)/n;
frequencias = 1/(intervalo*n)*(0:n);
L = 1:floor(n/2);
subplot(2,2,3)
plot(frequencias(L), PSD(L),'r')
title('Frequências antes da filtragem')
xlabel('Frequência(Hz)');
ylabel('Amplitude(volt)');
subplot(2,2,4)
% indices = PSD > 10000000;
indices = PSD > 10000;
% indices = PSD > 10000000;
% indices = PSD > 100;
PSDFiltrada = PSD.*indices;
transformadaRapida = indices.*transformadaRapida;
transformadaInversa = ifft(transformadaRapida);
plot(frequencias(L), PSDFiltrada(L),'-')
% plot(t, transformadaInversa,'-')
title('Frequências após filtragem')
xlabel('Frequência(Hz)');
ylabel('Amplitude(volt)');

% plot(t,transformadaInversa,'-')
% xlabel('Tempo');
% ylabel('Amplitude');
