function plt_lineplot(av, mbar, x, linestyle, stats)
    %   by sywangr@email.arizona.edu
    %   02/03/2020
    %   av - number of lines by number of dots in each line
    if ~exist('linestyle') || isempty(linestyle)
        linestyle = 'line';
    end
%     if all(mbar ==  0)
%         mbar = [];
%     end
    switch linestyle
        case 'dot'
            option_dot.plt = 'o';
            option_dot.eb = 'o';
        case 'line'
            option_dot.plt = '-';
            option_dot.eb = 'o-';
        case 'dash'
            option_dot.plt = '--';
            option_dot.eb = '--';
        otherwise
            option_dot = linestyle;
    end
    global plt_params;
    if (exist('x')~=1) || isempty(x)
        x = 1:size(av, 2);
    end
    if ~isempty(plt_params.param_fig.color)
        color = tool_encell(plt_params.param_fig.color{plt_params.axi});
    else
        color = {};
    end
    nls = size(av,1);
    if length(color) >= nls
        plt_params.param_fig.color{plt_params.axi} = color(nls+1:end); % remove the used colors
        color = color(1:nls);
    elseif ~isempty(color)
        warning('number of colors assigned is smaller than the nunmber of lines');
        color = {};
    end
    if ~plt_params.isholdon
        hold on;
    end
    for li = 1:nls
        if ~exist('mbar') || isempty(mbar) 
            eb = plot(x, av(li,:), option_dot.plt, ...
                'LineWidth', plt_params.param_figsetting.linewidth);
            eb.MarkerSize = plt_params.param_figsetting.dotsize;
%         elseif all(mbar(li,:) == 0)
%             eb = plot(x, av(li,:), option_dot.eb, ...
%                 'LineWidth', plt_params.param_figsetting.linewidth);
%             eb.MarkerSize = plt_params.param_figsetting.dotsize;
        else
            eb = errorbar(x, av(li,:), mbar(li,:), option_dot.eb, ...
                'LineWidth', plt_params.param_figsetting.linewidth);
            eb.CapSize = plt_params.param_figsetting.errorbarcapsize;
        end
        if ~isempty(color)
            eb.Color = color{li};
            eb.MarkerFaceColor = color{li};
        end
        if plt_params.param_figsetting.isaddleg == 1
            plt_params.leglist{plt_params.axi}(end + 1) = eb;
        end
    end
    if exist('stats') == 1% currently doesn't work for a single line
        ym = max(av+mbar);
        yl = diff(ylim);
        plt_lineplot_sigstar(ym + 0.05*yl, x, stats);
    end
    if ~plt_params.isholdon
        hold off;
    end
end
