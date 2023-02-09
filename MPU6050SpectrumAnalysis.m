% Период, угловая частота и амплитуда гармоник
T1 = 5; % c
T2 = 2; % c
T3 = 1; % c
w1 = 2*pi/T1; % рад/c
w2 = 2*pi/T2; % рад/c
w3 = 2*pi/T3; % рад/c
h1 = 2; % м
h2 = 1; % м
h3 = 0.5; % м

% Дискретизация и время выборки
dt = 0.1; % период дискретизации
fs = 1/dt; % частота дискретизации
tmax = 10; % время моделирования
t = 0:dt:tmax; % дискретизация времени
N = tmax/dt+1; % число отсчетов

% Функция
% h = h1*sin(w1*t) + h2*sin(w2*t) + h3*sin(w3*t); % функция (неизвестная)
%plot(t,h)
a = -((w1)^2)*h1*sin(w1*t) -((w2)^2)*h2*sin(w2*t) -((w3)^2)*h3*sin(w3*t); % 2 производная функции (известна - показания акселерометра)
plot(t,a)
grid on;
title('2 производная функции');
xlabel('Время (с)');
ylabel('Ускорение (м/с^2)');

% Быстрое Преобразование Фурье (2-ой производной функции)
A = fft(a); % БПФ
Apositive = A([1:length(A)/2]); % Спектр для положительных частот
Apositive = Apositive/(length(Apositive)); % /length(Apositive) для нормализации спектра
Fpositive = linspace(0,fs/2,length(Apositive)); % Положительные частоты
area(Fpositive,abs(Apositive)); % Отобразить спектр
xlim([0 10]);
grid on;
title('Амплитудный спектр сигнала a');
xlabel('Частота (Гц)');
ylabel('Модуль БПФ');
hold on
% Нахождение максимумов действительной части спектра Sa
[~,locs] = findpeaks(abs(Apositive),'MinPeakHeight',1,...
                                    'MinPeakDistance',0.1);
Fpeaks = Fpositive(locs);
plot(Fpeaks,abs(Apositive(locs)),'rv','MarkerFaceColor','r');
cellpeaks = cellstr(num2str(round(Fpeaks',4)));
text(Fpeaks,abs(Apositive(locs)),cellpeaks,'FontSize',14);
hold off;
Apeaks = abs(Apositive(locs)); % пики спектра Sa

% Спектр функции (Sh = f(Sa))
Hcomp = abs(Apositive)./(4*pi^2*Fpositive.^2);
area(Fpositive,Hcomp);
xlim([0 10]);
grid on;
title('Амплитудный спектр сигнала hcomp');
xlabel('Частота (Гц)');
ylabel('Модуль БПФ');
hold on
% % Нахождение максимумов действительной части спектра Sh
% [~,locs] = findpeaks(Hcomp,'MinPeakHeight',1,...
%                            'MinPeakDistance',0.1);
% Fpeaks = Fpositive(locs);
plot(Fpeaks,Hcomp(locs),'rv','MarkerFaceColor','r');
cellpeaks = cellstr(num2str(round(Fpeaks',4)));
text(Fpeaks,Hcomp(locs),cellpeaks,'FontSize',14);
hold off;
Hpeaks = Hcomp(locs); % пики спектра Sh

