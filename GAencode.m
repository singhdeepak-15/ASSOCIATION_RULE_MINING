function [man,st,runbest] = GAencode(Np,Nd,Nt,xMin,xMax,vMin,vMax,org)%(img,dom)

%szr = size(img);
%szd = szr / 2;
%bs = 16;
%Np = 10;
D = Nd;%(szd(1)/bs) * (szd(2)/bs);
%D = floor(D);
%load Data.txt;
%da = Data;
%[r ,c] = size(da);
%limit = 2;
%for z = 1:limit:r
    %fit = zeros(1,Np);
    %ind = zeros(3,2);
r = 1;
while r <= 3
    Itermax = Nt;
    %pop = randi(length(org),Np,D);
    %for i = 1 : Np
        %for j = 1 : D
     for i = 1 : 2*Np
            for j = 1:Nd
                if rand > 0.5
                    pop(i,j) = 1;
                else
                    pop(i,j) = 0;
                end
            end
        end       
   
        %pop(i,:) = [a b c d];
    %end
        fit = Fit_rule(pop);%,org);
    %bestfit = fit(1);
    
        bestfit = max(fit);
        ind = find(bestfit == fit);
        bestpop(1,:) = pop(ind(1),:);
        bestpop(2,:) = pop(ind(1) + 1 ,:);
    %end
%end
size(pop);
iter = 1;
%progress = waitbar(0, 'GA Encoding the image...');

ci = 1;
    while iter < Itermax
        fs = randi(Np,1);
        se = randi(Np,1);
        if fs == se 
            se = mod(se + 1,Np)+1;
        end
        fs = fs  - 1;
        se = se - 1;
        fs = 2 * fs + 1;
        se = 2 * se + 1;
        [ch1 ch2] = crossover(pop,fs,se,ci,D);
        size(ch1);
        size(ch2);
        f1 = Fit_rule(ch1);%,org);
        f2 = Fit_rule(ch2);%,org);
        if f1 < fit(ceil(fs/2))
            pop(fs,:) = ch1(1,:);
            pop(fs+1,:) = ch1(2,:);
        else
            if f2 < fit(ceil(fs/2))
                 pop(fs,:) = ch2(1,:);
                 pop(fs+1,:) = ch2(2,:);
            end
        end
        if f1 < fit(ceil(se/2))
            pop(se,:) = ch1(1,:);
            pop(se+1,:) = ch1(2,:);
        else
            if f2 < fit(ceil(se/2))
           %     pop(se,:) = ch2;
            end
        end 
        ra = randi(Np,1);
        ra = ra - 1;
        ra = 2 * ra + 1;
        mu = mutation(pop,ra,D);
        fit(ra) = Fit_rule(ceil(mu/2));%,org);
        pop(ra,:) = mu(1,:);
        pop(ra+1,:) = mu(2,:);
        pop;
        bestfit = max(fit)
        ind = find(bestfit == fit);
        bestpop(1,:) = pop(ind(1),:);
        bestpop(2,:) = pop(ind(1)+1,:);
        itrbest(iter) = bestfit;
        %iterpop(iter,:) = bestpop;
        
        iter = iter + 1;    
   % waitbar(iter/Itermax, progress);
    end
    runbest = bestpop;
    runfit(r) = bestfit;
  %  close(progress);
   %  feval('fractalcomp',dom,img);
r = r + 1;
end    

man = sum(runfit)/r;
    st = std(runfit);
%ind(:,:,2) = zeros(3,2);

