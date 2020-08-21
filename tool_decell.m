function a = tool_decell(a)
    while iscell(a) && length(a) == 1
        a =  a{1};
    end
end
