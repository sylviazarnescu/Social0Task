function plt_update(option)
    global plt_params;
    if ~exist('option')
        option = 'all';
    end
    if strcmp(option, 'now')
        axs = plt_params.axi;
    else
        axs = 1:length(plt_params.axes);
    end
    for axi = axs
        set(plt_params.gf,'CurrentAxes',plt_params.axes(axi));
        set(gca, 'FontSize', plt_params.param_figsetting.fontsize_axes);
        if ~isempty(plt_params.param_fig.xtick) && length(plt_params.param_fig.xtick) >= axi
            if isempty(plt_params.param_fig.xticklabel)
                set(gca,'XTick', plt_params.param_fig.xtick{axi});
            else
                set(gca,'XTick', plt_params.param_fig.xtick{axi}, ...
                    'XTickLabel', plt_params.param_fig.xticklabel{axi});
            end
        end
        if ~isempty(plt_params.param_fig.ytick) && length(plt_params.param_fig.ytick) >= axi
            if isempty(plt_params.param_fig.yticklabel)
                set(gca,'YTick', plt_params.param_fig.ytick{axi});
            else
                set(gca,'YTick', plt_params.param_fig.ytick{axi}, ...
                    'YTickLabel', plt_params.param_fig.yticklabel{axi});
            end
        end
        if ~isempty(plt_params.param_fig.xlim) && length(plt_params.param_fig.xlim) >= axi && ~isempty(plt_params.param_fig.xlim{axi})
            xlim(plt_params.param_fig.xlim{axi});
        end
        if ~isempty(plt_params.param_fig.ylim) && length(plt_params.param_fig.ylim) >= axi && ~isempty(plt_params.param_fig.ylim{axi})
            ylim(plt_params.param_fig.ylim{axi});
        end
        if ~isempty(plt_params.param_fig.title) && length(plt_params.param_fig.title) >= axi
            str = plt_params.param_fig.title{axi};
            title(str,'FontWeight','normal','FontSize', plt_params.param_figsetting.fontsize_face);
        end
        if ~isempty(plt_params.param_fig.xlabel) && length(plt_params.param_fig.xlabel) >= axi
            xlabel(plt_params.param_fig.xlabel{axi}, 'FontSize', plt_params.param_figsetting.fontsize_face);
        end
        if ~isempty(plt_params.param_fig.ylabel) && length(plt_params.param_fig.ylabel) >= axi
            ylabel(plt_params.param_fig.ylabel{axi}, 'FontSize', plt_params.param_figsetting.fontsize_face);
        end
        if ~isempty(plt_params.param_fig.legend) && length(plt_params.param_fig.legend) >= axi
            if isempty(plt_params.param_fig.legloc) || ...
                    (length(plt_params.param_fig.legloc) >= axi && isempty(plt_params.param_fig.legloc{axi}))
                tlegloc = 'NorthEast';
            else
                tlegloc = plt_params.param_fig.legloc{axi};
            end
            fontsize = plt_params.param_figsetting.fontsize_leg;
            leg = plt_params.param_fig.legend{axi};
            if ~iscell(leg)
                leg = {leg};
            end
            if length(leg) == length(plt_params.leglist{axi}) && ~all(cellfun(@(x)isempty(x), leg))
                if  ~plt_params.param_figsetting.islegmark
                    plt_params.leglist{axi} = line(nan, nan, 'Linestyle', 'none', 'Marker', 'none', 'Color', 'none');
                end
                axP = get(gca,'Position');
                [lgd] = legend(plt_params.leglist{axi}, leg,...
                    'Location', tlegloc);
                set(gca, 'Position', axP);
                lgd.FontSize = fontsize;
                if  ~plt_params.param_figsetting.islegmark
                    lgd.Position(1) = lgd.Position(1) - 0.05;
                end
                if plt_params.param_figsetting.islegbox
                    legend('boxon')
                else
                    legend('boxoff');
                end
            else
                warning('legend ignored: number of legend entries didn''t match the number of plots');
            end
        end
    end
    set(plt_params.gf,'CurrentAxes',plt_params.axes(plt_params.axi));
    if ~strcmp(option, 'now')
        plt_setparams('reset');
    end
end
