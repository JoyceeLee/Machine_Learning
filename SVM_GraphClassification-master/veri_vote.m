function [finL,L]= veri_vote(finL_1,finL_2,finL_3)
finL = finL_1;
L12 = logical(finL_1 - finL_2);
L13 = logical(finL_1 - finL_3);
L = logical(L12 + L13);
[R,C] = find(L == 1);
for i =1:length(R)
    r = R(i);
    c = C(i);
    rf = r - 1;
    rb = r + 1;
    cu = c - 1;
    cd = c + 1;
    if r == 1
        rf = r;
    elseif r == size(L,1)
        rb = r;
    end
    if c == 1
        cu = c;
    elseif r == size(L,2)
        cd = c;
    end
    n_1 = length(find(finL_1(rf:rb,cu:cd)==finL_1(r,c)));
    n_1 = n_1 + length(find(finL_2(rf:rb,cu:cd)==finL_1(r,c)));
    n_1 = n_1 + length(find(finL_3(rf:rb,cu:cd)==finL_1(r,c)));
    n_2 = length(find(finL_1(rf:rb,cu:cd)==finL_2(r,c)));
    n_2 = n_2 + length(find(finL_2(rf:rb,cu:cd)==finL_2(r,c)));
    n_2 = n_2 + length(find(finL_3(rf:rb,cu:cd)==finL_2(r,c)));
    n_3 = length(find(finL_1(rf:rb,cu:cd)==finL_2(r,c)));
    n_3 = n_3 + length(find(finL_2(rf:rb,cu:cd)==finL_3(r,c)));
    n_3 = n_3 + length(find(finL_3(rf:rb,cu:cd)==finL_3(r,c)));
    [~,I] = max([n_1,n_2,n_3]);
    switch I
        case 1
            finL(r,c) = finL_1(r,c);
        case 2
            finL(r,c) = finL_2(r,c);
        case 3
            finL(r,c) = finL_3(r,c);
        otherwise
            disp('error in veri_vote')
    end
end
end