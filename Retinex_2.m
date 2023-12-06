function In = Retinex_2(f, flag)
% 多尺度Retinex实现图像去雾
% 输入参数：
%  f——图像矩阵
%  flag——显示标记
% 输出参数：
%  In——结果图像

if nargin < 2
    flag = 1;
end

I= f;%取输入图像的R分量
R= I(:,:,1);
G= I(:,:,2);
B= I(:,:,3);
R0= double(R);
G0= double(G);
B0= double(B);
[N1,M1]= size(R);
%对R分量进行数据转换,并对其取对数
Rlog = log(R0+1);
%对R分量进行二维傅里叶变换
Rfft2= fft2(R0);
%形成高斯滤波函数
sigma = 128;
F= zeros(N1,M1);
for i=1:N1
    for j=1:M1
        F(i,j)= exp(-((i-N1/2)^2+(j-M1/2)^2)/(2 * sigma * sigma));
    end
end
F=F./(sum(F(:)));
%对高斯滤波函数进行二维傅里叶变换
Ffft= fft2(double(F));
% 号对R分量与高斯滤波函数进行卷积运算
DRO= Rfft2.* Ffft;
DR = ifft2(DRO);
%在对数域中，用原图像减去低通滤波后的图像，得到高频增强的图像
DRdouble = double(DR);
DRlog = log(DRdouble+1);
Rr0  = Rlog-DRlog;
%形成高斯滤波函数
sigma = 256;
F= zeros(N1,M1);
for i=1:N1
    for j=1:M1
        F(i,j)= exp(-((i-N1/2)^2+(j-M1/2)^2)/(2 * sigma * sigma));
    end
end
F=F./(sum(F(:)));
%对高斯滤波函数进行二维傅里叶变换
Ffft= fft2(double(F));
% 号对R分量与高斯滤波函数进行卷积运算
DRO= Rfft2.* Ffft;
DR = ifft2(DRO);
%在对数域中，用原图像减去低通滤波后的图像，得到高频增强的图像
DRdouble = double(DR);
DRlog = log(DRdouble+1);
Rr1  = Rlog-DRlog;
%形成高斯滤波函数
sigma = 512;
F= zeros(N1,M1);
for i=1:N1
    for j=1:M1
        F(i,j)= exp(-((i-N1/2)^2+(j-M1/2)^2)/(2 * sigma * sigma));
    end
end
F=F./(sum(F(:)));
%对高斯滤波函数进行二维傅里叶变换
Ffft= fft2(double(F));
% 号对R分量与高斯滤波函数进行卷积运算
DRO= Rfft2.* Ffft;
DR = ifft2(DRO);
%在对数域中，用原图像减去低通滤波后的图像，得到高频增强的图像
DRdouble = double(DR);
DRlog = log(DRdouble+1);
Rr2  = Rlog-DRlog;
% 对上述三次增强得到的图像取均值作为最终增强的图像
Rr = (1/3)*(Rr0+Rr1+Rr2);
% 定义色彩恢复因子C
a = 30;
II = imadd(R0,G0);
II = imadd(II,B0);
Ir = immultiply(R0,a);
C = imdivide(Ir,II);
C = log(C+1);
% 将增强后的R分量乘以色彩恢复因子，并对其进行反对数变换
Rr = immultiply(C,Rr);
EXPRr = exp(Rr);
%对增强后的图像进行对比度拉伸增强
MIN= min(min(EXPRr));
MAX= max( max(EXPRr));
EXPRr =(EXPRr- MIN)/(MAX- MIN);
EXPRr = adapthisteq(EXPRr);


%对G分量进行数据转换,并对其取对数
Glog = log(G0+1);
%对R分量进行二维傅里叶变换
Gfft2= fft2(G0);
%形成高斯滤波函数
sigma = 128;
F= zeros(N1,M1);
for i=1:N1
    for j=1:M1
        F(i,j)= exp(-((i-N1/2)^2+(j-M1/2)^2)/(2 * sigma * sigma));
    end
end
F=F./(sum(F(:)));
%对高斯滤波函数进行二维傅里叶变换
Ffft= fft2(double(F));
% 号对R分量与高斯滤波函数进行卷积运算
DGO= Gfft2.* Ffft;
DG = ifft2(DGO);
%在对数域中，用原图像减去低通滤波后的图像，得到高频增强的图像
DGdouble = double(DG);
DGlog = log(DGdouble+1);
Gg0  = Glog-DGlog;
%形成高斯滤波函数
sigma = 256;
F= zeros(N1,M1);
for i=1:N1
    for j=1:M1
        F(i,j)= exp(-((i-N1/2)^2+(j-M1/2)^2)/(2 * sigma * sigma));
    end
end
F=F./(sum(F(:)));
%对高斯滤波函数进行二维傅里叶变换
Ffft= fft2(double(F));
% 号对R分量与高斯滤波函数进行卷积运算
DGO= Gfft2.* Ffft;
DG = ifft2(DGO);
%在对数域中，用原图像减去低通滤波后的图像，得到高频增强的图像
DGdouble = double(DG);
DGlog = log(DGdouble+1);
Gg1  = Glog-DGlog;
%形成高斯滤波函数
sigma = 512;
F= zeros(N1,M1);
for i=1:N1
    for j=1:M1
        F(i,j)= exp(-((i-N1/2)^2+(j-M1/2)^2)/(2 * sigma * sigma));
    end
