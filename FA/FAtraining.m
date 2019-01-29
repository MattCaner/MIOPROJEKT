function outputNet = FAtraining(net, l_data, l_data_correct,L_SIZE, popsize, maxiter, beta, gamma, alpha, randomBounds)

%PRZYGOTOWANIE UCZENIA FA - - - - - - - - - - - - - - - - - - - - - -

netwbvalues = getwb(net);
dimensions = size(netwbvalues);
fireflies = zeros(popsize,dimensions(1,1));
fireflies_light = zeros(popsize,1);
bestfirefly = zeros(1,dimensions(1,1));
bestmse = 10^5;
mse = 0;
bestiterfound = 0;

% - losowanie poczatkowych wag

for i = 1:popsize
    for j = 1:dimensions
        fireflies(i,j) = (rand-0.5)*2*randomBounds;
    end
end

% - wygenerowanie swiatla poczatkowego

for f=1:popsize
    FAtraining_VAL_;
end

% PRZYGOTOWANIE WYKRESU

x = 1:maxiter;
bestIterLightArray = zeros(1,maxiter);
bestmseArray = zeros(1,maxiter);

plot1 = subplot(2,1,1);
plot2 = subplot(2,1,2);

% GLOWNA PETLA PROGRAMU

for iterator = 1:maxiter
    iterator
    for k = 1:popsize
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
                    fireflies(k,dims) = fireflies(k,dims) + BETA*(fireflies(m,dims)-fireflies(k,dims))+alpha*(rand()-0.5);
                end
                
                f = k;
                FAtraining_VAL_;
                
                if mse<bestmse
                    bestmse = mse;
                    bestfirefly = fireflies(k,:);
                    bestiterfound = iterator;
                end
            end  
        end
    end
    [bestIterLight,bestIterFirefly] = max(fireflies_light);
    %bestIterLight
    for dims = 1:dimensions
        fireflies(bestIterFirefly,dims) = fireflies(bestIterFirefly,dims) + alpha*(rand()-0.5);
    end
    f = bestIterFirefly;
    FAtraining_VAL_;
    if mse<bestmse
        bestmse = mse;
        bestfirefly = fireflies(bestIterFirefly,:);
        bestiterfound = iterator;
    end
    bestIterLightArray(iterator) = bestIterLight;
    bestmseArray(iterator) = bestmse;
    plot(plot1,x,bestIterLightArray,'-b')
    title('Best iteration light');
    plot(plot2,x,bestmseArray,'-b')
    title('Lowest found error');
end
fireflies(1,:) = bestfirefly;

fprintf('Training done.\nLowest error: %f\nFound in iteration: %i\n',bestmse,bestiterfound);
bestiterfound
outputNet = setwb(net,fireflies(1,:));

