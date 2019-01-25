net = setwb(net,fireflies(f,:));

% policzenie mocy swiatla

result = net(l_data);
errMatrixL = zeros(3,3);
for i = 1:L_SIZE
    [maxval,evalIndex] = max(result(:,i));
    %evalIndex
    errMatrixL(evalIndex,l_data_correct(i)) = errMatrixL(evalIndex,l_data_correct(i))+1;
end

corrects = (errMatrixL(1,1) + errMatrixL(2,2) + errMatrixL(3,3) ) /L_SIZE;

mse = 1-corrects;

fireflies_light(f) = 1/(mse+0.01);