function [ A x1 y1 x2 y2 ] = lineCircleIntersect( linex, liney, circlex, circley, radius )
%LINECIRCLEINTERSECT Summary of this function goes here
%   Detailed explanation goes here
cx = circlex;
cy = circley;
cr = radius;

sx = linex;
sy = liney;

lx = sx - cx;
ly = sy - cy;
dx = lx(2) - lx(1);
dy = ly(2) - ly(1);
dr = norm([dx dy]);
D = det([lx; ly]);
discriminant = cr^2 * dr^2 - D^2;

x1 = NaN;
x2 = NaN;
y1 = NaN;
y2 = NaN;

% discriminant < 0 :: no intersection
% discriminant = 0 :: tangent
% discriminant > 0 :: intersection
if(discriminant > 0)
    % inside line?
    dd = sqrt(cr^2*dr^2-D^2);
    sgn = sign(dy);
    if(sgn == 0)
        sgn = 1;
    end
    x1 = ( D*dy + sgn*dx*dd)/dr^2 + cx;
    x2 = ( D*dy - sgn*dx*dd)/dr^2 + cx;
    y1 = (-D*dx + abs(dy)*dd)/dr^2 + cy;
    y2 = (-D*dx - abs(dy)*dd)/dr^2 + cy;
    %{
    plot(x1,y1,'r*'); hold on
    plot(x2,y2,'r*');
    %}
end
%{
rectangle('Position',[cx-cr cy-cr cr*2 cr*2],'Curvature',[1 1])
hold on, axis equal
plot(sx,sy,'b');
%}
midax = mean([x1 x2]);
miday = mean([y1 y2]);

r = norm([cx-midax cy-miday]);
h = cr - r;
A = cr^2*acos((cr - h) / cr) - (cr - h)*sqrt(2*cr*h - h^2);
%{
plot(midax,miday,'ro')
plot(cx,cy,'ro');
plot([cx midax],[cy miday],'r--')
%}
end

