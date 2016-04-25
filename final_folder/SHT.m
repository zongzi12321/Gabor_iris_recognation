function [hough_space,hough_circle,para] = SHT(BW,step_r,step_angle,r_min,r_max,p)
% -----------------------------------------------------------------------------------
% Input
% BW:��ֵͼ��
% step_r:����Բ�뾶����
% step_angle:�ǶȲ�������λΪ����
% r_min:��СԲ�뾶
% r_max:���Բ�뾶
% p:��ֵ��0-1֮�����
%------------------------------------------------------------------------------------
% Output
% hough_space:�����ռ䣬h(a,b,r)��ʾԲ����(a,b)�뾶Ϊr��Բ�ϵĵ���
% hough_circl:��ֵͼ�񣬼�⵽��Բ
% para:��⵽��Բ��Բ�ġ��뾶����
%-------------------------------------------------------------------------------------
% IE ZJUT  
%-------------------------------------------------------------------------------------
[m,n] = size(BW);                       %ͼ��Ķ�ά��С
size_r = round((r_max-r_min)/step_r)+1; %�뾶���ܲ���
size_angle = round(2*pi/step_angle);    %�Ƕȵ��ܲ���

hough_space = zeros(m,n,size_r);        %�����ռ䣬��ά�ۼ���

[rows,cols] = find(BW==1);              %����ͼ���е�������
ecount = size(rows);                    %���������

%Hough�任:��ͼ��ռ�(x,y)��Ӧ�������ռ�(a,b,r)����ÿ��������ΪԲ�ģ��ڲ�ͬ�뾶�»�Բ����Բ�켣�ϵ��ۼ���ֵ����һ
%a = x-r*cos(angle)
%b = y-r*sin(angle)
tic;
%Hough�任���̣����Կ������㸴�Ӷ�O��N^3�����洢���Ӷ�����ά
for i=1:ecount                         
    for r=1:size_r
        for k=1:size_angle
            a = round(rows(i)-(r_min+(r-1)*step_r)*cos(k*step_angle));
            b = round(cols(i)-(r_min+(r-1)*step_r)*sin(k*step_angle));
            if(a>0 && a<=m && b>0 && b<=n)
                hough_space(a,b,r) = hough_space(a,b,r)+1;
            end
        end
    end
end

% ����������ֵ�ľۼ���,���¸����������ֵ
max_para = max(max(max(hough_space)));
index = find(hough_space>=max_para*p);

length = size(index);      %����Ҫ��ľ�������
hough_circle = false(m,n); %����һ��������ͼ���Сһ���Ķ�ά��ֵ����,�Ѽ�⵽�Ĳ����ڴ�ͼ������ʾԲ�ϵ�������
for k=1:length             %�������������k��Բ�ĸ���
    par3a = floor(index(k)/(m*n))+1;
    par2 = floor((index(k)-(par3a-1)*(m*n))/m)+1;
    par1 = index(k)-(par3a-1)*(m*n)-(par2-1)*m;
    par3b = r_min+(par3a-1)*step_r;
    para(:,k) = [par1,par2,par3b];
end

%��ʾ�Ѿ���⵽��Բ����һ������Χ�ڵĵ㶼��ʾ�ڴ�Բ��
for i=1:ecount             
    for k=1:size(para,2)
        if(rows(i)-para(1,k))^2+(cols(i)-para(2,k))^2<(para(3,k)^2+16) && (rows(i)-para(1,k))^2+(cols(i)-para(2,k))^2>(para(3,k)^2-16)
            hough_circle(rows(i),cols(i)) = true;
        end
    end
end
toc;

%��һ��8�����ʾԲ�ĵ�λ��
for k=1:size(para,2)
for i=para(1,k)-1:para(1,k)+1
    for j=para(2,k)-1:para(2,k)+1
        hough_circle(i,j) = true;
    end
end
%�Լ�⵽��Բ�İ뾶�������鿴hough_space�����ռ�������뾶�µ�Ʊ���ֲ�
end

% ��ӡ�����
for i=1:size(para,2)
fprintf('Center %d %d radius %d\n',para(1,i),para(2,i),para(3,i));
end

