function [Parents,R,unchecked] = unassigned_shipments(Parents,R,numOfShipments,numOfShips,unchecked,Q,CT)
%{
    Insert un-assigned shipments to Ship's Routes.
    Un-assigned shipment will be Assigned to ship with bare minimum
    Capacitance to carry this shipment.
    Un-Assigned ==> ship(min(CT > Q))
%}

unchecked_length = length(unchecked);
new_unchecked = unchecked;
for i = 1:unchecked_length
    unchecked_shipment = unchecked(i);
    candidate_ships = find(CT >= Q(unchecked_shipment));
    av_ship = find(CT == min(CT(candidate_ships)));
    old_route = R{av_ship}(find(R{av_ship}));
    new_route = [0 old_route unchecked_shipment 0];
    R{av_ship} = new_route;
    new_unchecked(find(new_unchecked == unchecked_shipment)) = [];
end
unchecked = new_unchecked;
end
