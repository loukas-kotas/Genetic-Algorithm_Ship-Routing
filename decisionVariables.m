function [x,ts,y,f,opd,TC] = decisionVariables(numOfShips,numOfShipments,R,d,LD,UL,w,Wp,AV,OC,CP,SP)


%% X
for ship = 1:numOfShips
    xx = zeros(numOfShipments,numOfShipments); % row: From, col:To
    %dummy = R{route}(find(R{route})); 
    dummy = R{ship}(find(R{ship}));
    %x(route,dummy) = ones(1,length(dummy));
    for j = 1:length(dummy)-1
       xx(dummy(j),dummy(j+1)) = 1;
       %xx(dummy(j+1)+1,dummy(j)+1) = 1
    end
    x{ship} = xx;
end

%% Total sailing time (days)
ts = zeros(numOfShips,1);
for ship = 1:numOfShips
   %ts{ship} = sum(sum(x{ship}.*d));
   xx = zeros(numOfShipments+1);
   old_len = numOfShipments+1;
   xx(2:old_len,2:old_len) = x{ship};
   %ts(ship) = sum(sum(x{ship}.*d)); 
   ts(ship) = sum(sum(xx.*d));
end

%% y
y = zeros(numOfShips,numOfShipments);
for ship = 1:numOfShips
    dummy = R{ship}(find(R{ship}));
    % dummy = dummy + ones(1,length(dummy)); % 0 starts from position 1
    y(ship,dummy) = ones(1,length(dummy)); 
end

%% Actual arriving Time (f) at Port
f = zeros(numOfShips,numOfShipments);
for ship = 1:numOfShips
    route = R{ship};
    route =  route(1,1:length(route)-1);
    %counter = length(route)-1;
    counter = 1;
    res = zeros(1,numOfShipments);
    %result(ship) = f(0,LD,UL,d,w,AV,counter,route,ship,res);
    f(ship,:) = f_(0,LD,UL,d,w,AV,counter,route,ship,res,numOfShipments);
end

%% Operating Cost
opd = y.*(CP(:,2:numOfShipments+1) + OC(:,2:numOfShipments+1));
% Sum of every row : https://stackoverflow.com/questions/20025249/sum-each-row-and-column-individually-and-output-it-in-matlab
opd = sum(opd,2); 

%% Total Cost 
TC = ts.*SP + opd + sum(w,2).*Wp;

end