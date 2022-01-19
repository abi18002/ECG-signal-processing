clc; clear all;close all;
 
%% Load data

 %%% Loading the three recordes
 rec1 = importdata('rec_1m.mat');
 rec2 = importdata('rec_2m.mat');
 rec3 = importdata('rec_3m.mat');
 
 %%% Unfiltered signal "Fisrt row of the signal matrix"
 data1 = rec1(1,:);
 data2 = rec2(1,:);
 data3 = rec3(1,:);
 
 %%% Filtered signal "Second row of the signal matrix"
 F1 = rec1(2,:); 
 F2 = rec2(2,:);
 F3 = rec3(2,:);

%% Ploting the orginal signals

%%% In Time domin

 Fs = 500;            %% the frequency of signals according to info
 Ts = 1/Fs;           %% sampling period of signals
 max = 20;            %% Duration of signals
 time = 0:Ts:max-Ts;  %% Time vector from 0 to 20 sec by 0.002 step
 
%%% Plot all three signals in time domain 
figure; hold on;
subplot(3,1,1); hold on;
plot(time,data1);
title('Signal (rec_1)Orginal');
xlabel('Time(s)')
ylabel('Amplitude')


subplot(3,1,2); hold on;
plot(time,data2);
title('Signal (rec_2)Orginal');
xlabel('Time(s)')
ylabel('Amplitude')


subplot(3,1,3); hold on;
plot(time,data3);
title('Signal (rec_3)Orginal');
xlabel('Time(s)')
ylabel('Amplitude')


%%% In frequency domine

%%% Using fft First Fourier transformation to transform signal into frequency domain
trans_data1 = fft(data1);
trans_data2 = fft(data2);
trans_data3 = fft(data3);

L1 = length(data1); %% Length of signals vector

%%% normalizing signals data 
Y1 = abs(trans_data1)/L1;
Y2 = abs(trans_data2)/L1;
Y3 = abs(trans_data3)/L1;

%%%Take the half of signal domain "we dont need more to analiz signal
P1 = Y1(1:(L1/2)+1);
P2 = Y2(1:(L1/2)+1);
P3 = Y3(1:(L1/2)+1);

f1 = Fs.*(0:(L1/2))/L1;  %% Frequency steps vector

%%% Plot all three signals in frequency domain 
figure; hold on;
subplot(3,1,1); hold on;
plot(f1,P1);
title('Signal (rec_1)Orginal');
xlabel('Frequency (Hz)')
ylabel('Magnitude of FT')


subplot(3,1,2); hold on;
plot(f1,P2);
title('Signal (rec_2)Orginal');
xlabel('Frequency (Hz)')
ylabel('Magnitude of FT')


subplot(3,1,3); hold on;
plot(f1,P3);
title('Signal (rec_3) Orginal');
xlabel('Frequency (Hz)')
ylabel('Magnitude of FT')



%% high pass filter

[b,a] = cheby2(4,20,0.6/(Fs/2),'high'); %% cheby2(order,stopband ripple,stopband-edge frequency)
figure ('name','cheby2'); 
freqz(b,a);    %% Frequency response of digital filter
%%impz(b,a);   %% Impuls response of digital filter
%%stepz(b,a);  %% Step response of digital filter

%%% Zero-phase forward and reverse digital IIR filtering
HPdata1 = filtfilt(b,a,data1);
HPdata2 = filtfilt(b,a,data2);
HPdata3 = filtfilt(b,a,data3);


%%% Plot in time domain "High-pass filter"

figure; hold on;
subplot(3,1,1); hold on;
plot(time,HPdata1);
title('Signal (rec_1)after High-pass filter');
xlabel('Time(s)')
ylabel('Amplitude(mV)')


subplot(3,1,2); hold on;
plot(time,HPdata2);
title('Signal (rec_2)after High-pass filter');
xlabel('Time(s)')
ylabel('Amplitude(mV)')


subplot(3,1,3); hold on;
plot(time,HPdata3);
title('Signal (rec_3)after High-pass filter');
xlabel('Time(s)')
ylabel('Amplitude(mV)')

%%% Plot in frequency domain "High-pass filter"

%%% Fourier transformation
Hi1 = fft(HPdata1);
Hi2 = fft(HPdata2);
Hi3 = fft(HPdata3);

L2 = length(HPdata1);

HP1 = abs(Hi1)/L2;
HP2 = abs(Hi2)/L2;
HP3 = abs(Hi3)/L2;

HiP1 = HP1(1:(L2/2)+1);
HiP2 = HP2(1:(L2/2)+1);
HiP3 = HP3(1:(L2/2)+1);

f2 = Fs.*(0:(L2/2))/L2; %normalizerad


figure; hold on;
subplot(3,1,1); hold on;
plot(f2,HiP1);
title('filtered Signal (rec_1)after High-pass filter');
xlabel('Frequency (Hz)')
ylabel('Magnitude of FT')


