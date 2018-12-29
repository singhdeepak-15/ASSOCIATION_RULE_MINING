function fit = fitness(pop,fea)
size(pop);
for i = 1 : size(pop,1)
    s = 0;
    for j = 1 :  size(pop,2)
        s = s + sum(Distance(fea(pop(i,j),:),fea));
    end
    fit(i) = s;
end