%% 2015/06/09 ʵ�ʽ������˼����
close all;
clear all;
%% ���԰���һ
% ��һ�ż򵥵�����ͼ���в��ԣ�ʵ��HOG�ķ��������ջ��һ�����˵���������
% ͼ����㳣��

% һ����ȡһ������ͼƬ
A = imread('image/a.jpg');
figure,imshow(A);
% �����ҶȻ�ͼƬ
B = rgb2gray(A);
[m,n] = size(B);
figure,imshow(B);
% ����GammaУ�����й�һ����Ŀ���ǵ���ͼ��ĶԱȶȣ�����ͼ��ֲ�����Ӱ�͹��ձ仯����ɵ�Ӱ�죬ͬʱ�������������ĸ��ţ�
C = double(B);
D = C./255.00;
E = imadjust(D, [0, 1.0], [0, 1.0], 0.5);
figure,imshow(E);
% E = imadjust(D, [0, 1.0], [0, 1.0], 1.4);
% figure,imshow(E);
% �ġ�����ÿ�����ص��ݶȣ���Ҫ��Ϊ�˲���������Ϣ��ͬʱ��һ���������յĸ��ţ�
%% ʹ��Sobel�������ݶ�
[F,G] = ham_sobel2(C);
%H = (atan(G).*180/pi);
%H = atan(G.*2.8648).*180/pi;
figure,imshow(F,[]);
figure,imshow(G,[]);
%% �˴�ʹ��[-1 0 1]һά���ĶԳ��㷨
% Heading = zeros(m,n);
% Value = zeros(m,n);
% for i = 1:1:m
%     for j = 1:n
%         if j == 1
%             if (E(i, j) > E(i, j+1))
%                 Heading(i,j) = 0;
%             else
%                 Heading(i,j) = 1;
%             end
%             Value(i,j) = abs(E(i,j)-E(i,j+1));
%             %Value(i,j) = (E(i,j)-E(i,j+1))^2;
%         elseif j==n
%             if (E(i,j) >E(i,j-1))
%                 Heading(i,j) = 1;
%             else
%                 Heading(i,j) = 0;
%             end
%             Value(i,j) = abs(E(i,j)-E(i,j-1)); 
%             %Value(i,j) = (E(i,j)-E(i,j-1))^2; 
%         else
%             if (E(i,j) -E(i,j-1))^2>(E(i, j) - E(i, j+1))^2
%                 Heading(i,j) = 1;
%             else
%                 Heading(i,j) = 0;
%             end
%             %Value(i,j) = (E(i,j) -E(i,j-1))^2+(E(i, j) - E(i, j+1))^2;
%             Value(i,j) = abs(E(i,j) -E(i,j-1))+abs(E(i, j) - E(i, j+1));
%         end
%     end
% end
% 
% figure,imshow(Heading, []);
% figure,imshow(Value, []);
% %% �˴�ʹ��[  -1 
%               0 
%               1]һά���ĶԳ��㷨
% Heading1 = zeros(m,n);
% Value1 = zeros(m,n);
% for i = 1:1:m
%     for j = 1:n
%         if i == 1
%             if (E(i, j) > E(i+1, j))
%                 Heading1(i,j) = 0;
%             else
%                 Heading1(i,j) = 1;
%             end
%             Value1(i,j) = abs(E(i,j)-E(i+1,j));
%         elseif i==m
%             if (E(i,j) >E(i-1,j))
%                 Heading1(i,j) = 1;
%             else
%                 Heading1(i,j) = 0;
%             end
%             Value1(i,j) = abs(E(i,j)-E(i-1,j)); 
%         else
%             if (E(i,j) -E(i-1,j))^2>(E(i, j) - E(i+1, j))^2
%                 Heading1(i,j) = 1;
%             else
%                 Heading1(i,j) = 0;
%             end
%             %Value(i,j) = (E(i,j) -E(i,j-1))^2+(E(i, j) - E(i, j+1))^2;
%             Value1(i,j) = abs(E(i,j) -E(i-1,j))+abs(E(i, j) - E(i+1, j));
%         end
%     end
% end
% figure,imshow(Heading1, []);
% figure,imshow(Value1, []);
% figure,imshow(Heading+Heading1, []);
% figure,imshow(Value1+Value, []);

% �塢��ͼ�񻮷�ΪСcells��8x8��
% ֱ��ͼ�Ŀռ����Ϊ9������180/9 = 20
constcell_row = 8;
constcell_col = 8;
cell_row = m/constcell_row;
cell_col = n/constcell_col;
cell_descriptor = zeros(cell_row, cell_col,9);
for i = 1:cell_row
    for j=1:cell_col
        cell_descriptor(i,j,:) = ham_hist(H, (i-1)*constcell_row,(j-1)*constcell_col, constcell_row, constcell_col);
    end
end
% ������ͼ���Block����ͳ��
constblock_row = 2; 
constblock_col = 2;
block_row = round(m/constblock_row);
block_col = round(n/constblock_col);

for i = 1:block_row
    for j = 1:block_col
        
    end
end


