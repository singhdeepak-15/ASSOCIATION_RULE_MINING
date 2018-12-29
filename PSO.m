% This program implements a clean version of Particle Swarm Optimization (PSO)

function [man ,st,gbest_pos] = PSO(Np, Nd, Nt, xMin, xMax, vMin, vMax,hy)

W  = 0.25;
C1 = 2.05;
C2 = 2.05;    
run = 2;
phi = C1 + C2;    
chi = 2.0/abs(2.0-phi-sqrt(phi^2-4*phi));

% Init personal best values
pBestValue    = ones(Np) .* -Inf;
pBestPosition = zeros(2 * Np, Nd);

% Init global best values
gBestValue    = -Inf;
gBestPosition = zeros(2,Nd);

% Record of best Fitness for plotting
bestFitnessHistory = [];
r =  1;
% Initialize position of each particle
while ( r <= run)
    if(nargin <= 9) 
        for i = 1 : 2*Np
            for j = 1:Nd
                if rand > 0.5
                    pop(i,j) = 1;
                else
                    pop(i,j) = 0;
                end
            end
        end
        R = pop;
        flag = 1;
        V = zeros(2 * Np, Nd); % Velocity
        for p=1:2*Np % For each Particle
            for i =1:Nd % For each dimension
                V(p,i) =  vMin + (vMax-vMin) * rand;
                V(p+1,i) =  vMin + (vMax-vMin) * rand;
                if rand < 0.5
                    % V(p,i) = -V(p,i);
                end
            end
        end
        M = Fit_rule(R)
      
        for j=1:Nt % For each time step
        
        % Update Position
            for p=1:2:2*Np
                for i=1:Nd
                    R(p,i) = floor(R(p,i) + V(p,i));
                    R(p+1,i) = floor(R(p+1,i) + V(p+1,i));
                    if flag == 1
                        si = 1 / (1 + exp(-R(p,i)));
                        if rand < si
                            R(p,i) = 0;
                        else
                            R(p,i) = 1;
                            
                        end
                        si = 1 / (1 + exp(-R(p+1,i)));
                        if rand < si
                            R(p+1,i) = 0;
                        else
                            R(p+1,i) = 1;
                        end
                    else
                    % Correct any errors
    %                 if R(p,i) > xMax
    %                     R(p,i) = xMax;
    %                 elseif  R(p,i) < xMin
    %                     R(p,i) = xMin;
    %                 end
                    end
                if rand < 0.5
                    %R(p,i) = -R(p,i);
                end
            end
        end
        R;
        % Evaluate Fitness
        M = Fit_rule(R);%,fea);
        %M = Benchmark(val ,Np, Nd, R);
        for p=1:Np
            %Check if it is a personal best
            %If it is, record the value and the position
            if M(p) > pBestValue(p)                
                pBestValue(p) = M(p);
                for i=1:Nd
                    pBestPosition(p,i) = R(p,i);
                    pBestPosition(p+1,i) = R(p+1,i);
                end 
            end
            if M(p) > gBestValue                
                gBestValue = M(p);
                for i=1:Nd
                    gBestPosition(1,i) = R(p,i);
                    gBestPosition(2,i) = R(p+1,i);
                end 
            end            
        end
        bestFitnessHistory(j) = gBestValue;
        
       
        for p=1:Np
            for i=1:Nd
                
                V(p,i)  = chi*(V(p,i) + C1 * (pBestPosition(p,i)-R(p,i)) + C2 * (gBestPosition(i) - R(p,i)));
                if V(p,i) > vMax
                    V(p,i) = vMax;
                elseif  V(p,i) < vMin
                    V(p,i) = vMin;
                end
            end
        end
        
        if hy == 1
                ci = 1; 
                fs = randi(Np,1);
                se = randi(Np,1);
                if fs == se 
                    se = mod(se + 1,Np)+1;
                end
                fs = fs  - 1;
                se = se - 1;
                fs = 2 * fs + 1;
                se = 2 * se + 1;
                [ch1 ch2] = crossover(pop,fs,se,ci,Nd);
                size(ch1);
                size(ch2);
                f1 = Fit_rule(ch1);%,org);
                f2 = Fit_rule(ch2);%,org);
                if f1 < M(ceil(fs/2))
                    pop(fs,:) = ch1(1,:);
                    pop(fs+1,:) = ch1(2,:);
                else
                    if f2 < M(ceil(fs/2))
                        pop(fs,:) = ch2(1,:);
                        pop(fs+1,:) = ch2(2,:);
                    end
                end
                if f1 < M(ceil(se/2))
                    pop(se,:) = ch1(1,:);
                    pop(se+1,:) = ch1(2,:);
                else
                    if f2 < M(ceil(se/2))
           %     pop(se,:) = ch2;
                    end
                end 
        end
        
        
        str = sprintf('Iteration: %d Best Value: %f', j, gBestValue);
        disp(str)
    end
    
    bestrun(r)  = gBestValue
    gbest_pos(:,:) = gBestPosition;
    r = r+1;
    end
    
    man = sum(bestrun)/run;
    st = std(bestrun);
    % figure,plot(bestFitnessHistory);
    % xlabel('Iteration');
    % ylabel('Best Value');
end