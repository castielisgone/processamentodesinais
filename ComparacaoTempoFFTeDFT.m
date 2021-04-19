clc
clear all
close all
% Signal
% Number of time points
numeroPontos   = 10000; % BE CAREFUL WITH THIS NUMBER!
                   % DTFT is O(n^2)
% Signal = randn(1,Npoints);
frequenciaAmostragem=50;
Ts=1/frequenciaAmostragem;
tt=(1:10000)*Ts;
sinal = cos(2*pi*50*tt) + cos(2*pi*120*tt) + cos(2*pi*60*tt) + cos(2*pi*100*tt);

sinal1 = cos(2*pi*50*tt + 2*pi*2) + cos(2*pi*120*tt + 2*pi*3) + cos(2*pi*60*tt + 2*pi*4) + cos(2*pi*100*tt + 2*pi*4);


tic;

% Inicio
TempoFourier = (0:numeroPontos-1)/numeroPontos;
coeficientesFourier   = zeros(size(sinal));

for i = 1:numeroPontos
    funcaoComplexa = exp( -1j*2*pi*(i-1)*TempoFourier );
    coeficientesFourier(i) = sum( sinal.*funcaoComplexa );
end

% Tempo DFT
t(1) = toc

% Tempo FFT
tic;
coeificientesFouriersFFT = fft(sinal);
t(2) = toc

Ff = fft(sinal1);

subplot(2,2,1:2)
plot(TempoFourier, 2*abs(coeficientesFourier/numeroPontos))
hold on
subplot(2,1,1)
plot(TempoFourier, 2*abs(coeificientesFouriersFFT/numeroPontos))
title('Frequências do sinal em w')
xlabel('Frequência(Hz)');
ylabel('Amplitude(volt)');
hold on
subplot(2,1,2)
plot(TempoFourier, 2*abs(Ff/numeroPontos))
title('Frequências do sinal com 2*pi*n')
xlabel('Frequência(Hz)');
ylabel('Amplitude(volt)');
%% The Fast Inverse Fourier transform
% IFFT
% 
% % Signal
% FreqRange = 1000;
% time  = 0:1/FreqRange:3;
% SineWave1 = 3 + sin( 2*pi*15*time );
% SineWave2 = 3*cos( sin(2*pi*5*time)+time );
% Signal  = SineWave1 .* SineWave2 .* ( SineWave1 + SineWave2 );
% 
% % % Reconstructed signal using IFFT
% ReconSig = ifft( fft(Signal) );
% % 
% figure(1), clf
% plot(tt,Signal,'r-','linew',2)
% hold on
% plot(tt,ReconSig,'bo','markersize',3)
% xlabel('Time (sec.)'), ylabel('Amplitude')
% legend({'Original';'Reconstructed'})

% Complexidade1 = power(tt, 2)
% Complexidade2 = tt.*log2(tt)
% s = plot(Complexidade1)
% hold on
% r = plot(Complexidade2)
% title('Tempo de resposta para 10000 pontos')
% legend([s, r],'Tempo DFT  - 1.93 ', 'Tempo FFT - 0.0007 ')