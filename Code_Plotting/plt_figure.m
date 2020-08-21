function [g, ax, rc] = plt_figure(nx, ny, varargin)
    global plt_params
    if (exist('nx')~=1) || isempty(nx) || nx < 1
        nx = 1;
    end
    if (exist('ny')~=1) || isempty(ny) || ny < 1
        ny = 1;
    end
    fmt = plt_params.param_setting.format;
    fg = [];
    fg.istitle = 0;
    fg.matrix_hole = ones(nx, ny);
    inarglist = {'rect', 'margin', 'gap', 'istitle', 'matrix_hole','rect_axes'};
    vars = varargin;
    i = 1;
    while i <= length(vars)
        arg = vars{i};
        idx = find(strcmp(inarglist, arg));
        if strcmp('help', arg)
            i = i + 1;
            disp(inarglist);
        elseif ~isempty(idx)
            val = vars{i+1};
            i = i + 2;
            fg.(arg) = val;
        else
            i = i + 1;
            warning(sprintf('command not recognized: %s', arg));
        end
    end
    if fg.istitle
        istitle = 't';
    else
        istitle = '';
    end
    if  ~isfield(fg, 'rect')
        try
            fg.rect = plt_params.param_preset.figconfig.(fmt).(['fig_size', istitle]){nx,ny};
        catch
            disp('no existing preset rect size');
            fg.rect = plt_params.param_preset.figconfig.(fmt).(['fig_size', istitle]){1,1};
        end
    end
    if plt_params.param_setting.isshow
        g = figure('visible','on');
    else
        g = figure('visible','off');
    end
    set(g, 'units','normalized','outerposition',fg.rect);
    if isfield(fg, 'rect_axes')
        rc = fg.rect_axes;
    else
        if ~isfield(fg, 'margin')
            try
                fg.margin = plt_params.param_preset.figconfig.(fmt).(['fig_margin', istitle]){nx,ny};
            catch
                disp('no existing preset margin size');
                fg.margin = plt_params.param_preset.figconfig.(fmt).(['fig_margin', istitle]){1,1};
            end
        end
        if ~isfield(fg, 'gap')
            try
                fg.gap = plt_params.param_preset.figconfig.(fmt).(['fig_gap', istitle]){nx,ny};
                fg.gap(1); % this is just to test whether gap is empty
            catch
                disp('no existing preset gap size');
                fg.gap = plt_params.param_preset.figconfig.(fmt).(['fig_gap', istitle]){1,1};
            end
        end
        if iscell(fg.gap)
            hg = [NaN fg.gap{1} NaN];
            wg = [NaN fg.gap{2} NaN];
        else
            hg = ones(1, nx+1) * fg.gap(1);
            wg = ones(1, ny+1) * fg.gap(2);
        end
        hg(1) = fg.margin(1);
        wg(1) = fg.margin(2);
        hg(end) = fg.margin(3);
        wg(end) = fg.margin(4);
        hb = (ones(nx,1)-sum(hg)) / nx;
        wb = (ones(ny,1)-sum(wg)) / ny;
        count = 1;
        for i_high = nx:-1:1
            for i_wide = 1:ny
                if fg.matrix_hole(nx+ 1- i_high, i_wide) == 1
                    bx(1) = sum(wg(1:i_wide)) + sum(wb(1:i_wide-1));
                    bx(2) = sum(hg(1:i_high)) + sum(hb(1:i_high-1));
                    bx(3) = wb(i_wide);
                    bx(4) = hb(i_high);
                    rc{count} = bx;
                    count = count + 1;
                end
            end
        end
    end
    for i = 1:length(rc)
        axes('position', rc{i})
        ax(i) = gca;
        set(gca, 'tickdir', 'out');
    end
    plt_params.gf = g;
    plt_params.axes = ax;
    plt_params.axi = 0;
    plt_params.isholdon = false;
    plt_params.leglist = cell(nx*ny);
    plt_setparams('reset');
    plt_setfig('size', [length(rc)]);
end
