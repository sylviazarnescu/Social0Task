function plt_setfig_ax(varargin)
    % siyu, sywangr@email.arizona.edu, 01/26/20
    global plt_params;
    if ~isfield(plt_params, 'param_fig')
        plt_setfig('new');
    end
    n_ax = plt_params.n_ax;
    if strcmp(varargin{1}, 'axi')
        axi = varargin{2};
        i = 3;
    else
        axi = plt_params.axi;
        i = 1;
    end
    while i <= nargin
        arg = varargin{i};
        val = varargin{i+1};
        i = i + 2;
        if ~any(strcmp(arg, {'size', 'xlabel','ylabel','legend','title', ...
            'xlim','ylim','color','xlim','ylim', ...
            'xtick','xticklabel','ytick','yticklabel','legloc'}))
            warning(sprintf('%s is not a sub-field of param_fig, value skipped', arg));
            continue;
        end
        switch arg
            case 'color'
                colorfunc = @(str)cellfun(@(x)tool_iif(isnumeric(x), x, calc_color(x)),str,'UniformOutput',false);
                val = tool_encell(val);
                if ~iscell(val{1}) % single plot, multiple lines
                    val = colorfunc(val);
                else
                    tval = [];
                    for ni = 1:length(val)
                        tval{ni} = colorfunc(val{ni});
                    end
                    val = tval;
                end
        end
        plt_params.param_fig.(arg){axi} = tool_decell(val);
    end
    plt_params.param_fig.locked = true;
end
function out = calc_color(str)
    global plt_params;
    if ~(ischar(str) || isstring(str))
        out = [0 0 0]; % black
        return;
    end
    [num, idx] = str_selectnum(str);
    if isnan(num)
        num = 100;
    end
    str = str(~idx);
    col = plt_params.param_preset.colors.(str);
    out = col * num/100 + (1-num/100) * [1 1 1];
end
