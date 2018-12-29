%function [dim,mat] = convert()
load connect.txt;
chess = connect;
dim = max(max(chess));
mat = zeros(size(chess,1),dim);
for i = 1 : size(chess,1)
    %for j = 1 : dim
        mat(i,chess(i,:)) = 1;
    %end
end
