function conditions = Feasibility_Quantity(Parents,f,l,numOfShips,numOfShipments,Q,CT,R)

   C1 = Parents(1,:);
   C2 = Parents(2,2:length(Parents));
   f1 = f;
   f2 = f(:,2:length(f));
   cond1 = zeros(1,numOfShipments);
   cond2 = zeros(1,numOfShipments);
   cond3 = zeros(1,numOfShipments);
   
   for shipment = 1:(numOfShipments-1)
       if (Q(shipment) > CT(Parents(1,shipment)))
           cond3(shipment) = 1;
       end
   end
   
   
   for ship = 1:numOfShips
       %% Condition 2 - Sufficient Capacitance Per Shipment
       [rows2,cols2] = find(f2(ship,:));
       for shipment = 1:length(cols2)
           if ( Q(cols2(shipment)) < CT(ship) ) 
               %disp(' Cond2: OK ');
           else
               %cond2(shipment)
               cond2(cols2(shipment)) = 1;
               %disp(' Cond2: NOO ');
           end
       end
       
       %% Condition 1 - Time Window
       %{
       [rows1,cols1] = find(f1(ship,:));
       for shipment = 1:length(cols1)
           if ( f1(ship,cols1(shipment)) < l(cols1(shipment)) )
                %disp(' Cond1: OK ');
           else
                cond1(shipment) = 1;
                %disp(' Cond1: NOO ');    
           end
       end
       %}
       
       
         
   end
   
   
   %conditions = [cond1;cond2];    
   conditions = cond3;
   
end