figure('Name','Image Dilating');
subplot(1,2,1);
imshow(greyImage);
title('Greyscale.');
subplot(1,2,2);
imshow(greyImageImdilate);
title('Greyscale With Dilate.');

figure('Name','Image Eroding');
subplot(1,2,1);
imshow(greyImage);
title('Greyscale.');
subplot(1,2,2);
imshow(greyImageE);
title('Greyscale With Eroding.');

figure('Name','Image All Edges detected');
imshow(gdiff);
