function plt_initialize(varargin)
% siyu, sywangr@email.arizona.edu, 01/25/20
% plt_initialize: sets param_preset & param_setting values
%     param_fig - params that change from figure to figure (ex. xlabel)
%     param_figsetting - params that are relatively constant for a set of figrues ...
%                        (ex. font size)
%     param_setting - params that need to be set once (ex. savedir)
%     param_preset - preset params, values are constant and should not need to be changed
    global plt_params
    vars = varargin;
    if exist('plt_params') && ~isempty(plt_params); % will only initialize
        if nargin == 0
            return;
        end
    else
        vars = [{'new'}, vars];
    end
    if strcmp(vars{1}, 'new')
        vars = vars(2:end);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % preset params
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % (preset) set up colors
        colors = generate_colors;
        plt_params.param_preset.colors = colors;
        % (preset) set up figure configuration - preset
        figconfig.paper.fig_size{1,1} = [0.3 0.15 0.4 0.65];
        figconfig.paper.fig_margin{1,1} = [0.17, 0.2, 0.05, 0.05];
        figconfig.paper.fig_gap{1,1} = [0.1 0.1];
        
        figconfig.paper.fig_sizet{1,1} = [0.3 0.15 0.4 0.65];
        figconfig.paper.fig_margint{1,1} = [0.17, 0.2, 0.1, 0.05];
        figconfig.paper.fig_gapt{1,1} = [0.1 0.1];
        
        figconfig.paper.fig_sizet{1,2} = [0.1, 0.15, 0.85, 0.7];
        figconfig.paper.fig_margint{1,2} = [0.15 0.1 0.1 0.03];
        figconfig.paper.fig_gapt{1,2} = [0.1 0.1];
        
        figconfig.paper.fig_size{1,2} = [0.1 0.15 0.85 0.7];
        figconfig.paper.fig_margin{1,2} = [0.15, 0.08, 0.05, 0.03];
        figconfig.paper.fig_gap{1,2} = [0.1 0.1];
        
        figconfig.paper.fig_size{1,3} = [0.05, 0.15, 0.95, 0.52];
        figconfig.paper.fig_margin{1,3} = [0.18, 0.07, 0.05, 0.03];
        figconfig.paper.fig_gap{1,3} = [0.1 0.1];

        
        figconfig.paper.fig_sizet{1,4} = [0.01 0.2 0.99 0.52];%[];%[0.2 0.15 0.5 0.8];
        figconfig.paper.fig_margint{1,4} = [0.18, 0.06, 0.11, 0.01];%[];%[0.2, 0.15, 0.1, 0.05];
        figconfig.paper.fig_gapt{1,4} =  [0.05 0.05];
        
        
        figconfig.paper.fig_sizet{2,2} = [0.15 0.05 0.6 0.9];
        figconfig.paper.fig_margint{2,2} = [0.15, 0.1, 0.1, 0.05];
        figconfig.paper.fig_gapt{2,2} = [0.15 0.1];
        figconfig.paper.fig_size{2,2} = [0.15 0.05 0.6 0.9];
        figconfig.paper.fig_margin{2,2} = [0.15, 0.1, 0.1, 0.05];
        figconfig.paper.fig_gap{2,2} = [0.15 0.1];
        
        figconfig.paper.fig_sizet{2,3} = [0.1 0.1 0.65 0.8];
        figconfig.paper.fig_margint{2,3} = [0.17, 0.1, 0.08, 0.05];
        figconfig.paper.fig_gapt{2,3} = [0.2 0.1];
        
        figconfig.paper.fig_size{2,3} = [0.1 0.1 0.65 0.8];
        figconfig.paper.fig_margin{2,3} = [0.17, 0.1, 0.08, 0.05];
        figconfig.paper.fig_gap{2,3} = [0.2 0.1];
        
        figconfig.paper.fig_sizet{3,2} = [0.15 0.02 0.4 0.95];
        figconfig.paper.fig_margint{3,2} = [0.12, 0.14, 0.1, 0.02];
        figconfig.paper.fig_gapt{3,2} = [0.09 0.12];
        
        figconfig.paper.fig_size{3,2} = [0.15 0.02 0.4 0.95];
        figconfig.paper.fig_margin{3,2} = [0.1, 0.14, 0.04, 0.02];
        figconfig.paper.fig_gap{3,2} = [0.09 0.12];
        
        
        figconfig.paper.fig_sizet{4,2} = [0.15 0.02 0.4 0.95];
        figconfig.paper.fig_margint{4,2} = [0.1, 0.12, 0.04, 0.02];
        figconfig.paper.fig_gapt{4,2} = [0.09 0.12];
        
        figconfig.paper.fig_size{6,2} = [0.15 0.02 0.4 0.95];
        figconfig.paper.fig_margin{6,2} = [0.1, 0.1, 0.05, 0.02];
        figconfig.paper.fig_gap{6,2} = [0.05 0.1];
        
        figconfig.paper.fig_size{5,3} = [0.15 0.01 0.6 0.96];
        figconfig.paper.fig_margin{5,3} = [0.07, 0.1, 0.05, 0.01];
        figconfig.paper.fig_gap{5,3} = [0.05 0.05];
        
        
        figconfig.paper.fig_size{5,2} = [0.15 0.01 0.4 0.96];
        figconfig.paper.fig_margin{5,2} = [0.1, 0.1, 0.03, 0.01];
        figconfig.paper.fig_gap{5,2} = [0.05 0.05];
        
        
        figconfig.paper.fig_sizet{6,4} = [0.15 0.01 0.6 0.96];
        figconfig.paper.fig_margint{6,4} = [0.12, 0.1, 0.05, 0.01];
        figconfig.paper.fig_gapt{6,4} = [0.05 0.05];
        
        figconfig.paper.fig_size{6,4} = [0.15 0.01 0.6 0.96];
        figconfig.paper.fig_margin{6,4} = [0.12, 0.1, 0.05, 0.01];
        figconfig.paper.fig_gap{6,4} = [0.05 0.05];
        
        figconfig.paper.fig_size{5,5} = [0.2 0.1 0.6 0.8];
        figconfig.paper.fig_margin{5,5} = [0.1, 0.08, 0.02, 0.04];
        figconfig.paper.fig_gap{5,5} = [0.03 0.02];
        
        
        
        
        plt_params.param_preset.figconfig = figconfig;
        
        
        
        plotparam.poster.linedotsize = 5;
        plotparam.poster.dotsize = 50;
        plotparam.poster.errorbarcapsize = 6;
        plotparam.poster.linewidth = 4;
        plotparam.poster.fontsize_axes = 40;
        plotparam.poster.fontsize_face = 40;
        plotparam.poster.fontsize_leg = round(15*1.5);
        
        plotparam.paper.linedotsize = 7;
        plotparam.paper.dotsize = 30;
        plotparam.paper.errorbarcapsize = 6;
        plotparam.paper.linewidth = 5;
        plotparam.paper.fontsize_axes = 20;
        plotparam.paper.fontsize_face = 30;
        plotparam.paper.fontsize_leg = round(15*1.5);
        
        plt_params.param_preset.plotparam = plotparam;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % setting params
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        disp('plt_initialize: initializing plotting params');
        % figure initialization
        % (setting) set up view/save option
        plt_params.param_setting.isshow = true;
        plt_params.param_setting.format = 'paper';
        plt_params.param_setting.fig_suffix = '';
        plt_params.param_setting.fig_projectname = '';
        plt_params.param_setting.fig_dir = '';
    end
    
   % (setting) write user specified parameters
    plt_setuserparam('param_setting', vars);
    plt_params.param_setting.fig_issave = ~isempty(plt_params.param_setting.fig_dir);
