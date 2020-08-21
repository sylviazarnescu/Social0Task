function [av, se] = tool_meanse(a)
    if size(a,1) == 1
        av = a;
        se = NaN(size(a,1), size(a,2));
    else
        av = nanmean(a);
        se = nanstd(a)./sqrt(sum(~isnan(a)));
    end
end