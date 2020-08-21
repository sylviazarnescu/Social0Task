function plt_ax(axi)
    if nargin == 0
        plt_new;
        return;
    end
    global plt_params
    if isempty(plt_params.gf) || ...
            (axi > length(plt_params.axes))
        warning('no current axes available, please check');
        return;
    end
    plt_params.axi =  axi;
    set(plt_params.gf, 'CurrentAxes', ...
        plt_params.axes(plt_params.axi));
    set(gca, 'FontSize', plt_params.param_figsetting.fontsize_face);
    plt_hold;
end
