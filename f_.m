function [result] = f_(F,LD,UL,d,w,AV,counter,Route,ship,res,numOfShipments)
%% May not work correctly
%% Hypothesis: 
%{
    temp = 0;
    if (counter > 0)
        last = Route(counter + 1) + 1
        prelast = Route(counter) + 1
        F = F + LD(ship,last) + UL(ship,last) + d(prelast,last) + w(ship,last)
        counter = counter - 1;
        %result = F;
        temp = f_(F,LD,UL,d,w,AV,counter,Route,ship,res);
    else
        temp = F;
    end
    result = temp;
%}

%% Another Solution (Inverse Concept)

temp = 0;
if (counter < length(Route))
   current  = Route(counter) +1;
   next = Route(counter + 1) +1;
   if(next ~= 1)
        F = F + LD(ship,next) + UL(ship,next) + d(current,next) + w(ship,next);
        res(next - 1) = F;
   end
   counter = counter + 1;
   temp = f_(F,LD,UL,d,w,AV,counter,Route,ship,res);
else
   %temp = F; Gives the sum
   temp = res;
end
   result = temp;
   %result = res;
   
end