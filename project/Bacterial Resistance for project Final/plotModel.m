function plotModel(t, y, plotType, options)
% PLOTMODEL  Plot ODE solution for bacterial resistance model.
%
%   plotModel(t, y, plotType)
%   plotModel(t, y, plotType, options)
%
%   plotType:
%     'all'       → all 5 variables (s, r, b, INH, PZA)
%     'bacteria'  → total bacteria (s+r) vs immune cells (b)
%     'phase'     → phase portrait s vs r
%
%   options (optional struct):
%     .title      - override default title
%     .ylim       - y axis limits e.g. [-0.2 1.05]
%     .xlim       - x axis limits e.g. [0 90]
%     .lineWidth  - line width (default 2)
%     .fontSize   - font size  (default 12)

    % ── Defaults ─────────────────────────────────────────────────────────────
    if nargin < 4 || isempty(options)
        options = struct();
    end
    if ~isfield(options, 'lineWidth'), options.lineWidth = 2;  end
    if ~isfield(options, 'fontSize'),  options.fontSize  = 12; end
    if ~isfield(options, 'title'),     options.title     = ''; end
    if ~isfield(options, 'ylim'),      options.ylim      = []; end
    if ~isfield(options, 'xlim'),      options.xlim      = []; end

    % ── Extract variables ─────────────────────────────────────────────────────
    s  = y(:,1);
    r  = y(:,2);
    b  = y(:,3);
    a1 = y(:,4);
    a2 = y(:,5);

    lw = options.lineWidth;
    fs = options.fontSize;

    % ── Plot types ────────────────────────────────────────────────────────────
    switch lower(plotType)

        % ── ALL VARIABLES ─────────────────────────────────────────────────────
        case 'all'
            figure;
            hold on; grid on; box on;

            plot(t, s,  'b', 'LineWidth', lw);
            plot(t, r,  'g', 'LineWidth', lw);
            plot(t, b,  'r', 'LineWidth', lw);
            plot(t, a1, 'c', 'LineWidth', lw);
            plot(t, a2, 'm', 'LineWidth', lw);

            xlabel('Time (days)',                      'FontSize', fs);
            ylabel('Bacteria, Immune Cells, Antibiotics', 'FontSize', fs);
            legend('s','r','b','INH','PZA',            'Location','best');

            % default title if none given
            if isempty(options.title)
                options.title = 'Time-Dependent Changes of All Variables';
            end

        % ── BACTERIA vs IMMUNE CELLS ──────────────────────────────────────────
        case 'bacteria'
            figure;
            hold on; grid on; box on;

            plot(t, s + r, 'b', 'LineWidth', lw);
            plot(t, b,     'g', 'LineWidth', lw);

            xlabel('Time (days)',            'FontSize', fs);
            ylabel('Bacteria & Immune Cells','FontSize', fs);
            legend('s+r', 'b',              'Location','best');

            if isempty(options.title)
                options.title = 'Time-Dependent Changes of Bacteria and Immune Cells';
            end

        % ── PHASE PORTRAIT ────────────────────────────────────────────────────
        case 'phase'
            figure;
            hold on; grid on; box on;

            plot(s, r, 'b', 'LineWidth', lw);

            % start and end markers
            plot(s(1),   r(1),   'ks', 'MarkerFaceColor', 'k', ...
                                       'MarkerSize', 8);
            plot(s(end), r(end), 'ks', 'MarkerFaceColor', 'r', ...
                                       'MarkerSize', 8);

            xlabel('Sensitive Bacteria', 'FontSize', fs);
            ylabel('Resistant Bacteria', 'FontSize', fs);
            legend('Trajectory', 'Start', 'End', 'Location', 'best');

            if isempty(options.title)
                options.title = 'Phase Portrait: Sensitive vs Resistant Bacteria';
            end

        otherwise
            error('plotModel: unknown plotType "%s". Use all/bacteria/phase', ...
                   plotType);
    end

    % ── Apply shared formatting ───────────────────────────────────────────────
    title(options.title, 'FontSize', fs + 1);

    if ~isempty(options.ylim), ylim(options.ylim); end
    if ~isempty(options.xlim), xlim(options.xlim); end
end