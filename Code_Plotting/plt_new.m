function plt_new()
    % by sywangr@email.arizona.edu, date: 01/25/20
    global plt_params
    if ~isfield(plt_params, 'gf') || isempty(plt_params.gf) || ...
            (plt_params.axi > length(plt_params.axes)) || ...
            (plt_params.axi == length(plt_params.axes) && ...
                ~plt_params.isholdon)
        warning('no current axes available, start a new figure');
        plt_figure;
    end
    if (plt_params.isholdon && plt_params.axi > 0)
        set(plt_params.gf, 'CurrentAxes', ...
            plt_params.axes(plt_params.axi));
        hold on;
        return;
    else
        plt_params.axi =  plt_params.axi + 1;
        set(plt_params.gf, 'CurrentAxes', ...
            plt_params.axes(plt_params.axi));
        set(gca, 'FontSize', plt_params.param_figsetting.fontsize_face);
    end
    if plt_params.param_figsetting.isbold
        set(gca, 'FontSize',plt_params.param_figsetting.fontsize_axes,'FontWeight','Bold');
    else
        set(gca, 'FontSize',plt_params.param_figsetting.fontsize_axes);
    end
    plt_hold('off');
end
