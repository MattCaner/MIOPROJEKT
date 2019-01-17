    net = setwb(net,fireflies(f,:));
    
    % policzenie mocy swiatla
    
    mse = 0;
    for i = 1:L_SIZE
        result = net(l_data(:,i));
        mse = mse + (result-l_data_correct(i))^2;
    end
     
    % policzenie mocy swiatla - druga wersja :)
    %result = net(l_data);
    %mse = 0;
    %for i = 1:L_SIZE
    %    mse = mse + (result(:,i)-l_data_correct(:,i))^2;
    %end
    
    %mse
    
    mse = mse/L_SIZE
    fireflies_light(f)
    fireflies_light(f) = 1/mse;
    fireflies_light(f)
  
