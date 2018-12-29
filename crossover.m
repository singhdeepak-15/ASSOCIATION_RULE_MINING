function [first , sec] = crossover(pop,fs,se,ci,D)
%load Data.txt;
%da = Data;
%[ro ,co] = size(da);
cl = size(pop,2);
first(1,:) = pop(fs,:);
first(2,:) = pop(fs+1,:);
sec(1,:) = pop(se,:);
sec(2,:) = pop(se+1 ,:);
size(first);
switch(ci)
    case 1
        ra1 = ceil(cl/2);
        %for i = 1:ra(1)
        %ra2 = randi(ro,1,4);
        tmp = first(1,ra1:end);
        first(1,ra1:end) = sec(1,ra1:end);%da(ra1(1),1);
        sec(1,ra1:end) = tmp;
        
        tmp = first(2,ra1:end);
        first(2,ra1:end) = sec(2,ra1:end);%da(ra1(1),1);
        sec(2,ra1:end) = tmp;
        %first(1,2) = da(ra1(2),2);
        %first(1,3) = da(ra1(3),3);
        %first(1,4) = da(ra1(4),4);
        %sec(1,1) = da(ra2(1),1);
        %sec(1,2) = da(ra2(1),2);
        %sec(1,3) = da(ra2(1),3);
        %sec(1,4) = da(ra2(1),4);
%     case 2
%         ra = randi(D, [1 2]);
%         ra = sort(ra);
%         first(1,ra(1):ra(2),:) = pop(se,ra(1):ra(2),:);
%         sec(1,ra(1):ra(2),:) = pop(fs,ra(1):ra(2),:);
end
