function [V,N,AV,ea,la,Q,d,CT,routes,cost_of_route,CP,SP,LD,UL,...
          OC,Wp] = setup(m,n,ports)

%=== Random Numbers range ====%
a = 1;
b = 5;

%m = 4; % All available ships
%n = 10; % Shipments
%ports = 4; % all Ports 
V = [1:m]; % Sorted ships
N = [1:n]; % Sorted shipments
AV = ones(1,m); % Availability of all ships -- All ships are available in the beginning

ea = round(rand(1,m)*10); % earliest arrival time - min:0, max:9
la = ea + 10; % latest arrival time for every ship - min: 10, max:19
Q = round(rand(1,n)*10); % in Tons
d = chop(rand(n)*10,1); % Distance in days from shipment-port i To shipment-port k
CT = ones(1,m)*100; % Ship's i capacity 
routes = {}; % Rout of every ship
routes{1} = [0 4 9 0];
routes{2} = [0 2 0 8 5 0];
routes{3} = [0 1 0 7 10 0];
routes{4} = [0 3 6 0];
cost_of_route = [450 654 780 525];

CP = round(rand(m,n)*100); % Port entrance due (fee) at shipment-port i for ship v
SP = [1:m]*100; % Sailing cost using ship v (per day)
LD = round((b-a).*rand(m,n) + a); % Time required for loading shipment i onto ship v (days)
UL = round((b-a).*rand(m,n) + a); % Time required for unloading shipment i from ship v (days)
a = 5;
b = 100;
OC = round((b-a).*rand(m,n) + a); % Operating cost for ship v to handle shipment i, including loading and unloading cost
a = 1;
b = 5;
Wp = round((b-a).*rand(m,n) + a); % Waiting cost (idle in the ocean) for ship v (per day)

end