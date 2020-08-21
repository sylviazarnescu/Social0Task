function a = tool_encell(a)
    % a = tool_encell(a)
    %   return a {a} if a is not a cell
    if ~exist('a')
        a = {};
    elseif ~iscell(a)
        a = {a};
    end
end
