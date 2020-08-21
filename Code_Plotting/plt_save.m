function plt_save(filename, option)
    if ~exist('option')
        option = 'png';
    end
    global plt_params
    if (plt_params.param_setting.fig_issave)
        if isempty(plt_params.param_setting.fig_dir) && ~ischar(plt_params.param_setting.fig_dir)
            error('set up figdir first');
        end
        if ~isempty(plt_params.param_setting.fig_projectname)
            pn_ = '_';
        else
            pn_ = '';
        end
        filefolder = plt_params.param_setting.fig_dir;
        filefullpath = fullfile(filefolder, ...
            strcat(plt_params.param_setting.fig_projectname, pn_, filename, plt_params.param_setting.fig_suffix, ['.' option]));
        if ~exist(filefolder)
            mkdir(filefolder);
        end
        saveas(plt_params.gf, filefullpath, option);
    end
end
