function [Parents,R] = crossover(Parents,R,numOfShipments,numOfShips)


two_point_start = randi(numOfShipments,1,1);
two_point_end = round((two_point_start + 2) + (numOfShipments - (two_point_start + 2))*rand(1,1));
while(two_point_end > numOfShipments || two_point_start > numOfShipments || two_point_start == two_point_end)
    two_point_start = randi(numOfShipments,1,1);
    two_point_end = round((two_point_start + 2) + (numOfShipments - (two_point_start + 2))*rand(1,1));
end
C1 = Parents(1,:);
C2 = Parents(2,:);
Parents(1,two_point_start:two_point_end) = C2(1,two_point_start:two_point_end);
Parents(2,two_point_start:two_point_end) = C1(1,two_point_start:two_point_end);

for ship = 1:numOfShips
    new_route = Parents(1,:);
    R{ship} = [0 find(new_route == ship) 0];
end

end