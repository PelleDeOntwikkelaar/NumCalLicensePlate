% Pelle Reyniers
function [licenseOut, corrOut]=eliminateOptions(candidate, totalCharacters, letters, Images)
% This function is designed to guess every character in a license plate and
% reduce the license plate to the size previously stated.
% return the possible license plate and average corr.
tempPlateCh= [];
tempPlateCo= [];
for v=1:length(candidate)
    N=Images{1,candidate(v)}; 
    [letter corr]=readLetter(N); 
    while letter==79 || letter==30
        if v<=letters                      
            letter=79;              
        else                         
            letter=30;              
        end                          
        break;                       
    end
    tempPlateCh = [tempPlateCh letter];
    tempPlateCo = [tempPlateCo corr];
end
% eliminate characters with lowest corr until restrictions are met
while length(tempPlateCh)>totalCharacters
    [M,I] = min(tempPlateCo);
    tempPlateCh(I) = [];
    tempPlateCo(I) = [];
end
licenseOut = tempPlateCh;
corrOut = sum(tempPlateCo)/length(tempPlateCo);
end