function cluster_ISODATA_consolidation(img)
% disp('consolidation');
global theC z w Nc L;
D = zeros(Nc, Nc);
IX = [];
for i = 1:Nc-1
    for j = (i+1):Nc
        D(i,j) = norm(double(z(i,:)-z(j,:)));
%       disp(['D(' num2str(i) ',' num2str(j) ')= ' num2str(D(i,j))]);
        if D(i,j) < theC
            temp = [i j D(i,j)];
            IX = [IX;temp];
        end
    end
end
if IX
    IX = sortrows(IX,3);
    i = 1;
    j = 1;
    zdel = [];
    while ( (i < L) & (j <= length(IX(:,1))) )
        di = length(find(w == IX(j,1)));
        dj = length(find(w == IX(j,2)));
        ztemp = (di*z(IX(j,1),:)+dj*z(IX(j,2)))/(di+dj);
        z = [z;ztemp];
        zdel = [zdel, IX(j,1), IX(j,2)];
        i = i + 1;
        deta = 1;
        while (j+deta) <= length(IX(:,1))
            if IX(j+deta,1)>IX(j,2)
                break;
            end
            deta = deta+1;    
        end
        j = j + deta;
    end
    z(zdel,:) = [];
    Nc = Nc - length(zdel)/2;
%   disp(['合并的类有：' num2str(zdel)]);
%   disp(['还剩' num2str(Nc) '类']);
end