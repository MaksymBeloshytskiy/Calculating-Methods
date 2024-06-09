classdef InterpolationAndDifferentiationGUI < handle
    properties
        figureHandle
        interpolationMethodPopup
        differentiationMethodPopup
        fileEdit
        interpolateButton
        differentiateButton
        xData = []
        yData = []
        xInterp = []
        xDiff = []
    end
    
    methods
        function obj = InterpolationAndDifferentiationGUI()
            % Create main figure
            obj.figureHandle = figure('Name', 'Interpolation and Differentiation GUI', 'NumberTitle', 'off',...
                'Position', [100, 100, 400, 200]);
            % Create UI controls
            uicontrol('Style', 'text', 'String', 'Interpolation Method:', 'Position', [20, 150, 120, 20]);
            obj.interpolationMethodPopup = uicontrol('Style', 'popupmenu', 'String', {'Lagrange', 'Newton'},...
                'Position', [150, 150, 120, 20]);
            uicontrol('Style', 'text', 'String', 'Differentiation Method:', 'Position', [20, 120, 120, 20]);
            obj.differentiationMethodPopup = uicontrol('Style', 'popupmenu', 'String', {'Interpolation', 'Approximate'},...
                'Position', [150, 120, 120, 20]);
            uicontrol('Style', 'text', 'String', 'Data File:', 'Position', [20, 90, 80, 20]);
            obj.fileEdit = uicontrol('Style', 'edit', 'Position', [100, 90, 200, 20]);
            obj.interpolateButton = uicontrol('Style', 'pushbutton', 'String', 'Interpolate', 'Position', [100, 50, 80, 30],...
                'Callback', @(src, event) obj.interpolateCallback());
            obj.differentiateButton = uicontrol('Style', 'pushbutton', 'String', 'Differentiate', 'Position', [220, 50, 100, 30],...
                'Callback', @(src, event) obj.differentiateCallback());
        end
        
        function interpolateCallback(obj)
            method = get(obj.interpolationMethodPopup, 'Value');
            if method == 1 % Lagrange
                if ~isempty(obj.xData) && ~isempty(obj.yData) && ~isempty(obj.xInterp)
                    if exist(obj.fileEdit.String, 'file') == 2
                        % Read data from file
                        data = load(obj.fileEdit.String);
                        obj.xData = data(:, 1);
                        obj.yData = data(:, 2);
                    end
                    if length(obj.xData) == length(obj.yData)
                        if isequal(unique(diff(obj.xData)), diff(obj.xData(1:2)))
                            if all(obj.xInterp >= min(obj.xData)) && all(obj.xInterp <= max(obj.xData))
                                % Interpolate using Lagrange method
                                if method == 1
                                    interpolatedValues = obj.lagrangeInterpolation(obj.xData, obj.yData, obj.xInterp);
                                    % Display or use interpolatedValues as needed
                                end
                            else
                                errordlg('Interpolation points are outside the range of data.', 'Error');
                            end
                        else
                            errordlg('X values in data are not equally spaced.', 'Error');
                        end
                    else
                        errordlg('Number of X and Y values in data do not match.', 'Error');
                    end
                else
                    errordlg('Input data missing.', 'Error');
                end
            end
        end
        
        function differentiateCallback(obj)
            method = get(obj.differentiationMethodPopup, 'Value');
            if method == 1 % Interpolation
                if ~isempty(obj.xData) && ~isempty(obj.yData) && ~isempty(obj.xDiff)
                    if exist(obj.fileEdit.String, 'file') == 2
                        % Read data from file
                        data = load(obj.fileEdit.String);
                        obj.xData = data(:, 1);
                        obj.yData = data(:, 2);
                    end
                    if length(obj.xData) == length(obj.yData)
                        if isequal(unique(diff(obj.xData)), diff(obj.xData(1:2)))
                            if all(obj.xDiff >= min(obj.xData)) && all(obj.xDiff <= max(obj.xData))
                                % Differentiate using interpolation method
                                if method == 1
                                    differentiatedValues = obj.differentiateInterpolation(obj.xData, obj.yData, obj.xDiff);
                                    % Display or use differentiatedValues as needed
                                end
                            else
                                errordlg('Differentiation points are outside the range of data.', 'Error');
                            end
                        else
                            errordlg('X values in data are not equally spaced.', 'Error');
                        end
                    else
                        errordlg('Number of X and Y values in data do not match.', 'Error');
                    end
                else
                    errordlg('Input data missing.', 'Error');
                end
            elseif method == 2 % Approximate
                % Implement differentiation using approximate method
                % based on obj.approximateDifferentiation() method
            end
        end
        
        function F = lagrangeInterpolation(obj, x, f, X)
            n = length(x);
            F = zeros(size(X));
            for k = 1:length(X)
                L = ones(n, 1);
                for i = 1:n
                    for j = 1:n
                        if i ~= j
                            L(i) = L(i) * (X(k) - x(j)) / (x(i) - x(j));
                        end
                    end
                end
                F(k) = sum(f .* L');
            end
        end
        
        function F = differentiateInterpolation(obj, x, f, X)
            F = zeros(size(X));
            h = x(2) - x(1); % Assuming uniform spacing
            for k = 1:length(X)
                F(k) = (f(3) - f(1)) / (2 * h); % Central difference for simplicity
            end
        end
    end
end
