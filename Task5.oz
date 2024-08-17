% Task 5. Define a procedure to determine if two records are equal equivalent subsimilar
% or different. Given two records the procedure must return the corresponding atom to
% their category. Two records are:

% * equal if their names cardinality and items all correspond to each other
% * equivalent if their names and cardinality correspond but at least one of their items have different values
% * subsimilar if one of the records is contained in the other
% * different in any other case

local

    % Define the procedure to determine the relationship between two records
    fun {CompareRecords Record1 Record2}
        
        % Check if the records are equal
        if Record1 == Record2 then
            'equal'
        else
            % Check if the records are equivalent
            if {And {Record.label Record1} == {Record.label Record2} {Record.arity Record1} == {Record.arity Record2}} then
                'equivalent'
            else
                % Check if one record is a subsimilar of the other
                if {IsSubsimilar Record1 Record2} then
                    'subsimilar'
                else
                    'different'
                end
            end
        end

    end

    % Helper function to check if one record is a subsimilar of the other
    fun {IsSubsimilar Record1 Record2}

        % Check if Record1 is a subsimilar of Record2
        if {Record.label Record1} == {Record.label Record2} then

            if {SizeOfRecord Record1} >= {SizeOfRecord Record2} then
                
                {IsSubsimilarHelper Record1 Record2}

            else

                {IsSubsimilarHelper Record2 Record1}

            end

        else false end

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

    % helper fun                else false endction to get the length of a record iterating over its items recursively until nil
    fun {SizeOfRecord RecordGiven} 
        % fun fact: Record is a reserved word in Oz so I had to use RecordGiven
        local RecordList in

            RecordList = {Record.toList RecordGiven}

            {List.length RecordList}

        end

    end
in 

    local Equal1 Equal2 Equivalent1 Equivalent2 Subsimilar1 Subsimilar2 Different1 Different2 in

        % Define the records
        
        % Equal records (same name cardinality and items)
        Equal1 = record(1: 'A' 2: 3 3: [1 2 3])
        Equal2 = record(1: 'A' 2: 3 3: [1 2 3])

        % Equivalent records (same name and cardinality but different items)
        Equivalent1 = record(1: 'A' 2: 3 3: [1 2 3])
        Equivalent2 = record(1: 'A' 2: 3 3: [1 2 4])

        % Subsimilar records (one record is contained in the other)
        Subsimilar1 = record(1: 'A' 2: 3 3: [1 2 3])
        Subsimilar2 = record(1: 'A' 2: 3)

        % Different records (different name cardinality and items)
        Different1 = record(1: 'A' 2: 3 3: [1 2 3])
        Different2 = potato(round: 'yes')

        % Test cases
        % Test case 1: Equal records
        {Browse ['Records' Equal1 'and' Equal2 'are' {CompareRecords Equal1 Equal2}]}

        % Test case 2: Equivalent records
        {Browse ['Records' Equivalent1 'and' Equivalent2 'are' {CompareRecords Equivalent1 Equivalent2}]}

        % Test case 3: Subsimilar records
        {Browse ['Records' Subsimilar1 'and' Subsimilar2 'are' {CompareRecords Subsimilar1 Subsimilar2}]}

        % Test case 4: Different records
        {Browse ['Records' Different1 'and' Different2 'are' {CompareRecords Different1 Different2}]}

    end

end