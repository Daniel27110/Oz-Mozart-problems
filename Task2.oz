% Task 2. Write a program that given two list representations of polynomials, returns
% the addition of the polynomials as a single list. Lists are commonly used to represent
% polynomials, where each position of the list contains the coeficient of the corresponding
% polynomial degree. From left to right, the most significant degree until reaching the
% constant factor. For example, the list [3 1 0 5 2] represents the polynomial pf degree 4
% 3x4 + x3 + 5x + 2.

% Example 1:
%  [ 1 -2 ] + [ 4 3 2 1 ] = [ 4 3 3 -1 ]

% Example 2:
%  [ 3 0 0 4 1 -5 ] + [ 0 2 -1 1 4 10 ] = [ 3 2 -1 5 5 5 ]

local 

    % Recursive function that calculates the sum of the elements in the same position of the lists
    fun {SumPolynomials L1 L2}

        local L1New L2New DesiredLength in 

            {Browse ['Adding the polynomials' L1 'and' L2]}
        
            % If the lists are different lengths, pad the shorter list with zeros in the front
            if {List.length L1} > {List.length L2} then

                L1New = L1
                DesiredLength = {List.length L1} - {List.length L2}
                % L2New =  {List.make DesiredLength }
                L2New = {List.append {ListOfZeros DesiredLength} L2}

            else

                L2New = L2
                DesiredLength = {List.length L2} - {List.length L1}
                % L1New =  {List.make DesiredLength }
                L1New = {List.append {ListOfZeros DesiredLength} L1}

            end

            {Browse ['Transformed polynomials:' L1New 'and' L2New]}

            % Recursively add the elements in the same position of the lists using the helper function
            {SumPolynomialsHelper L1New L2New 1}
        
        end

    end

    % helper function to fill in a matrix with a desired number of 0's
    fun {ListOfZeros Size}
        % 0 | {ListOfZeros size - 1}
        if Size < 1 then nil else 0 | {ListOfZeros Size - 1} end
    end


    % Helper function that calculates the sum of the elements in the same position of the lists
    fun {SumPolynomialsHelper L1 L2 Index}
        case L1
        of nil then nil
        [] X1|X1r then
            case L2
            of nil then nil
            [] X2|X2r then
                X1 + X2 | {SumPolynomialsHelper X1r X2r Index + 1}
            end
        end
    end
    


in

    % Test case 1
    % Expected output: [ 4 3 3 -1 ]
    % 1 - 2 + 4 + 3x + 2x^2 + x^3 = 4 + 3x + 3x^2 - x^4
    {Browse ['First test case:']}
    {Browse ['Result:' {SumPolynomials [1 ~2] [4 3 2 1]}]}
    {Browse ['------------------------------------']}


    % Test case 2
    % Expected output: [ 3 2 -1 5 5 5 ]
    % 3 + 4x + x^4 - 5x^5 + 2x^6 + 0x^7 + 0x^8 + 4x^9 + x^10 + 5x^11
    % + 0 + 2x - x^2 + x^3 + 4x^4 + 10x^5 = 3 + 2x - x^2 + 5x^3 + 5x^4 + 5x^5
    {Browse ['Second test case:']}
    {Browse ['Result:' {SumPolynomials [3 0 0 4 1 ~5] [0 2 ~1 1 4 10]}]}
    {Browse ['------------------------------------']}


    % Test case 3
    % Expected output: [ 1 1 0 3 4 ]
    {Browse ['Third test case:']}
    {Browse ['Result:' {SumPolynomials [1 2 3] [1 1 ~1 1 1]}]}
    {Browse ['------------------------------------']}


end
