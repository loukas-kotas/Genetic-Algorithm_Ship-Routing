function [N,V,AV,e,l,Q,d,CT,Routes,R,CP,SP,LD,UL,OC,Wp,w,numOfShips,numOfShipments] = data()

N = xlsread('excel/Shipments.xlsx');
V = xlsread('excel/ships.xlsx');
AV = xlsread('excel/availability_time_at_origin.xlsx');
e = xlsread('excel/earliest_arrival_per_shipment.xlsx'); % 1st col: Hours , 2nd col: Min 
l = xlsread('excel/latest_arrival_per_shipment.xlsx'); % 1st col: Hours , 2nd col: Min 
Q = xlsread('excel/Quantity_per_shipment.xlsx'); % (tons)
d = xlsread('excel/distance_between_ports.xlsx'); % (days) (Must be symmetric)
CT = xlsread('excel/capacity_per_ship.xlsx'); % (tons)
Routes = xlsread('excel/routes_per_ship.xlsx');
[rows,cols] = size(Routes);
for i = 1:rows
    route = [];
    route = find(~isnan(Routes(i,:)));
    R{i} = Routes(i,route);
end
CP = xlsread('excel/Port_entrance_due_fee.xlsx');
SP = xlsread('excel/sailing_cost_per_ship.xlsx'); % Per day
LD = xlsread('excel/Loading_time_shipment_per_ship.xlsx'); % (days)
UL = xlsread('excel/Unloading_time_shipment_per_ship.xlsx'); % (days)
OC = xlsread('excel/Operating_cost_shipment_per_ship.xlsx'); 
Wp = xlsread('excel/Waiting_cost_idle_per_ship.xlsx'); % (per day)
w  = xlsread('excel/Waiting_idle_time_per_ship.xlsx');
numOfShips = length(V);
numOfShipments = length(N);

end