end

%%%%%%%%%%%%%%%%%%%
%
%     figconfig.fig_size{5,2} = [0.15 0.02 0.4 0.95];
%     figconfig.fig_margin{5,2} = [0.17, 0.17, 0.07, 0.03];
%     figconfig.fig_gap{5,2} = [0.04 0.05];
%
%figconfig.paper.fig_size{2,1} = [0.15 0.1 0.65 0.75];%[];%[0.2 0.15 0.5 0.8];
%figconfig.paper.fig_margin{2,1} = [0.18, 0.12, 0.1, 0.05];%[];%[0.2, 0.15, 0.1, 0.05];
%figconfig.paper.fig_gap{2,1} =  [0.12 0.12];%[];%[0.1 0.1];
%
%figconfig.paper.fig_sizet{2,1} = [0.1 0.15 0.85 0.7];
%figconfig.paper.fig_margint{2,1} = [0.15, 0.07, 0.05, 0.03];
%figconfig.paper.fig_gapt{2,1} = [0.1 0.1];

%figconfig.paper.fig_sizet{1,2} = [0.1 0.15 0.75 0.65];%[];%[0.2 0.15 0.5 0.8];
%figconfig.paper.fig_margint{1,2} = [0.18, 0.12, 0.1, 0.05];%[];%[0.2, 0.15, 0.1, 0.05];
%figconfig.paper.fig_gapt{1,2} =  [0.12 0.12];%[];%[0.1 0.1];
%
%     figconfig.paper.fig_sizet{1,2} = [0.1 0.15 0.7 0.65];%[];%[0.2 0.15 0.5 0.8];
%     figconfig.paper.fig_margint{1,2} = [0.23, 0.13, 0.1, 0.05];%[];%[0.2, 0.15, 0.1, 0.05];
%     figconfig.paper.fig_gapt{1,2} =  [0.15 0.15];%[];%[0.1 0.1];
%     %
%     figconfig.paper.fig_size{1,2} = [0.1 0.15 0.85 0.7];
%     figconfig.paper.fig_margin{1,2} = [0.15, 0.07, 0.05, 0.03];
%     figconfig.paper.fig_gap{1,2} = [0.1 0.1];
%
%
%     figconfig.fig_sizet{1,3} = [0.05, 0.15, 0.95, 0.55];
%     figconfig.fig_margint{1,3} = [0.15 0.07 0.05 0.03];
%     figconfig.fig_gapt{1,3} = [0.1 0.1];
%
%
%figconfig.paper.fig_size{2,2} = [0.15 0.05 0.6 0.9];
%figconfig.paper.fig_margin{2,2} = [0.12, 0.1, 0.05, 0.05];
%figconfig.paper.fig_gap{2,2} = [0.15 0.1];

%
%
%     figconfig.fig_size{3,2} = [];%[0.15 0.05 0.6 0.9];
%     figconfig.fig_margin{3,2} = [];%[0.12, 0.1, 0.05, 0.05];
%     figconfig.fig_gap{3,2} = [];%[0.15 0.1];
%
%
%
%
%     figconfig.fig_sizet{6,2} = [];%[0.15 0.02 0.4 0.95];
%     figconfig.fig_margint{6,2} = [];%[0.05, 0.1, 0.03, 0.01];
%     figconfig.fig_gapt{6,2} = [];%[0.01 0.01];
%
