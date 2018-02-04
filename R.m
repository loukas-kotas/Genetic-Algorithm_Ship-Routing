function f = R(a,counter)
    temp = 0;
    if (counter == 0)
        temp = a;
    else
        counter = counter -1;
        temp = R(a+2,counter);
        
    end
    f = temp;
end
