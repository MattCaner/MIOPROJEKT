iter = 1;
%f
    % ustawianie IW
    for i=1:2
        for j=1:4
           net.IW{1,1}(i,j) = fireflies(f,iter);
           iter = iter+1;
        end
    end
    % ustawienie LW - 1/2 warstwa
    for i=1:1
        for j=1:2
           net.LW{2,1}(i,j) = fireflies(f,iter); 
           iter = iter+1;
        end
    end
    % ustawienie LW - 2/3 warstwa
    for i=2:1
        for j=1:1
           net.LW{3,2}(i,j) = fireflies(f,iter); 
           iter = iter+1;
        end
    end  
    % ustawienie LW - 3/4 warstwa
    for i=1:1
        for j=1:2
           net.LW{4,3}(i,j) = fireflies(f,iter); 
           iter = iter+1;
        end
    end     
    % ustawienie b - 1 warstwa
    for i=1:2
        for j=1:1
           net.b{1,1}(i,j) = fireflies(f,iter); 
           iter = iter+1;
        end
    end   
    % ustawienie b - 2 warstwa
    for i=1:1
        for j=1:1
           net.b{2,1}(i,j) = fireflies(f,iter); 
           iter = iter+1;
        end
    end   
    % ustawienie b - 3 warstwa
    for i=1:2
        for j=1:1
           net.b{3,1}(i,j) = fireflies(f,iter); 
           iter = iter+1;
        end
    end   
    % ustawienie b - 4 warstwa
    for i=1:1
        for j=1:1
           net.b{4,1}(i,j) = fireflies(f,iter); 
           iter = iter+1;
        end
    end   
    
    % policzenie mocy swiatla
    
    mse = 0;
    for i = 1:L_SIZE
        result = net(l_data(:,i));
        mse = mse + (result-l_data_correct(i))^2;
    end
    
    %mse
    
    mse = mse/L_SIZE;
    
    fireflies_light(f) = 1/mse;
    
    
    