subplot(3,1,2); hold on;
plot(f2,HiP2);
title('filtered Signal (rec_2)after High-pass filter');
xlabel('Frequency (Hz)')
ylabel('Magnitude of FT')


subplot(3,1,3); hold on;
plot(f2,HiP3);
title('Signal (rec_3) after High-pass filter');
xlabel('Frequency (Hz)')
ylabel('Magnitude of FT')



%% Moving average Filter


avgFiltB = ones(1,7)/7; %% Window design of 7-points

%%% filtering data using One-dimensional digital filter.
MAdata1 = filter(avgFiltB,1,HPdata1);
MAdata2 = filter(avgFiltB,1,HPdata2);
MAdata3 = filter(avgFiltB,1,HPdata3);

%%% Plot in time domain "Moving average filter"
figure; hold on;
subplot(3,1,1); hold on;
plot(time,MAdata1);
title('Signal (rec_1)after Moving avrege filter ');
xlabel('Time(s)')
ylabel('Amplitude(mV)')


subplot(3,1,2); hold on;
plot(time,MAdata2);
title('Signal (rec_2)after Moving avrege filter');
xlabel('Time(s)')
ylabel('Amplitude(mV)')


subplot(3,1,3); hold on;
plot(time,MAdata3);
title('Signal (rec_3)after Moving avrege filter');
xlabel('Time(s)')
ylabel('Amplitude(mV)')

%%% Plot in frequency domain "Moving average filter"

%%% Fourier transformation
Mo1 = fft(MAdata1);
Mo2 = fft(MAdata2);
Mo3 = fft(MAdata3);

L3 = length(MAdata1);

%normalizerad
MA1 = abs(Mo1)/L3;
MA2 = abs(Mo2)/L3;
MA3 = abs(Mo3)/L3;

MoA1 = MA1(1:(L3/2)+1);
MoA2 = MA2(1:(L3/2)+1);
MoA3 = MA3(1:(L3/2)+1);

f3 = Fs.*(0:(L3/2))/L3;


figure; hold on;
subplot(3,1,1); hold on;
plot(f3,MoA1);
title('Signal (rec_1) after Moving avrege filter');
xlabel('Frequency (Hz)')
ylabel('Magnitude of FT')


subplot(3,1,2); hold on;
plot(f3,MoA2);
title('Signal (rec_2)after Moving avrege filter');
xlabel('Frequency (Hz)')
ylabel('Magnitude of FT')


subplot(3,1,3); hold on;
plot(f3,MoA3);
title('Signal (rec_3)after Moving avrege filter');
xlabel('Frequency (Hz)')
ylabel('Magnitude of FT')



%% Notch filter

%%% Plot in time domain "Notch filter"
% % BandS = designfilt('bandstopiir','Filterorder',4,'HalfPowerFrequency1',7.5,'HalfPowerFrequency2',9.5,'DesignMethod','butter','SampleRate',Fs);
% % Bsdata111 = filter(BandS,MAdata1);
% % Bsdata222 = filter(BandS,MAdata2);
% % Bsdata333 = filter(BandS,MAdata3);


%%% Step 1
%%% Designing a notch bandstop filter designfilt(Bandstop IIR,order,cut-off LOw,cut-off high, type,sample rate)
BandSt = designfilt('bandstopiir','Filterorder',4,'HalfPowerFrequency1',49,'HalfPowerFrequency2',245,'DesignMethod','butter','SampleRate',Fs);
Bsdata11 = filter(BandSt,MAdata1);
Bsdata22 = filter(BandSt,MAdata2);
Bsdata33 = filter(BandSt,MAdata3);

%%% Step 2
%%% Designing a notch bandstop filter designfilt(Bandstop IIR,order,cut-off LOw,cut-off high, type,sample rate)
BandStop = designfilt('bandstopiir','Filterorder',4,'HalfPowerFrequency1',49,'HalfPowerFrequency2',52,'DesignMethod','butter','SampleRate',Fs);
Bsdata1 = filter(BandStop,Bsdata11);
Bsdata2 = filter(BandStop,Bsdata22);
Bsdata3 = filter(BandStop,Bsdata33);

figure; hold on;
subplot(3,1,1); hold on;
plot(time,Bsdata1);
title('Signal (rec_1) Final Edetion');
xlabel('Time(s)')
ylabel('Amplitude(mV)')


subplot(3,1,2); hold on;
plot(time,Bsdata2);
title('Signal (rec_2)Final Edetion');
xlabel('Time(s)')
ylabel('Amplitude(mV)')


subplot(3,1,3); hold on;
plot(time,Bsdata3);
title('Signal (rec_3)Final Edetion');
xlabel('Time(s)')
ylabel('Amplitude(mV)')

