% Task 1. Write a program that given a list calculates the sum of the elements in odd
% positions of the list and the product of the elements in even positions of the list. The
% result should be map where the first position corresponds to the calculated the product
% and the second position corresponds to the calculated sum.

% Make sure to add examples to test the functionality of each the procedures used to solve the task.

%# ################################################################################################

% IMPORTANT NOTE: WE'LL DEFINE ODD AND EVEN POSITIONS STARTING FROM 1 AS THE FIRST ELEMENT, AS IT'S COMMON IN OZ

% #################################################################################################

local

    % Recursive function that calculates the sum of the elements in odd positions of the list
    fun {SumOddPositions List Index}
        case List
        of nil then 0
        [] X|Xr then
            if Index mod 2 == 0 then
                % skip the element
                {SumOddPositions Xr Index + 1}
            else
                % add the element
                X + {SumOddPositions Xr Index + 1}
            end
        end
    end

    % Recursive function that calculates the product of the elements in even positions of the list
    fun {ProductEvenPositions List Index}
        case List
        of nil then 1
        [] X|Xr then
            if Index mod 2 == 0 then
                % multiply the element
                X * {ProductEvenPositions Xr Index + 1}
            else
                % skip the element
                {ProductEvenPositions Xr Index + 1}
            end
        end
    end

    % Construct the result map
    fun {Result List}
        map('Product of even positions': {ProductEvenPositions List 1} 'Sum of odd positions': {SumOddPositions List 1})
    end

in

    % Test case 1
    % Expected output: [8 9]
    % sum of odd positions: 1 + 3 + 5 = 9
    % product of even positions: 2 * 4 = 8
    {Browse 'First test case'}
    {Browse 'For the list [1 2 3 4 5], the result is:'}
    {Browse {Result [1 2 3 4 5]}}
    {Browse ['------------------------------------']}


    % Test case 2
    % Expected output: [48 9]
    % sum of odd positions: 1 + 3 + 5 = 9
    % product of even positions: 2 * 4 * 6 = 48
    {Browse 'Second test case'}
    {Browse 'For the list [1 2 3 4 5 6], the result is:'}
    {Browse {Result [1 2 3 4 5 6]}}
    {Browse ['------------------------------------']}

    % Test case 3 (empty list, which is represented by nil in Oz, this is a special case)
    % Expected output: [1 0]
    % sum of odd positions: 0
    % product of even positions: 1 (as there are no elements)
    {Browse 'Third test case'}
    {Browse 'For the list [], the result is:'}
    {Browse {Result nil}}
    {Browse ['------------------------------------']}

end