function [pline_x,pline_y]=recreatcurve(para,I) %para �ǹ���Բ�Ĳ���
x0=para(1);   %����Բ������
y0=para(2);
r=para(3);    %����Բ�İ뾶
theta = 0 : (2 * pi / 300) : (2 * pi);
pline_x = r * cos(theta) + x0;
pline_y = r * sin(theta) + y0;
% imshow(I);
% hold on;
% plot(pline_y,pline_x,'.');