end
F=F./(sum(F(:)));
%对高斯滤波函数进行二维傅里叶变换
Ffft= fft2(double(F));
% 号对R分量与高斯滤波函数进行卷积运算
DGO= Gfft2.* Ffft;
DG = ifft2(DGO);
%在对数域中，用原图像减去低通滤波后的图像，得到高频增强的图像
DGdouble = double(DG);
DGlog = log(DGdouble+1);
Gg2  = Glog-DGlog;
% 对上述三次增强得到的图像取均值作为最终增强的图像
Gg = (1/3)*(Gg0+Gg1+Gg2);
% 定义色彩恢复因子C
% a = 125;
II = imadd(R0,G0);
II = imadd(II,B0);
Ir = immultiply(R0,a);
C = imdivide(Ir,II);
C = log(C+1);
% 将增强后的R分量乘以色彩恢复因子，并对其进行反对数变换
Gg = immultiply(C,Gg);
EXPGg = exp(Gg);
%对增强后的图像进行对比度拉伸增强
MIN= min(min(EXPGg));
MAX= max( max(EXPGg));
EXPGg =(EXPGg- MIN)/(MAX- MIN);
EXPGg = adapthisteq(EXPGg);





%对B分量进行数据转换,并对其取对数
Blog = log(B0+1);
%对R分量进行二维傅里叶变换
Bfft2= fft2(B0);
%形成高斯滤波函数
sigma = 128;
F= zeros(N1,M1);
for i=1:N1
    for j=1:M1
        F(i,j)= exp(-((i-N1/2)^2+(j-M1/2)^2)/(2 * sigma * sigma));
    end
end
F=F./(sum(F(:)));
%对高斯滤波函数进行二维傅里叶变换
Ffft= fft2(double(F));
% 号对R分量与高斯滤波函数进行卷积运算
DBO= Bfft2.* Ffft;
DB = ifft2(DBO);
%在对数域中，用原图像减去低通滤波后的图像，得到高频增强的图像
DBdouble = double(DB);
DBlog = log(DBdouble+1);
Bb0  = Blog-DBlog;
%形成高斯滤波函数
sigma = 256;
F= zeros(N1,M1);
for i=1:N1
    for j=1:M1
        F(i,j)= exp(-((i-N1/2)^2+(j-M1/2)^2)/(2 * sigma * sigma));
    end
end
F=F./(sum(F(:)));
%对高斯滤波函数进行二维傅里叶变换
Ffft= fft2(double(F));
% 号对R分量与高斯滤波函数进行卷积运算
DBO= Bfft2.* Ffft;
DB = ifft2(DBO);
%在对数域中，用原图像减去低通滤波后的图像，得到高频增强的图像
DBdouble = double(DB);
DBlog = log(DBdouble+1);
Bb1  = Blog-DBlog;
%形成高斯滤波函数
sigma = 512;
F= zeros(N1,M1);
for i=1:N1
    for j=1:M1
        F(i,j)= exp(-((i-N1/2)^2+(j-M1/2)^2)/(2 * sigma * sigma));
    end
end
F=F./(sum(F(:)));
%对高斯滤波函数进行二维傅里叶变换
Ffft= fft2(double(F));
% 号对R分量与高斯滤波函数进行卷积运算
DBO= Bfft2.* Ffft;
DB = ifft2(DBO);
%在对数域中，用原图像减去低通滤波后的图像，得到高频增强的图像
DBdouble = double(DB);
DBlog = log(DBdouble+1);
Bb2  = Blog-DBlog;
% 对上述三次增强得到的图像取均值作为最终增强的图像
Bb = (1/3)*(Bb0+Bb1+Bb2);
% 定义色彩恢复因子C
% a = 125;
II = imadd(R0,G0);
II = imadd(II,B0);
Ir = immultiply(R0,a);
C = imdivide(Ir,II);
C = log(C+1);
% 将增强后的R分量乘以色彩恢复因子，并对其进行反对数变换
Bb = immultiply(C,Bb);
EXPBb = exp(Bb);
%对增强后的图像进行对比度拉伸增强
MIN= min(min(EXPBb));
MAX= max( max(EXPBb));
EXPBb =(EXPBb- MIN)/(MAX- MIN);
EXPBb = adapthisteq(EXPBb);

%对增强后的图像R、G、B分量进行融合
IO(:,:,1)=EXPRr;
IO(:,:,2)=EXPGg;
IO(:,:,3)=EXPBb;



% 集成处理后的分量得到结果图像
In = IO;
%结果显示
if flag
    figure;
    subplot(2, 2, 1); imshow(f); title('原图像', 'FontWeight', 'Bold');
    subplot(2, 2, 2); imshow(In); title('处理后的图像', 'FontWeight', 'Bold');
    % 灰度化，用于计算直方图
    Q = rgb2gray(f);
    M = rgb2gray(In);
    subplot(2, 2, 3); imhist(Q, 64); title('原灰度直方图', 'FontWeight', 'Bold');
    subplot(2, 2, 4); imhist(M, 64); title('处理后的灰度直方图', 'FontWeight', 'Bold');
end
