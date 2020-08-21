function plt_hold(str)
    if ~exist('str')
        str = 'on';
    end
    global plt_params;
    switch str
        case 'on'
            plt_params.isholdon = true;
        case 'off'
            plt_params.isholdon = false;
    end
end
