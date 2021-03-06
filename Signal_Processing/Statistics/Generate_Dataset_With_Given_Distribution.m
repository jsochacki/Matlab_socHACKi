function [ data_set ] = ...
    Generate_Dataset_With_Given_Distribution( ...
                                             probabilities_at_points, ...
                                             points, ...
                                             data_set_x_values, ...
                                             SAMPLE_SIZE, ...
                                             SMOOTHING)
% Generate_Dataset_With_Given_Distribution
% Generates a dataset that edheres to the provided probabilities
% at the specified points
%   Later

    rotate_data_set_output = 0;

    if size(probabilities_at_points,1) > size(probabilities_at_points,2)
        probabilities_at_points = probabilities_at_points.';
    end

    % Rotate the vectors so there are no errors
    if ~isempty(points)

        if size(points,1) > size(points,2)
            points = points.';
        end

        if length(probabilities_at_points) ~= length(points)
            error(['You don''t have a probability defined for each point'...
                'or you do not have a point defined for each probability' ...
                '\n Please ensure that the length of your probability' ...
                'vector is the same length as your points vector\n' ...
                'length(probabilities) = %d \n' ...
                'length(points) = %d \n'] ...
                ,length(probabilities_at_points) ...
                ,length(points))
        end

        if isempty(data_set_x_values)
            data_set_x_values = linspace(min(points), ...
                                         max(points), ...
                                         10 * length(points));
        else
            if size(data_set_x_values,1) > size(data_set_x_values,2)
                data_set_x_values = data_set_x_values.';
                rotate_data_set_output = 1;
            end
        end

    else

        if ~isempty(data_set_x_values)
            % Really inappropriate but I'll do it anyway
            % I'll assume you have evenly spaced points and you are
            % Running this function for interpolation basically
            % You really need to provide points per probability for any value
            points = linspace(min(data_set_x_values), ...
                              max(data_set_x_values), ...
                              length(probabilities_at_points));
        else
            % User clearly doesn't care so lets just make the points for them
            points = 0 : (length(probabilities_at_points)-1);
            data_set_x_values =  0 : 0.05 : length(probabilities_at_points);
        end

    end

    % Do the smoothing if requested but default is linear interpolation
    if ~isempty(SMOOTHING)
        switch SMOOTHING
            case 'spline'
                pdf = interp1(points, ...
                              probabilities_at_points, ...
                              data_set_x_values, ...
                              'spline');
            otherwise
                pdf = interp1(points, ...
                              probabilities_at_points, ...
                              data_set_x_values);
        end
    else
        pdf = interp1(points, ...
                      probabilities_at_points, ...
                      data_set_x_values);
    end
    
    %Do the Math
    % Remove impossible probabilities due to interpolation
    pdf(pdf < 0) = 0;
    % Normalize so we have a cumulative probability of 1
    pdf = pdf / sum(pdf);
    % Generate the CDF
    cdf = cumsum(pdf);
    % Remove non-unique values
    [cdf, mask] = unique(cdf);
    data_set_x_values = data_set_x_values(mask);
    % Create the uniform random value set
    uniform_random_values = rand(1, SAMPLE_SIZE);
    % Finally create the data set
    data_set = interp1(cdf, data_set_x_values, uniform_random_values);

    if rotate_data_set_output == 1
        data_set = data_set.';
    end

    % hist(data_set, 50);
    
end
