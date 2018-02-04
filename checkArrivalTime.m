function [w,window_violation]  = checkArrivalTime(f,e,l,w,d,UL,numOfShipments)

[ship,shipment,val] = find(f);
dis = [ship';shipment'];
[d1,d2] = sort(dis(1,:));
dis = dis(:,d2);
window_violation = zeros(1,numOfShipments);
for i = 1:length(val)
    f_value = val(i);
    if ( f_value > e(shipment(i)) && f_value < l(shipment(i)) )
        %% disp(f_value); 
    elseif ( f_value < e(shipment(i)) )
        %% disp('Early Delivery');
        %%
        if (i > 1)
           w(ship(i),shipment(i)) = e(shipment(i)) - ( f(ship(i-1),shipment(i-1)) + UL(ship(i-1),shipment(i-1)) + d(ship(i-1),shipment(i-1)) );
        end
      % w(ship(i),shipment(i)) = e(shipment(i)) - ( f(ship(i-1),shipment(i-1)) + UL(ship(i-1),shipment(i-1)) + d(ship(i-1),shipment(i-1)) );
    elseif ( f_value > l(shipment(i)) )
         %disp(' Delivery Time window Violation');
         window_violation(shipment(i)) = 1;
    end
end
w = abs(w);
w = (w > 0) .* w;
%dis = sort(dis,2);

end