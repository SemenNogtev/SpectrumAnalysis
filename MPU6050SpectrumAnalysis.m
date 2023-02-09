% ������, ������� ������� � ��������� ��������
T1 = 5; % c
T2 = 2; % c
T3 = 1; % c
w1 = 2*pi/T1; % ���/c
w2 = 2*pi/T2; % ���/c
w3 = 2*pi/T3; % ���/c
h1 = 2; % �
h2 = 1; % �
h3 = 0.5; % �

% ������������� � ����� �������
dt = 0.1; % ������ �������������
fs = 1/dt; % ������� �������������
tmax = 10; % ����� �������������
t = 0:dt:tmax; % ������������� �������
N = tmax/dt+1; % ����� ��������

% �������
% h = h1*sin(w1*t) + h2*sin(w2*t) + h3*sin(w3*t); % ������� (�����������)
%plot(t,h)
a = -((w1)^2)*h1*sin(w1*t) -((w2)^2)*h2*sin(w2*t) -((w3)^2)*h3*sin(w3*t); % 2 ����������� ������� (�������� - ��������� �������������)
plot(t,a)
grid on;
title('2 ����������� �������');
xlabel('����� (�)');
ylabel('��������� (�/�^2)');

% ������� �������������� ����� (2-�� ����������� �������)
A = fft(a); % ���
Apositive = A([1:length(A)/2]); % ������ ��� ������������� ������
Apositive = Apositive/(length(Apositive)); % /length(Apositive) ��� ������������ �������
Fpositive = linspace(0,fs/2,length(Apositive)); % ������������� �������
area(Fpositive,abs(Apositive)); % ���������� ������
xlim([0 10]);
grid on;
title('����������� ������ ������� a');
xlabel('������� (��)');
ylabel('������ ���');
hold on
% ���������� ���������� �������������� ����� ������� Sa
[~,locs] = findpeaks(abs(Apositive),'MinPeakHeight',1,...
                                    'MinPeakDistance',0.1);
Fpeaks = Fpositive(locs);
plot(Fpeaks,abs(Apositive(locs)),'rv','MarkerFaceColor','r');
cellpeaks = cellstr(num2str(round(Fpeaks',4)));
text(Fpeaks,abs(Apositive(locs)),cellpeaks,'FontSize',14);
hold off;
Apeaks = abs(Apositive(locs)); % ���� ������� Sa

% ������ ������� (Sh = f(Sa))
Hcomp = abs(Apositive)./(4*pi^2*Fpositive.^2);
area(Fpositive,Hcomp);
xlim([0 10]);
grid on;
title('����������� ������ ������� hcomp');
xlabel('������� (��)');
ylabel('������ ���');
hold on
% % ���������� ���������� �������������� ����� ������� Sh
% [~,locs] = findpeaks(Hcomp,'MinPeakHeight',1,...
%                            'MinPeakDistance',0.1);
% Fpeaks = Fpositive(locs);
plot(Fpeaks,Hcomp(locs),'rv','MarkerFaceColor','r');
cellpeaks = cellstr(num2str(round(Fpeaks',4)));
text(Fpeaks,Hcomp(locs),cellpeaks,'FontSize',14);
hold off;
Hpeaks = Hcomp(locs); % ���� ������� Sh

