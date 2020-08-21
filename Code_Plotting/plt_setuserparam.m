function plt_setuserparam(fd, vars)
    global plt_params;
    inarglist = fieldnames(plt_params.(fd));
    i = 1;
    while i <= length(vars)
        arg = vars{i};
        idx = find(strcmp(inarglist, arg));
        if strcmp('help', arg)
            i = i + 1;
            disp(inarglist);
        elseif strcmp('reset', arg) ||strcmp('new', arg)
            i = i + 1;
            disp('resetting plt params');
        elseif ~isempty(idx)
            val = vars{i+1};
            i = i + 2;
            plt_params.(fd).(arg) = val;
        else
            i = i + 1;
            warning(sprintf('command not recognized: %s', arg));
        end
    end
end
