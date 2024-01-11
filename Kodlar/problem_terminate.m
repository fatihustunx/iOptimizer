function [popsize, n, maxFE, lb, ub] = problem_terminate()

    % Parameter settings:
    
    % ecosystem (population) size
    popsize = 50;

    % problem dimension
    n = 5;

    % number of function evaluations
    maxFE = 10 * n;

    % problem lower band 
    lowerBand =0;
    lb = ones(1, n) * lowerBand;

    % problem upper band
    upperBand = 1;
    ub = ones(1, n) * upperBand;

end

