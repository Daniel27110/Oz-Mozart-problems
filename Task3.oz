% Task 3. Implement a binary tree structure and the algorithms to build a tree from its
% orderings (inorder + postorder and inorder + preorder). To test this program the func-
% tions inorderPreorder2BT and inorderPostorder2BT receive two lists (containing numbers,
% characters, or a combination of them), the corresponding orderings of a tree, and return
% a binary tree build from the two lists.

% ##############################

% Binary tree structure:

% tree(Value, Left, Right)
% Left and Right are either nil or another tree

% ##############################

% Build tree from inorder and postorder lists algorithm:

% 1. The last element of the postorder list is the root of the tree
% 2. Find the root in the inorder list. Everything to the left of
% the root in the inorder list is the left subtree and everything to the right is the right subtree
% 3. Recursively build the left and right subtrees by calling the function with the left and right
% subtrees of the inorder list and the postorder list

% ##############################

% Build tree from inorder and preorder lists algorithm:

% 1. The first element of the preorder list is the root of the tree
% 2. Find the root in the inorder list. Everything to the left of
% the root in the inorder list is the left subtree and everything                 % Left = {Take Inorder 1 Index}
                % Right = {Take Inorder Index+1 {List.length Inorder}}to the right is the right subtree
% 3. Recursively build the left and right subtrees by calling the function with the left and right
% subtrees of the inorder list and the preorder list

% ##############################

% Refereces for the algorithm steps:

% GeeksforGeeks. (2023, 24 February). Construct a Binary Tree from Postorder and Inorder. GeeksforGeeks. https://www.geeksforgeeks.org/construct-a-binary-tree-from-postorder-and-inorder/
% GeeksforGeeks. (2024, 12 July). Construct Tree from given Inorder and Preorder traversals. GeeksforGeeks. https://www.geeksforgeeks.org/construct-tree-from-given-inorder-and-preorder-traversal/

% ##############################

local

    fun {InorderPostorder2BT Inorder Postorder}

        local Root Index LeftInorder RightInorder LeftPostorder RightPostorder LeftLength RightLength in

            if Postorder == nil then 
                
                nil    

            else

                % The last element of the postorder list is the root of the tree
                Root = {List.last Postorder}
                % Find the root in the inorder list
                Index = {IndexInList Inorder Root 1}

                % Split the inorder list into left and right subtrees
                if Index == 1 then LeftInorder = nil
                else LeftInorder = {List.take Inorder Index - 1} end

                if Index == {List.length Inorder} then RightInorder = nil
                else RightInorder = {List.drop Inorder Index} end

                % Calculate the length of the left subtree
                LeftLength = {List.length LeftInorder}
                RightLength = {List.length Postorder} - LeftLength - 1

                % Split the postorder list into left and right subtrees
                if LeftLength == 0 then LeftPostorder = nil
                else LeftPostorder = {List.take Postorder LeftLength} end

                if Index == {List.length Inorder} then RightPostorder = nil
                else RightPostorder = {List.take {List.drop Postorder LeftLength} RightLength} end

                % Print the current root and subtrees for debugging
                % {Browse [Root Index]}
                % {Browse [LeftInorder RightInorder]}
                % {Browse [LeftPostorder RightPostorder]}

                % Recursively build the left and right subtrees
                {NewTree Root {InorderPostorder2BT LeftInorder LeftPostorder} {InorderPostorder2BT RightInorder RightPostorder}}

            end
        end
    end

    fun {InorderPreorder2BT Inorder Preorder}

        local Root Index LeftInorder RightInorder LeftPreorder RightPreorder LeftLength RightLength in

            if Preorder == nil then 
                
                nil    

            else

                % The first element of the preorder list is the root of the tree
                Root = Preorder.1
                % Find the root in the inorder list
                Index = {IndexInList Inorder Root 1}

                % Split the inorder list into left and right subtrees
                if Index == 1 then LeftInorder = nil
                else LeftInorder = {List.take Inorder Index - 1} end

                if Index == {List.length Inorder} then RightInorder = nil
                else RightInorder = {List.drop Inorder Index} end

                % Calculate the length of the left subtree
                LeftLength = {List.length LeftInorder}
                RightLength = {List.length Preorder} - LeftLength - 1

                % Split the preorder list into left and right subtrees
                if LeftLength == 0 then LeftPreorder = nil
                else LeftPreorder = {List.take {List.drop Preorder 1} LeftLength} end

                if Index == {List.length Inorder} then RightPreorder = nil
                else RightPreorder = {List.take {List.drop Preorder LeftLength + 1} RightLength} end

                % Print the current root and subtrees for debugging
                % {Browse [Root Index]}
                % {Browse [LeftInorder RightInorder]}
                % {Browse [LeftPreorder RightPreorder]}

                % Recursively build the left and right subtrees
                {NewTree Root {InorderPreorder2BT LeftInorder LeftPreorder} {InorderPreorder2BT RightInorder RightPreorder}}

            end
        end
    end

    fun {IndexInList List Element Index}
        case List
        of nil then nil
        [] X|Xr then
            if X == Element then Index
            else {IndexInList Xr Element Index+1}
            end
        end
    end

    fun {NewTree Value Left Right}
        tree(Value Left Right)
    end

in

    % Test cases
    % First test case: 
    % Visual representation of the tree:
    %     2
    %    / \
    %   1   3
    % The representation of this tree is: tree(2 tree(1 nil nil) tree(3 nil nil))
    {Browse 'First test case'}
    {Browse 'For the inorder list [1 2 3] and postorder list [1 3 2], the tree is:'}
    {Browse {InorderPostorder2BT [1 2 3] [1 3 2]}}
    {Browse 'For the inorder list [1 2 3] and preorder list [2 1 3], the tree is:'}
    {Browse {InorderPreorder2BT [1 2 3] [2 1 3]}}
    {Browse ['------------------------------------']}

    % Second test case:
    % Visual representation of the tree:
    %     4
    %    / \
    %   2   6
    %  / \ / \
    % 1  3 5  7
    % The representation of this tree is: tree(4 tree(2 tree(1 nil nil) tree(3 nil nil)) tree(6 tree(5 nil nil) tree(7 nil nil))
    {Browse 'Second test case'}
    {Browse 'For the inorder list [1 2 3 4 5 6 7] and postorder list [1 3 2 5 7 6 4], the tree is:'}
    {Browse {InorderPostorder2BT [1 2 3 4 5 6 7] [1 3 2 5 7 6 4]}}
    {Browse 'For the inorder list [1 2 3 4 5 6 7] and preorder list [4 2 1 3 6 5 7], the tree is:'}
    {Browse {InorderPreorder2BT [1 2 3 4 5 6 7] [4 2 1 3 6 5 7]}}
    {Browse ['------------------------------------']}


end