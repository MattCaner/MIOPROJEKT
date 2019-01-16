clear
clc

DATA = csvread('transfusion.data');

% - - - - -  Zmienne

L_SIZE = 200;
T_SIZE = 50;

% - - - - -  Przygotowanie danych

l_data = zeros(L_SIZE,4);
l_data_correct = zeros(L_SIZE,1);
t_data = zeros(T_SIZE,4);
t_data_correct = zeros(T_SIZE,1);

for i = 1:L_SIZE
   l_data(i,:) = DATA(i,1:4);
   l_data_correct(i) = DATA(i,5);
end

for i = 1:T_SIZE
    t_data(i,:) = DATA(i+L_SIZE+1,1:4);
    t_data_correct(i) = DATA(i+L_SIZE+1,5);
end

l_data = l_data';
l_data_correct = l_data_correct';
t_data = t_data';
t_data_correct = t_data_correct';


% - - - - -  Wspolczynniki algorytmu FA

popsize = 10;
randombounds = 10;
gamma = 0.091;
maxiter = 20;
beta = 0.8;
alpha = 0.2;

% - - - - -  Konfiguracja sieci

net = feedforwardnet([2,1,2]);
net = configure(net,l_data,l_data_correct);
net.divideFcn = 'dividetrain';
%view(net);

% - - - - - Algorytm firefly

% - Generacja populacji

dimensions = 20;

fireflies = zeros(popsize,dimensions);
fireflies_light = zeros(popsize,1);
bestfirefly = zeros(1,dimensions);
bestmse = 10^5;
bestiterfound = 0;

for i = 1:popsize
   for j = 1:dimensions
       fireflies(i,j) = (rand-1)*2*randombounds;
   end
end

% - wygenerowanie swiatla poczatkowego

for f=1:popsize
    faval;
   
end

% GLOWNA PETLA PROGRAMU

for iterator = 1:maxiter
    iterator
    for k = 1:popsize
        k
        for m = 1:popsize
           if fireflies_light(m)>fireflies_light(k)
              %m
              %k
              %fireflies_light(m)
              %fireflies_light(k)
              r = 0;
              for dims = 1:dimensions
                 r = r+(fireflies(m,dims)-fireflies(k,dims))^2; 
              end
              r = sqrt(r);
              BETA = beta*exp(-gamma*r);
              for dims = 1:dimensions

                 fireflies(k,dims) = fireflies(k,dims) +BETA*(fireflies(m,dims)-fireflies(k,dims))+alpha*(rand()-1);
              end
              
                  iter = 1;
                  
                  f = k;
                  faval;
                  
                  if mse<bestmse
                      bestmse = mse;
                      bestfirefly = fireflies(k,:);
                      bestiterfound = iterator
                  end
           end
        end
    end
end

bestmse
bestfirefly

fireflies(1,:) = bestfirefly;
f=1;
faval;



corrects = 0;


for iterator = 1:T_SIZE
    result = net(t_data(:,iterator))
    if t_data_correct(iterator) == 1
        if result < 1
            corrects = corrects+0;
        else
            corrects = corrects+1;
        end
    else
        if result<1
            corrects = corrects+1;
        else
            corrects = corrects+0;
        end
    end
end


corrects

correts = corrects/T_SIZE
