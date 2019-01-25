net = setwb(net,fireflies(f,:));

% policzenie mocy swiatla
result = net(l_data);
mse = 0;
for i = 1:L_SIZE
    err = result(:,i) - l_data_correct(:,i);
    mse = mse + abs(err(1)) + abs(err(2)) + abs(err(3));
end

mse = mse/(L_SIZE*3);
fireflies_light(f) = 1/mse;
