I = imread('sony.png');
Vanishing_Points(I);

a_x = ( vp(:,1) \ (axes(:,1)-origin ) ) / axes_length(1); %( A \ B ==> left division )
a_y = ( vp(:,2) \ (axes(:,2)-origin ) ) / axes_length(2);
a_z = ( vp(:,3) \ (axes(:,3)-origin ) ) / axes_length(3);

%a = []

P = [vp(:,1)*a_x vp(:,2)*a_y vp(:,3)*a_z origin ];

Hxy = maketform('projective',P(:,[1,2,4])');
Hyz = maketform('projective',P(:,[2,3,4])');
Hxz = maketform('projective',P(:,[1,3,4])');


imx = imtransform(I,Hxy);
imy = imtransform(I,Hyz);
imz = imtransform(I,Hxz); 
imshow(imx);