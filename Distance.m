function va = Distance(x,y)
for j = 1 : length(y) 
    s = 0;
    for i = 1 : length(x)
        s = s + euclid(x(i),y(j,i),0,0);
    end
    va(j) = sqrt(s);
end
%va = sqrt(sum(val));