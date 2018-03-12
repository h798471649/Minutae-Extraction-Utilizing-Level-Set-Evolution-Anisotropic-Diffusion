function v = GetOptions(options, name, v0)

% getoptions - retrieve options with optional default value v0.
% Copyright 2015 J.M. Mirebeau. Original file: 2007 Gabriel Peyre.

if nargin >3
    error('Too many arguments');
elseif nargin<2
    error('Not enough arguments.');
elseif isfield(options, name)
    v = options.(name);
elseif nargin==3
    v=v0;  
    if isfield(options,'verbose') && options.verbose
        disp(['Using default value for options.' name ' : ']);
        disp(v)
    end
else
    error(['You have to provide options.' name '.']);
end 