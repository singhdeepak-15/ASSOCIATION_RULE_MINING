function out = mutation(pop,ind,D)

ra = randi(D,[1 2]);
temp = pop(ind,ra(1));
pop(ind,ra(1)) = pop(ind,ra(2));
pop(ind,ra(2)) = temp;
out(1,:) = pop(ind,:);
out(2,:) = pop(ind+1,:);
