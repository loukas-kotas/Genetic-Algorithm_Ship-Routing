function combo = candidate_schedules(numOfShipments)

    N = numOfShipments;
    shipments = [1:N];
    for i = 1:N
        combo{i} = nchoosek(shipments,i);
    end

end
