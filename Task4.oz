% Task 4. Define a program to calculate the integral of a function f on a given interval
% [a, b] using Simpson’s rule of integration. Simposon’s rule of integration is defined as
% h/3 *  [y0 + 4y1 + 2y2 + 4y3 + 2y4 + . . . 2yn−2 + 4yn−1 + yn] 
% 
% where h = (b - a ) / n and yk = f (a + kh) with 0 ≤ k ≤ n. n is a given integer, increasing
% the size of n increases the accuracy of the integral.
% Your program integral should receive a given function (of one parameter) (e.g., a
% polynomial), the values of the integration interval a and b, and the precision value n. The
% result of the program should be the single value of the integral.

% ##############################

% This must be done recursively in order to allow for any n value

% ##############################

local 
    
    % Base case for the recursive function
    fun {SimpsonsRule F A B N K}
        
        local H YK Sum X Result in

            % Calculate H
            H = {Float.'/' B - A N} % why is the division function called / and not div??

            % To recursively calculate the sum of the function we first calculate Yk:
            X = {Number.'+' A K * H} % X is a temporary variable to store the value of a + k * h
            YK = {F X}
            % {Browse ['Y0=' YK]}


            % Calculate the sum iteratively using a helper function
            Sum = {SimpsonsRuleHelper F A B N K 0.0 0.0}
            % {Browse ['Sum=' Sum]}

            % Calculate the result
            Result = H / 3.0 * Sum
            % {Browse ['Result=' Result]}

            % return the result
            Result

        end

    end

    % Helper function to calculate the sum of the function
    fun {SimpsonsRuleHelper F A B N K Sum1 Sum2}
        
        local H YK in

            % Calculate H
            H = {Float.'/' B - A N}

            % Calculate Yk
            YK = {F A + K * H}
            % {Browse ['YK=' YK]}

            % Calculate the sum
            if K == N then
                Sum1 + YK
            else
                Sum1 + YK + Sum2 + {SimpsonsRuleHelper F A B N K + 1.0 Sum2 YK}
            end
        end

    end

    
    fun {PolynomialFunction X}
        
        (X * X) + (2.0 * X) + 1.0
        
    end

    fun {LinearFunction X}
        
        2.0 * X + 1.0
        
    end

    fun {ConstantFunction X}
        
        1.0
        
    end
        
in

    % First test case: Polynomial function with n = 100
    {Browse 'Integral of X^2 + 2X + 1 from 0 to 1'} % expected result is ~2.333333333333333
    {Browse {SimpsonsRule PolynomialFunction 0.0 1.0 10000.0 0.0}}
    {Browse ['------------------------------------']}

    % Second test case: Constant function with n = 100
    {Browse 'Integral of 1 from 0 to 1'} % expected result is ~1
    {Browse {SimpsonsRule ConstantFunction 0.0 1.0 10000.0 0.0}}
    {Browse ['------------------------------------']}

    % Third test case: Linear function with n = 10, 1000 and 100000
    {Browse 'Integral of 2X + 1 from 0 to 1 with n = 10'}
    {Browse {SimpsonsRule LinearFunction 0.0 1.0 10.0 0.0}}
    {Browse ['------------------------------------']}

    {Browse 'Integral of 2X + 1 from 0 to 1 with n = 1000'}
    {Browse {SimpsonsRule LinearFunction 0.0 1.0 1000.0 0.0}}
    {Browse ['------------------------------------']}

    {Browse 'Integral of 2X + 1 from 0 to 1 with n = 100000'}
    {Browse {SimpsonsRule LinearFunction 0.0 1.0 100000.0 0.0}}
    {Browse ['------------------------------------']}   
    % we can see that the result is more accurate as n increases
    % in this case, the result gets closer to 2, which is the expected value of the integral of 2X + 1 from 0 to 1



end