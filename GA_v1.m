clear;close all;clc;    %Clears variables, closes windows, and clears the command window
tic                     % Begins the timer

resetCounter = 0;
resetIters = 100;
solution_found = 0;
while(resetCounter < resetIters)


    %% Parameters
    %{ 
    Data needed to initialize the process 
    %}
    [N,V,AV,e,l,Q,d,CT,Routes,R,CP,SP,LD,UL,OC,Wp,w,numOfShips,numOfShipments] = data();
    %% Decision Variables
    [x,ts,y,f,opd,TC] = decisionVariables(numOfShips,numOfShipments,R,d,LD,UL,w,Wp,AV,OC,CP,SP);
        
    maxIters = 1000;
    cc = 0;
    %% Loop
    noFeasibleSolutions = 1;
    while (cc < maxIters)

    %% Initialize Population
    %{ 
       1st Parent: Greedy Algorithm (Use Random for trial)
       2nd Parent: Random Selected
       Create two offsprings
    %}
    if(cc == 0)
        firstParent = randi(numOfShips,1,numOfShipments);
        secondParent = randi(numOfShips,1,numOfShipments);
        Parents = [firstParent;secondParent];
    else
        for ship = 1:numOfShips
            shipments_  = R{ship}(find(R{ship}));
            Parents(1,shipments_) = ship*ones(1,length(shipments_));
        end
    end

    %% Crossover Operation
    %{
        2-Point crossover operation
        4-Point crossover operation

        step 1: Insertion
            Insert shipment into ship's Route and check if new Route is
            feasible

        step 2: Backtracking
            Applied to ensure that ship capacity and delivery-time are not
            violated after insertion
    %}

    for ship = 1:numOfShips
       Parents(1,R{ship}(find(R{ship}))) = ship;
    end

    [Parents,R] = crossover(Parents,R,numOfShipments,numOfShips);

    %% Check If 

    quantity_conds = Feasibility_Quantity(Parents,f,l,numOfShips,numOfShipments,Q,CT,R);
    [Parents,R] = FixCrossover(Parents,f,l,numOfShips,numOfShipments,Q,CT,R,quantity_conds);
    %conds_1 = Feasibility_Quantity(Parents,f,l,numOfShips,numOfShipments,Q,CT,R);


    %% Check If all shipments are assigned
    unchecked = N; % Not assigned Shipments
    for ship = 1:numOfShips
        shipments_ToCheck = R{ship}(find(R{ship}));
        shps_ToCheck_length = length(shipments_ToCheck);
        for j = 1:shps_ToCheck_length
            flag = find(shipments_ToCheck(j) == unchecked);
            if(~isempty(flag))
                unchecked(flag) = [];
            end
        end
    end

    %% Insert unassigned shipments to Routes (Greedy algorithm)
    [Parents,R,unchecked] = unassigned_shipments(Parents,R,numOfShipments,numOfShips,unchecked,Q,CT);
    quantity_conds = Feasibility_Quantity(Parents,f,l,numOfShips,numOfShipments,Q,CT,R);
    [x,ts,y,f,opd,TC] = decisionVariables(numOfShips,numOfShipments,R,d,LD,UL,w,Wp,AV,OC,CP,SP);

    %% Insert Zeros - To - Shipment
    %{
        If a ship can't carry a whole route in once due to Capacitance
        problem, then it has to deliver the maximum Quantity of shipments
        that can load. Return back to 0(base) and Deliver the next maximum
        Quantity
    %}
    [Parents,R] = ReturnToBase(Parents,R,CT,Q,numOfShips);

    %% Check Arrival Time 
    % Used abs() function ===> checkArrivalTime(), Line:24
    [w,window_violation] = checkArrivalTime(f,e,l,w,d,UL,numOfShipments);

     %% Decision Variables
    [x,ts,y,f,opd,TC] = decisionVariables(numOfShips,numOfShipments,R,d,LD,UL,w,Wp,AV,OC,CP,SP);

    %% Insert & Back-tracking
    %===== NO Insertion and Back-tracking for now =============================
    % Feasibility 
    %{
    for ship = 1:numOfShips
        shnts_pos = find(R_new{ship});
        cond1(ship) = sum(LD(ship,shnts_pos) + d(ship,shnts_pos));
    end
    %}

    %% Conditions
    [ship,shipment,val] = find(f);
    dis = [ship';shipment'];

    no_feasible_solutions = any(any(quantity_conds));
    all_ships_used = 1;
    for ship = 1:numOfShips
        if (~any(R{ship}))
            all_ships_used = 0;
        end
    end
    if (no_feasible_solutions == 0 && cc > 1 && ~any(window_violation) && all_ships_used)
        %R = R_new;
        solution_found = 1;
        disp(['Total Cost: ',num2str(sum(TC))]);
        disp(['Solution Found after Iterations: ',num2str(cc)]);
        disp('======== Routes ========');
        for ship = 1:numOfShips
           disp(R{ship}); 
        end
        disp('==== End of Routes =====');

        disp(['conditions: ',num2str(quantity_conds)]);
        break;
    else
        %% disp(['No feasible solutions: ', num2str(no_feasible_solutions)]);
    end
    %% Candidates
    %{
    summy = 0;
    candidates = candidate_schedules(numOfShipments);
    for i = 1:numOfShipments
        summy  = summy + sum(sum(candidates{i}));
    end
    %}

    %% Mutation Operation
    %{
        Expand the local minima
        - Insert an Idle ship that NOT used
        - Insert a  Shipment that isn't assigned to a ship
    %}

    %% Check for feasibility
    %{
        Repair if needed
    %}

    %% Check Feasibility and Conditions of Offsprings
    %{
       Repair and Fix if necessary 
       Repeat procedure till there is no empty gene
    %}
    R_new = {};
    for ship = 1:numOfShips
        route_new = find(Parents(1,2:length(Parents)) == ship);
        %disp([' Is sorted: ',num2str(issorted(route_new))]);
        R_new{ship} = [0 route_new 0];
    end
    %% Decision Variable
    R = R_new;
    cc = cc +1;
    end

    if(solution_found == 1)
        break;
    end
    
    if( cc == maxIters)
        disp('No Solution FOUND! ');
        disp(' ');
        disp('Next try....');
        disp(' ');
    end
        
    resetCounter = resetCounter + 1;
end

if(solution_found == 1)
   %R = R_new;
        clc;
        fprintf('\n======== Routes ========\n');
        for ship = 1:numOfShips
           TL = sum(Q(R{ship}(find(R{ship}))));
           fprintf('Ship= %d, Total Cost= %d, Total Load= %d, Route: ',ship,TC(ship),TL);
           route = R{ship};
           for shipment = 1:length(route) -1
               fprintf('%d -> ',route(shipment));
           end
           fprintf('%d \n',route(length(route)));
           %disp(R{ship}); 
        end
        fprintf('==== End of Routes =====\n\n');

        disp(['Total Cost: ',num2str(sum(TC))]);
        disp(['Solution Found after Iterations: ',num2str(cc)]);
        solution_found = 0 ;
end

if(resetCounter == resetIters)
       disp('NOOO FAIL');    
end