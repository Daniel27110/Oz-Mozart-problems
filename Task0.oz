% Class exercise: find the largest character in a string
% aka. find the largest element in a list of characters

% local String StringChevere StringChevereSorteado MaxChar in

%     String = 'Hello, World!'

%     StringChevere = {AtomToString String}

%     StringChevereSorteado = {List.sort StringChevere Value.'>'}

%     MaxChar = StringChevereSorteado.1

%     {Browse ['El caracter mas grande es:' MaxChar]}

%     {Browse ['Este valor equivale a una:' {Char.toAtom MaxChar}]}


% end


local
    fun {MaxList L1}
     case L1
     of nil then 0
     [] X|Xr then
      if {MaxList Xr}>X then {MaxList Xr}
       else X
      end
     end
    end
in
{Browse {MaxList [1 2 3 4 3]}}
end

