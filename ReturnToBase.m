function [Parents,R] = ReturnToBase(Parents,R,CT,Q,numOfShips)

    for ship = 1:numOfShips
        route = R{ship}(find(R{ship}));
        new_route = route;
        if (length(route) > 1) % There are at least 2 shipments in ship's route
            total_Quantity = 0;
            for shipment = 1:(length(route) - 1)
                total_Quantity = total_Quantity + Q(route(shipment)) + Q(route(shipment + 1));
                if (total_Quantity > CT(ship))
                    point = find(new_route == route(shipment));
                    new_route = [new_route(1:point) 0 new_route(point+1:length(new_route))];
                    total_Quantity = 0;
                end
            end
        end
        R{ship} = [0 new_route 0];
    end

end