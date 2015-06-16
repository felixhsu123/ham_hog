%% ʹ��Sobel�㷨�����ݶȣ����Ĵ�С�ͷ������ͳ��
%����OpenCV��HOGDescriptor��Դ����б�д

%����ͼ��img���ݶȷ���ͼ��grad���ݶȷ���ͼ��qangle.
function [grad, qangle] = ham_sobel2(InImage)
%InImage Ϊ��ͨ��ͼ�񣨲��Ի�׼ΪGray�Ҷ�ͼ)
nbins = 9;
[m,n, c] = size(InImage);
if c > 1
    InImage = rgb2gray(InImage);
end
%% ����ͼ��
%��ͼ�������������������,���ﲻ��Ϊ�˼����Ե�ݶȶ��������䣬��Ϊ
%Ϊ�˱�Ե�ݶȶ��������ں���Ĵ�����ɵģ���������Ϊʲô������ʱ�������ס�
Image = zeros(m+2,n+2);     %ǰ�������һ�л�һ��

%% gammaУ���㷨
%gammaУ��ָ���ǽ�0��256������ֵȫ�������ţ�����Χ��С�ˣ��ұ任��Χ������������
gamma_lut = zeros(1,256);
if 1    % enable gamma correction
    for i = 1:256
        gamma_lut(1,i) = sqrt(i);
    end
else
    for i = 1:256
        gamma_lut(1,i) = i;
    end
end
%% �߽����䣨ʹ��BORDER_REFLECT_101�߽���䣩
%�߽��������������ص�ķ�ʽ��
% Various border types, image boundaries are denoted with '|'
% * BORDER_REPLICATE:     aaaaaa|abcdefgh|hhhhhhh
% * BORDER_REFLECT:       fedcba|abcdefgh|hgfedcb
% * BORDER_REFLECT_101:   gfedcb|abcdefgh|gfedcba
% * BORDER_WRAP:          cdefgh|abcdefgh|abcdefg        
% * BORDER_CONSTANT:      iiiiii|abcdefgh|iiiiiii  with some specified 'i'
for i=2:m+1
    for j=2:n+1
        Image(i,j) = InImage(i-1,j-1);
    end
end
% ��һ��==�ڶ���
Image(1,:) = Image(2,:);
% ������һ��==�����ڶ���
Image(m+2,:) = Image(m+1,:);
% ��һ��==�ڶ���
Image(:,1) = Image(:,2);
% ������һ��==�����ڶ���
Image(:,n+2) = Image(:,n+1);
%% �����ݶȵķ�ֵ�ͷ���
Gx = zeros(m,n);
Gy = zeros(m,n);
G = zeros(m,n);
g = zeros(m,n);
a = zeros(m,n);
A = zeros(m,n);
for i=2:m+1
    for j=2:n+1
        %ˮƽ�����ݶ�
        %Gx(i-1,j-1) = Image(i+1,j) - Image(i-1,j);
        Gx(i-1,j-1) = gamma_lut(1,Image(i+1,j)+1) - gamma_lut(1,Image(i-1,j)+1);
        %��ֱ�����ݶ�
        Gy(i-1,j-1) = gamma_lut(1,Image(i,j+1)+1) - gamma_lut(1,Image(i,j-1)+1);
        %��ֵ
        %G(i-1,j-1) = abs(Gx(i-1,j-1)) + abs(Gy(i-1,j-1));
        G(i-1,j-1) = sqrt((Gx(i-1,j-1))^2 + (Gy(i-1,j-1))^2);
        %����
        a(i-1,j-1) = atan(Gy(i-1,j-1)/Gx(i-1,j-1));
        if isnan(a(i-1,j-1))
            a(i-1,j-1) = 0;
        end
    end
% //������ݶȷ������������ڵ�bin��ģ������ֻ��һ��ģ��������������ֵ��  
% //���Բ�ֵ������ĳ�������Ӧ������ bin 7.6,�������ǵ�bin���������ģ��������룬�������ֵ�bin 8��̫�ֲ���  
% //�ǾͰ��õ㵽bin7,bin8�ľ�����䣬������������8����������7��  
% 
    for j=2:n+1
        mag = G(i-1,j-1);
        angle = a(i-1,j-1)*(9/pi)-0.5;
        hidx = floor(angle);
        angle = angle-hidx;
        
        grad(i-1,(j-1)*2-1) = mag*(1.0-angle);
        grad(i-1,(j-1)*2) = mag*angle;
        
        if hidx < 0
            hidx = hidx+nbins;
        elseif hidx >=nbins
            hidx = hidx-nbins;
        end
        qangle(i-1,(j-1)*2-1) = hidx;
        hidx = hidx+1;
        if hidx < nbins
            hidx = hidx;
        else
            hidx = 0;
        end
        qangle(i-1,(j-1)*2) = hidx;
    end
end %for i=2:m+1
    
grad;
qangle;   %//-pi/2<Angle<pi/2;




end