%%% Plot in frequency domain "Notch filter"

Bs1 = fft(Bsdata1);
Bs2 = fft(Bsdata2);
Bs3 = fft(Bsdata3);

L = length(Bsdata1);

Ba1 = abs(Bs1)/L;
Ba2 = abs(Bs2)/L;
Ba3 = abs(Bs3)/L;

BaS1 = Ba1(1:(L/2)+1);
BaS2 = Ba2(1:(L/2)+1);
BaS3 = Ba3(1:(L/2)+1);

f = Fs.*(0:(L/2))/L;


figure; hold on;
subplot(3,1,1); hold on;
plot(f,BaS1);
title('Signal (rec_1)Final Edetion');
xlabel('Frequency (Hz)')
ylabel('Magnitude of FT')


subplot(3,1,2); hold on;
plot(f,BaS2);
title('Signal (rec_2)Final Edetion');
xlabel('Frequency (Hz)')
ylabel('Magnitude of FT')


subplot(3,1,3); hold on;
plot(f,BaS3);
title('Signal (rec_3)Final Edetion');
xlabel('Frequency (Hz)')
ylabel('Magnitude of FT')


%% Filtred

%%% In Time domine "Filterd"

 Fs = 500;
 Ts = 1/Fs;
 max = 20;
 time = 0:Ts:max-Ts;
 
figure; hold on;
subplot(3,1,1); hold on;
plot(time,F1);
title('filtered Signal (rec_1)');
xlabel('Time(s)')
ylabel('Amplitude')


subplot(3,1,2); hold on;
plot(time,F2);
title('filtered Signal (rec_2)');
xlabel('Time(s)')
ylabel('Amplitude')


subplot(3,1,3); hold on;
plot(time,F3);
title('filtered Signal (rec_3)');
xlabel('Time(s)')
ylabel('Amplitude')


%%% In frequency domine "Filterd"

a1 = fft(F1);
a2 = fft(F2);
a3 = fft(F3);

l = length(data1);
y1 = abs(a1)/l;
y2 = abs(a2)/l;
y3 = abs(a3)/l;

p1 = y1(1:(l/2)+1);
p2 = y2(1:(l/2)+1);
p3 = y3(1:(l/2)+1);

f = Fs.*(0:(L/2))/L;


figure; hold on;
subplot(3,1,1); hold on;
plot(f,p1);
title('filtered Signal (rec_1)');
xlabel('Frequency (Hz)')
ylabel('Magnitude of FT')


subplot(3,1,2); hold on;
plot(f,p2);
title('filtered Signal (rec_2)');
xlabel('Frequency (Hz)')
ylabel('Magnitude of FT')


subplot(3,1,3); hold on;
plot(f,p3);
title('filtered Signal (rec_3)');
xlabel('Frequency (Hz)')
ylabel('Magnitude of FT')

%% Moving avrege Time
avgFiltB = ones(1,15)/15;
%MAdata1 = filter(avgFiltB,1,HPdata1);
MAdata2 = filter(avgFiltB,1,HPdata2);
MAdata3 = filter(avgFiltB,1,HPdata3);

figure; hold on;
subplot(3,1,1); hold on;
plot(time,Bsdata1);
title('Signal (rec_1)Extra filter ');
xlabel('Time(s)')
ylabel('Amplitude(mV)')


subplot(3,1,2); hold on;
plot(time,MAdata2);
title('Signal (rec_2)Extra filter');
xlabel('Time(s)')
ylabel('Amplitude(mV)')


subplot(3,1,3); hold on;
plot(time,MAdata3);
title('Signal (rec_3)Extra filter');
xlabel('Time(s)')
ylabel('Amplitude(mV)')

%%% Moving avrege freq
%Moo1 = fft(Bsdata1);
Moo2 = fft(Bsdata2);
Moo3 = fft(Bsdata3);

L = length(MAdata1);

%MAa1 = abs(Moo1)/L;
MAa2 = abs(Moo2)/L;
MAa3 = abs(Moo3)/L;

%MoAa1 = MAa1(1:(L/2)+1);
MoAa2 = MAa2(1:(L/2)+1);
MoAa3 = MAa3(1:(L/2)+1);

f = Fs.*(0:(L/2))/L;


figure; hold on;
subplot(3,1,1); hold on;
plot(f,BaS1);
title('Signal (rec_1) Extra filter');
xlabel('Frequency (Hz)')
ylabel('Magnitude of FT')


subplot(3,1,2); hold on;
plot(f,MoAa2);
title('Signal (rec_2)Extra filter');
xlabel('Frequency (Hz)')
ylabel('Magnitude of FT')


subplot(3,1,3); hold on;
plot(f,MoAa3);
title('Signal (rec_3)Extra filter');
xlabel('Frequency (Hz)')
ylabel('Magnitude of FT')


