function fit = Fit_rule(pop)

ndim = size(pop,2);
if ndim == 10
    load xlmine.txt
    inp = xlmine;
    len = size(pop,1);
else
    if ndim == 75
        load chess.txt
        inp = chess;
        len = size(pop,1);
        'chess'
    else
        load conn.txt
        inp = conn;
        len = size(pop,1);
        'conne'
    end
end
        
j = 1;
for i = 1 : 2 : len
    app = pop(i,:);
    rul = pop(i+1,:);
    ind = find(app);
    arul = rul(ind);
    ant = find(arul);
    
    if isempty(ant)
        fi = 0;
    else
        A = ind(ant);
        con = find(arul == 0);
        B = ind(con);
        if isempty(A)
            fi = 0;
        else
            if isempty(B)
                fi = 0;
            else
                nta = 0;
                tn = size(inp,1);
                col = inp(:,A);
                acol = size(col);
                for i1 = 1 : acol(1)
                    %for j = 1 : acol(2)
                     ro = find(col(i1,:));
                     if ro == acol(2)
                         nta = nta + 1;
                     end
                    %end
                end
                supp_a = nta / tn
                
                nta = 0;
                AB = [A B];
                col = inp(:,AB);
                acol = size(col);
                for i1 = 1 : acol(1)
                    %for j = 1 : acol(2)
                     ro = find(col(i1,:));
                     if ro == acol(2)
                         nta = nta + 1;
                     end
                    %end
                end
                supp_ab = nta / tn
                conf_ab = supp_ab / supp_a
                if supp_ab == 0 | supp_a == 0
                    fi = 0;
                else
                    fi = supp_ab * conf_ab;
                end
                
            end
        end
             
    end
    fit(j) = fi;    
    j = j + 1;
end