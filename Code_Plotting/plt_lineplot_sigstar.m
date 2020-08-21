function plt_lineplot_sigstar(y, x, stats)
    if exist('x') ~= 1 || isempty(x)
        x = 1:length(y);
    end
    stars = getstatstars(stats, ' ');
    text(x,y,stars,...
        'HorizontalAlignment','center',...
        'BackGroundColor','none',...
        'Tag','sigstar_stars','FontSize',20);
end
function stars1 = getstatstars(p0, nons)
    if ~exist('nons')
        nons = ' ';%'n.s.';
    end
    for i = 1:size(p0,1)
        for j = 1:size(p0,2)
            p = p0(i,j);
            if p<=1E-3
                stars='***';
            elseif p<=1E-2
                stars='**';
            elseif p<=0.05
                stars='*';
            elseif p > 0.05
                stars=nons;
            else
                stars=' ';
            end
            stars1{i,j} = stars;
        end
    end
end