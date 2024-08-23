% Task 5. Define a procedure to determine if two records are equal equivalent subsimilar
% or different. Given two records the procedure must return the corresponding atom to
% their category. Two records are:

% * equal if their names cardinality and items all correspond to each other
% * equivalent if their names and cardinality correspond but at least one of their items have different values
% * subsimilar if one of the records is contained in the other
% * different in any other case

local

    % Define the procedure to determine the relationship between two records
    proc {CompareRecords Record1 Record2 Result}
        
        % Check if the records are equal
        if Record1 == Record2 then
            Result = 'equal'
        else

            % Check if the records are equivalent
            if {And {Record.label Record1} == {Record.label Record2} {SizeOfRecord Record1} == {SizeOfRecord Record2}} then
                Result = 'equivalent'
            else
                local CheckSubsimilar in
                    
                    % Check if one record is a subsimilar of the other
                    {IsSubsimilar Record1 Record2 CheckSubsimilar}

                    % If CheckSubsimilar is true then the records are subsimilar
                    if CheckSubsimilar == true then
                        Result = 'subsimilar'
                    else
                        Result = 'different'
                    end
                end
            end
        end

    end

    % Helper proc to check if one record is a subsimilar of the other
    proc {IsSubsimilar Record1 Record2 Result}

        % Check if Record1 is a subsimilar of Record2
        if {Record.label Record1} == {Record.label Record2} then

            if {SizeOfRecord Record1} >= {SizeOfRecord Record2} then
                
                Result = {IsSubsimilarHelper Record1 Record2}

            else

                Result = {IsSubsimilarHelper Record2 Record1}

            end

        else 
            Result = nil
        end

    end

    % Helper function to check if one list is a subsimilar of the other (contained in the other)
    fun {IsSubsimilarHelper Record1 Record2}
        
        % List 1 will always be bigger than List 2 (or equal)
        local RecordList1 RecordList2 in

            RecordList1 = {Record.toList Record1}
            RecordList2 = {Record.toList Record2}

            % god bless List.sub for making this so easy
            % check if RecordList2 is a sublist of RecordList1 (contained in RecordList1)
            {List.sub RecordList2 RecordList1}

        end
    end

    % helper function to get the size of a record (because I couldn't find a built-in function)
    fun {SizeOfRecord RecordGiven} 
        % fun fact: Record is a reserved word in Oz so I had to use RecordGiven
        local RecordList in

            RecordList = {Record.toList RecordGiven}

            {List.length RecordList}

        end

    end
in 

    local Equal1 Equal2 Equivalent1 Equivalent2 Equivalent3 Equivalent4 Subsimilar1 Subsimilar2 Different1 Different2 in

            % Define the records

            local TestCase1Result TestCase2Result TestCase3Result TestCase4Result TestCase5Result in
            
            % Equal records (same name cardinality and items)
            Equal1 = record('1': 'A' '2': 3 '3': [1 2 3])
            Equal2 = record('1': 'A' '2': 3 '3': [1 2 3])

            % Equivalent records (same name and cardinality but different items)
            Equivalent1 = record('1': 'A' '2': 3 '3': [1 2 3])
            Equivalent2 = record('1': 'A' '2': 3 '3': [1 2 4])

            % Equivalent records, but now with different keys instead of values
            Equivalent3 = record('1': 'A' '2': 3 '3': [1 2 3])
            Equivalent4 = record('1': 'A' '2': 3 '4': [1 2 3])

            % Subsimilar records (one record is contained in the other)
            Subsimilar1 = record('1': 'A' '2': 3 '3': [1 2 3])
            Subsimilar2 = record('1': 'A' '2': 3)

            % Different records (different name cardinality and items)
            Different1 = record('1': 'A' '2': 3 '3': [1 2 3])
            Different2 = potato(round: 'yes')

            % Test cases
            % Test case 1: Equal records
            % {Browse ['Records' Equal1 'and' Equal2 'are' {CompareRecords Equal1 Equal2}]}
            {CompareRecords Equal1 Equal2 TestCase1Result}
            {Browse ['Records' Equal1 'and' Equal2 'are' TestCase1Result]}

            % Test case 2: Equivalent records
            % {Browse ['Records' Equivalent1 'and' Equivalent2 'are' {CompareRecords Equivalent1 Equivalent2}]}
            {CompareRecords Equivalent1 Equivalent2 TestCase2Result}
            {Browse ['Records' Equivalent1 'and' Equivalent2 'are' TestCase2Result]}

            % Test case 3: Equivalent records with different keys
            % {Browse ['Records' Equivalent3 'and' Equivalent4 'are' {CompareRecords Equivalent3 Equivalent4}]}
            {CompareRecords Equivalent3 Equivalent4 TestCase3Result}
            {Browse ['Records' Equivalent3 'and' Equivalent4 'are' TestCase3Result]}

            % Test case 4: Subsimilar records
            % {Browse ['Records' Subsimilar1 'and' Subsimilar2 'are' {CompareRecords Subsimilar1 Subsimilar2}]}
            {CompareRecords Subsimilar1 Subsimilar2 TestCase4Result}
            {Browse ['Records' Subsimilar1 'and' Subsimilar2 'are' TestCase4Result]}

            % Test case 5: Different records
            % {Browse ['Records' Different1 'and' Different2 'are' {CompareRecords Different1 Different2}]}
            {CompareRecords Different1 Different2 TestCase5Result}
            {Browse ['Records' Different1 'and' Different2 'are' TestCase5Result]}
            
        end
    end

end