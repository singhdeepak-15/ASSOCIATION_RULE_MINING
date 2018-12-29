function data = Datavalues(val)
if strcmp(val,'XLMINER')
    load xlmine.txt;
    data = xlmine;
else
    if strcmp(val,'CHESS')
        load chess.txt
        data = chess;
    else
        if strcmp(val,'CONNECT')
            load conn.txt
            data = conn;
        else
            if strcmp(val,'GLASS')
                load glass.txt
                data = glass;
            end
        end
    end
end