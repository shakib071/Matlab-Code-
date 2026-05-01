function T = makeResultsTable(t, y, options)

%
%   T = makeResultsTable(t, y)
%   T = makeResultsTable(t, y, options)
%
%   INPUT:
%     t       : (N×1) time vector
%     y       : (N×5) solution matrix [s, r, b, a1, a2]
%     options : struct with optional fields:
%                 .decimals   - decimal places to round to   (default: 4)
%                 .maxRows    - max rows to display           (default: all)
%                 .showTotal  - add TotalBacteria column      (default: true)
%
%   OUTPUT:
%     T : MATLAB table with named columns and rounded values

    % ── Defaults ─────────────────────────────────────────────────────────────
    if nargin < 3 || isempty(options)
        options = struct();
    end
    if ~isfield(options, 'decimals'),  options.decimals  = 4;    end
    if ~isfield(options, 'maxRows'),   options.maxRows   = inf;  end
    if ~isfield(options, 'showTotal'), options.showTotal = true; end

    % ── Validate inputs ───────────────────────────────────────────────────────
    if size(y, 2) ~= 5
        error('makeResultsTable: y must have 5 columns [s, r, b, a1, a2]');
    end
    if length(t) ~= size(y, 1)
        error('makeResultsTable: t and y must have the same number of rows');
    end

    % ── Truncate rows if maxRows set ──────────────────────────────────────────
    n = min(length(t), options.maxRows);
    t = t(1:n);
    y = y(1:n, :);

    % ── Round all values ──────────────────────────────────────────────────────
    dp   = options.decimals;
    t_r  = round(t,        dp);
    s_r  = round(y(:,1),   dp);
    r_r  = round(y(:,2),   dp);
    b_r  = round(y(:,3),   dp);
    a1_r = round(y(:,4),   dp);
    a2_r = round(y(:,5),   dp);

    % ── Build table ───────────────────────────────────────────────────────────
    if options.showTotal
        total_r = round(y(:,1) + y(:,2), dp);
        T = table(t_r, s_r, r_r, total_r, b_r, a1_r, a2_r, ...
            'VariableNames', ...
            {'Time', 'Sensitive', 'Resistant', 'TotalBacteria', ...
             'ImmuneCells', 'INH', 'PZA'});
    else
        T = table(t_r, s_r, r_r, b_r, a1_r, a2_r, ...
            'VariableNames', ...
            {'Time', 'Sensitive', 'Resistant', ...
             'ImmuneCells', 'INH', 'PZA'});
    end
end