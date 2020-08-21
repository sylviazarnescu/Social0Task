function [out, idx] = str_selectnum(str)
    str = char(str);
    idxnum = regexp(str, '\d');
    if length(idxnum) == 0
        out = NaN;
    else
        tword = [0 find(diff(idxnum) > 1) length(idxnum)] + 1;
        for i = 1:(length(tword)-1)
            out(i) = str2num(str(idxnum(tword(i):tword(i+1)-1)));
        end
    end
    idx = zeros(length(str), 1);
    idx(idxnum) = 1;
end