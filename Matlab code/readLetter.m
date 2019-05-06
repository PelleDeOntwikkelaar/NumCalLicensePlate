function [letter, maxcor]=readLetter(snap)
%READLETTER reads the character fromthe character's binary image.
%   LETTER=READLETTER(SNAP) outputs the character in class 'char' from the
%   input binary image SNAP.

load NewTemplates % Loads the templates of characters in the memory.
snap=imresize(snap,[42 24]); % Resize the input image so it can be compared with the template's images.
comp=[ ];
for n=1:length(NewTemplates)
    sem=corr2(NewTemplates{1,n},snap); % Correlation the input image with every image in the template for best matching.
    comp=[comp sem]; % Record the value of correlation for each template's character.
end
vd=find(comp==max(comp)); % Find the index which correspond to the highest matched character.
maxcor=max(comp);
%*-*-*-*-*-*-*-*-*-*-*-*-*-
% Accodrding to the index assign to 'letter'.
% Alphabets listings.
if vd==1 || vd==2
    letter=65;
elseif vd==3 || vd==4
    letter=66;
elseif vd==5
    letter=67;
elseif vd==6 || vd==7
    letter=68;
elseif vd==8
    letter=69;
elseif vd==9
    letter=70;
elseif vd==10
    letter=71;
elseif vd==11
    letter=72;
elseif vd==12
    letter=73;
elseif vd==13
    letter=74;
elseif vd==14
    letter=75;
elseif vd==15
    letter=76;
elseif vd==16
    letter=77;
elseif vd==17
    letter=78;
elseif vd==18 || vd==19
    letter=79;
elseif vd==20 || vd==21
    letter=80;
elseif vd==22 || vd==23
    letter=81;
elseif vd==24 || vd==25
    letter=82;
elseif vd==26
    letter=83;
elseif vd==27
    letter=84;
elseif vd==28
    letter=85;
elseif vd==29
    letter=86;
elseif vd==30
    letter=87;
elseif vd==31
    letter=88;
elseif vd==32
    letter=89;
elseif vd==33
    letter=90;
    %*-*-*-*-*
% Numerals listings.
elseif vd==34
    letter=31;
elseif vd==35
    letter=32;
elseif vd==36
    letter=33;
elseif vd==37 || vd==38
    letter=34;
elseif vd==39
    letter=35;
elseif vd==40 || vd==41 || vd==42
    letter=36;
elseif vd==43
    letter=37;
elseif vd==44 || vd==45
    letter=38;
elseif vd==46 || vd==47 || vd==48
    letter=39;
else
    letter=30;
end
end