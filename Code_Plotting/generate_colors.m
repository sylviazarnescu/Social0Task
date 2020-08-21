function colors = generate_colors()
    colors = [];
    colors.AZred = [171,5,32]/256;
    colors.AZblue = [12,35,75]/256;
    colors.AZcactus = [92, 135, 39]/256;
    colors.AZsky = [132, 210, 226]/256;
    colors.AZriver = [7, 104, 115]/256;
    colors.AZsand = [241, 158, 31]/256;
    colors.AZmesa = [183, 85, 39]/256;
    colors.AZbrick = [74, 48, 39]/256;
    fns = fieldnames(colors);
    for ci = 1:length(fns)
        colors.(strcat('light_', fns{ci})) = 0.5*colors.(fns{ci}) + 0.5*ones(1,3);
    end
    colors.black = [0 0 0];
    colors.white = [1 1 1];
end
