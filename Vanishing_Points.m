function Vanishing_Points(im)
% output vanishing point, input image

figure(1), hold off, imagesc(im)
hold on 

% Allow user to input line segments; compute centers, directions, lengths
disp('Set at least two lines for vanishing point')
 lines = zeros(3, 0);
line_length = zeros(1,0);
centers = zeros(3, 0);
 vp = zeros(3,0);
count=0;
 axes = zeros(3,0);
axes_length = zeros(1,0);
while 1
    count  = count+1
    disp(' ')
    disp('Click first point or q to stop')
    [x1,y1,b] = ginput(1);    
    if b=='q'        
        break;
    end
    disp('Click second point');
    [x2,y2] = ginput(1);
    plot([x1 x2], [y1 y2], 'b')
    lines(:, end+1) = real(cross([x1 y1 1]', [x2 y2 1]')) %homogeneous coordinates of line endpoints and then cross product.
    line_length(end+1) = sqrt((y2-y1)^2 + (x2-x1).^2);
    centers(:, end+1) = [x1+x2 y1+y2 2]/2;
end

%% solve for vanishing point 
% Insert code here to compute vp (3x1 vector in homogeneous coordinates)
for i=0:(count/2-1)
vp(:,end+1)=cross(lines(:,2*i+1),lines(:,2*i+2))
end
assignin('base', 'vp', vp);

%% projection matrix
disp('Enter world origin');

[w1,w2,b] = ginput(1);
assignin('base', 'origin', [w1,w2,b]');
disp('Enter reference coordinates')
for i=1:3
    [x1,y1,b] = ginput(1);
    if b=='q'        
        break;
    end
    disp('Click second point');
    [x2,y2] = ginput(1);
    plot([x1 x2], [y1 y2], 'b')
    axes(:, end+1) = real(cross([x1 y1 1]', [x2 y2 1]'))
    axes_length(end+1) = sqrt((y2-y1)^2 + (x2-x1).^2);
    %centers(:, end+1) = [x1+x2 y1+y2 2]/2;
  
end
assignin('base', 'axes', axes);
assignin('base', 'axes_length', axes_length);

%a_x = ( Vx \ (ref_x - WO) ) / ref_x_dis 
%a_y = ( Vy \ (ref_y - WO) ) / ref_y_dis
%a_z = ( Vz \ (ref_z - WO) ) / ref_z_dis
%% display
hold on
bx1 = min(1, vp(1)/vp(3))-10; bx2 = max(size(im,2), vp(1)/vp(3))+10;
by1 = min(1, vp(2)/vp(3))-10; by2 = max(size(im,1), vp(2)/vp(3))+10;
for k = 1:size(lines, 2)
    if lines(1,k)<lines(2,k)
        pt1 = real(cross([1 0 -bx1]', lines(:, k)));
        pt2 = real(cross([1 0 -bx2]', lines(:, k)));
    else
        pt1 = real(cross([0 1 -by1]', lines(:, k)));
        pt2 = real(cross([0 1 -by2]', lines(:, k)));
    end
    pt1 = pt1/pt1(3);
    pt2 = pt2/pt2(3);
    plot([pt1(1) pt2(1)], [pt1(2) pt2(2)], 'g', 'Linewidth', 1);
end
plot(vp(1)/vp(3), vp(2)/vp(3), '*r')
axis image
axis([bx1 bx2 by1 by2]); 