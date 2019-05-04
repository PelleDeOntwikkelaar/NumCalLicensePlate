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

figure('Name','H and F');
subplot(1,2,1);
imshow(F);
title('Regions are filled.');
subplot(1,2,2);
imshow(H);
title('Thinnend out image.');

figure('Name','End image manipulation');
imshow(final);

