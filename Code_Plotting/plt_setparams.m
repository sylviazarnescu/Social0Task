function plt_setparams(varargin)
% siyu, sywangr@email.arizona.edu, 01/25/20
% plt_setparams: sets param_figsetting variables
%     param_fig - params that change from figure to figure (ex. xlabel)
%     param_figsetting - params that are relatively constant for a set of figrues ...
%                        (ex. font size)
%     param_setting - params that need to be set once (ex. savedir)
%     param_preset - preset params, values are constant and should not need to be changed
    plt_initialize;
    global plt_params;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % fig setting params
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if ~isfield(plt_params, 'param_figsetting') || (nargin > 0 && strcmp(varargin{1}, 'reset')) % only update if there is user change
        disp('plt_setparams: set plotting params(style)');
        fmt = plt_params.param_setting.format;
        % plotting params
        plt_params.param_figsetting = plt_params.param_preset.plotparam.(fmt);
        plt_params.param_figsetting.islegbox = false;
        plt_params.param_figsetting.islegmark = true;
        plt_params.param_figsetting.isbold = false;
        % (setting) stat params
        plt_params.param_figsetting.stat_starorvalue = 'star';
        plt_params.param_figsetting.isaddleg = 1;
    end
    if nargin > 0
        plt_setuserparam('param_figsetting', varargin);
    end
end
