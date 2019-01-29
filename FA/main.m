clear
clc

DATA = csvread('wine.data')';
DATA = DATA(:, randperm(size(DATA,2)));

for i = 2:14
    DATA(i,:) = (DATA(i,:) ./ max(DATA(i,:))) - 0.5;
end

% - - - - -  Zmienne

L_SIZE = 130;
T_SIZE = 38;

% - - - - -  Przygotowanie danych

a = 1*[1, -1, -1]';
b = 1*[-1, 1, -1]';
c = 1*[-1, -1, 1]';

l_data = zeros(13, L_SIZE);
l_data_default_output = zeros(1, L_SIZE);
l_data_correct = zeros(3, L_SIZE);
t_data = zeros(13, T_SIZE);
t_data_default_output = zeros(1,T_SIZE);
t_data_correct = zeros(3,T_SIZE);

for i = 1:L_SIZE
   l_data(:,i) = DATA(2:14,i);
   l_data_default_output(i) = DATA(1,i);
end

for i = 1:T_SIZE
    t_data(:,i) = DATA(2:14,L_SIZE+i+1);
    t_data_default_output(i) = DATA(1,L_SIZE+i+1);
end

for i=1:L_SIZE
   if l_data_default_output(i) == 1
       l_data_correct(:,i) = a;
   end
   if l_data_default_output(i) == 2
       l_data_correct(:,i) = b;
   end
   if l_data_default_output(i) == 3
       l_data_correct(:,i) = c;
   end
end

for i=1:T_SIZE
   if t_data_default_output(i) == 1
       t_data_correct(:,i) = a;
   end
   if t_data_default_output(i) == 2
       t_data_correct(:,i) = b;
   end
   if t_data_default_output(i) == 3
       t_data_correct(:,i) = c;
   end
end

% - - - - -  Wspolczynniki algorytmu FA

% - - - - -  Konfiguracja sieci
net = feedforwardnet([2,2]);
net = configure(net,l_data,l_data_correct);
net.divideFcn = 'dividetrain';
%view(net);

% - - - - - Algorytm firefly

%FAtraining(net, l_data, l_data_correct,L_SIZE, popsize, maxiter, beta, gamma, alpha, randomBounds)
net = FAtraining(net,l_data,l_data_default_output,L_SIZE,8,120,1.5,0.1,0.8,5);


result = net(l_data);
errMatrixL = zeros(3,3);
for i = 1:L_SIZE
    [maxval,evalIndex] = max(result(:,i));
    %evalIndex
    errMatrixL(evalIndex,l_data_default_output(i)) = errMatrixL(evalIndex,l_data_default_output(i))+1;
end

result = net(t_data);

errMatrix = zeros(3,3);
for i = 1:T_SIZE
    [maxval,evalIndex] = max(result(:,i));
    %evalIndex
    errMatrix(evalIndex,t_data_default_output(i)) = errMatrix(evalIndex,t_data_default_output(i))+1;
end

    
errMatrix

errMatrixL

corrects = (errMatrix(1,1) + errMatrix(2,2) + errMatrix(3,3) ) /T_SIZE;

corrects

result = net(t_data);

