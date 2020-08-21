function str = plt_scatters(xs, ys, option)
    global plt_params;
    tisaddleg = plt_params.param_figsetting.isaddleg;
    xs = tool_decell(xs); ys = tool_decell(ys);
    nl = size(xs,2);
    x = reshape(xs, [],1);
    y = reshape(ys, [],1);
    switch option
        case 'corr'    
            plt_setparams('isaddleg', 0);
            plt_scatter(x,y,'none');
            lsline;
        case 'diag'
            xmin = min(min(x), min(y));
            xmax = max(max(x), max(y));
            dx = xmax - xmin;
            xmin = xmin - dx * 0.2;
            xmax = xmax + dx * 0.2;
            plot([xmin,xmax], [xmin,xmax], '--k', 'linewidth', plt_params.param_figsetting.linewidth);
    end
    plt_setparams('isaddleg', tisaddleg);
    plt_hold;
    for li = 1:nl
        plt_scatter(xs(:,li), ys(:,li), 'none');
    end
    plt_hold('off');
    [r,p] = corr(x,y,'Rows','complete');
    str = sprintf('R = %.2f, p = %g', r, p);
end