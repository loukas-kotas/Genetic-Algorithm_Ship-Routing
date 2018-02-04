function [f,W,ts,x] = decision(V,N,AV,ea,la,Q,d,CT,routes,cost_of_route,CP,SP,LD,UL,...
          OC,Wp,m,n,ports)

 % Description:
 % Calculate decision variables for crossover operation and parent
 % selection.
      
      
f = zeros(m,n); % Actual arrival time for ship v to shipment-port i
for i = 1:m
    for j = 1:n
        f(i,j) = AV(i) + LD(i,j) + d(
    end
end


W = zeros(m,n); % Duration of waiting (idle) time for ship v until time-window of shipment-port i opens (days)
ts = zeros(1,m); % Total sailing using ship v

x = {}; % if ship v sailing from i to k -- 0 otherwise
for i = 1:m
   x{i} = zeros(n); 
end

y = {}; % 1 if ship v delivered from i to k -- 0 othewise
for i = 1:m
   y{i} = zeros(n); 
end




end
