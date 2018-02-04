function [Parents,R] = FixCrossover(Parents,f,l,numOfShips,numOfShipments,Q,CT,R,conds)

badShps = find(conds);
for ship = 1:numOfShips
   for shipment = 1:length(badShps)
        badShps_pos = badShps(shipment);
        pos = find(R{ship} == badShps_pos);
        if ( any(pos) && badShps_pos ~= 0 )
            load = Q(badShps_pos);
            capable = find(CT >= load);
            av_ship = find(CT == min(CT(capable)));
            if(av_ship ~= 0)
               Parents(1,badShps_pos) = av_ship;
               old_route = R{av_ship};
               end_old_route = length(old_route);
               new_route = [old_route(1:(end_old_route - 1)) badShps_pos 0];
               R{av_ship} = new_route;
               R{ship}(find(R{ship} == (badShps_pos))) = [];
            else
               disp(['There is no ship able to carry that Load: ',num2str(load)]);
            end
        end
   end
end

end
