% Pelle Reyniers
function [plates, corrs]=findIndices(input, totalCharacters, letters, Images)
% Function findIndices gets as an input a vector with container information.
% This information contains location and size of the containers containing
% the interesting regions in the image. This function will make an educated
% guess on which containers are probably part of the license plate an which
% containers probably aren't.
% The output values is an array with indices of the corresponding
% intersting containers.

[n,xout]=hist(input(:,4)); 
bar(xout,n);
ind=find(n>=totalCharacters); 
for a=1:length(input)            
    combo(a)=input(a,2) * input(a,4); 
end
input2=cat(2,input,combo');           
[n2,xout2]=hist(input2(:,5),20);
ind2=find(n2>=totalCharacters);                 

plates=[];
corrs=[];

if length(ind)>=1 
    for x=1:length(ind) 
        % find middle point, find width, make box, add result to output.
        MP=xout(ind(x));    
        binsize=xout(2)-xout(1); 
        container=[MP-(binsize/2) MP+(binsize/2)]; 
        temp=takeboxes(input,container,2);
        [p,c] = eliminateOptions(temp, totalCharacters, letters, Images);
        plates = cat(2,plates,p');
        corrs = cat(2,corrs,c');
    end
    
elseif length(ind2)>=1
    for x=1:length(ind) 
        % find middle point, find width, make box, add result to output.
        MP=xout2(ind2(x));    
        binsize=xout2(2)-xout2(1); 
        container=[MP-(binsize/2) MP+(binsize/2)]; 
        temp=takeboxes(input,container,2);
        [p,c]=eliminateOptions(temp, totalCharacters, letters, Images);
        plates = cat(2,plates,p');
        corrs = cat(2,corrs,c');
    end
end
end

