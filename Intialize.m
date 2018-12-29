%function pop = Intialize()
% Np = 20;
% Dim = 3;
% pop = zeros(Np,Dim);
% ub = 150;
% lb = 1;
load wine.txt
ba = wine(:,2:end);
k = 1;
clus = 3;
r = rand(1,clus);
pos = length(ba) * r;
pos = floor(pos);
a = ba(pos,:);
iter = 1;
clen = 0;
cmptmp = 1;
while ~isequal(cmptmp,sort(clen))%iter < 100
    cmptmp = sort(clen);
    for k = 1 : length(pos)
        di = zeros(1,length(ba));
        for i = 1 : length(ba)
            s = 0;
            for j = 1 : size(a,2)
                s = s + euclid(a(k,j),ba(i,j),0,0);
            end
            di(i) = sqrt(s);
        end
        dis(k,:) = di;
    end    
    for i = 1:length(dis)
        [as,ind] = min(dis(:,i));
        cluster(i) = ind;
    end
    for i = 1 : length(pos)
        ind = find(i == cluster);
        temp = ba(ind,:);
        for j = 1 : size(a,2)
            ne = sum(temp(:,j));
            new(j) = ne / length(ind);
        end
        clcen(i,:) = new;
        clen(i) = length(ind);

    end
    a = clcen;
    iter = iter + 1
end
