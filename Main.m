
% ----------------------- Read Me -----------------------------------------
% -------------  项目：基于MATLAB的图像去雾系统 -------------------------------


% 文件清单
% Main.fig Main.m GUI文件
% DehazeNet 的文件:
% boxfilter.m convConst.cpp convConest.mexw64 convMax.m convloution.m
% dehaze.mat guidedfilter.m run_cnn.m sse.hpp wrappers.hpp
% MSCNNd 的文件：
% dehazing_code matlab
% 全局均衡化 的文件：
% Global_1.m
% 局部均衡化 的文件：
% Local_1.m
% SSR\MSR\MSRCR 的文件：
% Retinex_1,m Retinex_2,m Retinex_3,m
% 暗通道 的文件：
% Antongd_1.m
% 改进的暗通道 的文件：
% guided_filter.m  get_dark_channel.m  estimate_atmosphere.m
% estimate_transmission.m
% 评价指标 的文件：
% compute_image_quality_metrics.m compute_psnr.m compute_rmse.m cal_ssim.m
% 保存、截图 的文件：
% Snap.m Save.m





function varargout = Main(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Main is made visible.
function Main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main (see VARARGIN)

% Choose default command line output for Main
handles.output = hObject;
Reset_figure(hObject, handles); %初试化图像界面
handles.Image1 = 0;
handles.Image2 = 0;
handles.FileName = [];
handles.PathName = [];

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function QuWu1_Callback(hObject, eventdata, handles)
% hObject    handle to QuWu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Help_Callback(hObject, eventdata, handles)
% hObject    handle to Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Hist_Callback(hObject, eventdata, handles)
% hObject    handle to Hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Flow_Callback(hObject, eventdata, handles)
% hObject    handle to Flow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = '图像去雾系统使用流程：主菜单载入图像>-->选择去雾算法';
msgbox(str, '流程');

% --------------------------------------------------------------------
function About_Callback(hObject, eventdata, handles)
% hObject    handle to About (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 帮助信息
msgbox({'本系统为基于MATLAB的图像去雾系统，去雾算法包括增强型的5个算法以及基于物理模型的2个算法（包含本文的改进算法）和2个基于深度学习的去雾算法，';...
}, '关于系统');

% --------------------------------------------------------------------
function Global_Callback(hObject, eventdata, handles)
% hObject    handle to Global (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isequal(handles.Image1, 0)
    msgbox('请载入图像！', '提示信息');
    return;
end
Image2 = Global_1(handles.Image1, 0);
axes(handles.axes2); imshow(Image2, []);
handles.Image2 = Image2;

%原始直方图

axes(handles.axes3);histogram(rgb2gray(handles.Image1));
h_line=get(handles.axes3,'Children');
ydata=get(h_line,'Values');
a = max(ydata);
% 

axes(handles.axes4);histogram(rgb2gray(Image2));
h_line=get(handles.axes4,'Children');
ydata=get(h_line,'Values');
b = max(ydata);

if a>b
    h_line1=get(handles.axes3,'YLim');
    set(handles.axes4,'YLim',h_line1);
%     h_line2=get(handles.axes4,'YTick')
else
    h_line1=get(handles.axes4,'YLim');
    set(handles.axes3,'YLim',h_line1);
%     h_lin1e=get(handles.axes3,'YTick');
%     set(handles.axes3,'YTick',h_lin1e);
end

I=im2uint8(handles.Image1);
F=im2uint8(Image2);

e = entropy(F);
[ee, g, sigma] = compute_image_quality_metrics(Image2, 0.1);

[psnr_value] = compute_psnr(I, F, 'psnr');
[ssim_value] = cal_ssim(I, F,0,0);


set(handles.XXS, 'String', num2str(e));
set(handles.KJB, 'String', num2str(ee));
set(handles.PSNR, 'String', num2str(psnr_value));
set(handles.SSIM, 'String', num2str(ssim_value));


guidata(hObject, handles);
set(handles.text1, 'String', ...
    '采用全局直方图均衡化实现图像去雾');

% --------------------------------------------------------------------
function Local_Callback(hObject, eventdata, handles)
% hObject    handle to Local (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isequal(handles.Image1, 0)
    msgbox('请载入图像！', '提示信息');
    return;
end
Image2 = Local_1(handles.Image1, 0);
axes(handles.axes2); imshow(Image2, []);
handles.Image2 = Image2;

%原始直方图

axes(handles.axes3);histogram(rgb2gray(handles.Image1));
h_line=get(handles.axes3,'Children');
ydata=get(h_line,'Values');
a = max(ydata);
% 

axes(handles.axes4);histogram(rgb2gray(Image2));
h_line=get(handles.axes4,'Children');
ydata=get(h_line,'Values');
b = max(ydata);

if a>b
    h_line1=get(handles.axes3,'YLim');
    set(handles.axes4,'YLim',h_line1);
%     h_line2=get(handles.axes4,'YTick')
else
    h_line1=get(handles.axes4,'YLim');
    set(handles.axes3,'YLim',h_line1);
%     h_lin1e=get(handles.axes3,'YTick');
%     set(handles.axes3,'YTick',h_lin1e);
end

I=im2uint8(handles.Image1);
F=im2uint8(Image2);
e = entropy(F);


[ee, g, sigma] = compute_image_quality_metrics(Image2, 0.1);
% fprintf('可见边比：%.4f\n', e);
% fprintf('可见边规模化梯度均值：%.4f\n', g);
% fprintf('饱和黑白像素点百分比：%.4f\n', sigma);
[psnr_value] = compute_psnr(I, F, 'psnr');
[ssim_value] = cal_ssim(I, F,0,0);


set(handles.XXS, 'String', num2str(e));
set(handles.KJB, 'String', num2str(ee));
set(handles.PSNR, 'String', num2str(psnr_value));
set(handles.SSIM, 'String', num2str(ssim_value));



guidata(hObject, handles);
set(handles.text1, 'String', ...
    '局部直方图均衡化实现图像去雾');

% --------------------------------------------------------------------
function Retinex_Callback(hObject, eventdata, handles)
% hObject    handle to Retinex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isequal(handles.Image1, 0)
    msgbox('请载入图像！', '提示信息');
    return;
end
Image2 = Retinex_1(handles.Image1, 0);
axes(handles.axes2); imshow(Image2, []);
handles.Image2 = Image2;

%原始直方图

axes(handles.axes3);histogram(rgb2gray(handles.Image1));
h_line=get(handles.axes3,'Children');
ydata=get(h_line,'Values');
a = max(ydata);
% 

axes(handles.axes4);histogram(rgb2gray(Image2));
h_line=get(handles.axes4,'Children');
ydata=get(h_line,'Values');
b = max(ydata);

if a>b
    h_line1=get(handles.axes3,'YLim');
    set(handles.axes4,'YLim',h_line1);
%     h_line2=get(handles.axes4,'YTick')
else
    h_line1=get(handles.axes4,'YLim');
    set(handles.axes3,'YLim',h_line1);
%     h_lin1e=get(handles.axes3,'YTick');
%     set(handles.axes3,'YTick',h_lin1e);
end


I=im2uint8(handles.Image1);
F=im2uint8(Image2);
e = entropy(F);


[ee, g, sigma] = compute_image_quality_metrics(Image2, 0.1);


[psnr_value] = compute_psnr(I, F, 'psnr');
[ssim_value] = cal_ssim(I, F,0,0);


set(handles.XXS, 'String', num2str(e));
set(handles.KJB, 'String', num2str(ee));
set(handles.PSNR, 'String', num2str(psnr_value));
set(handles.SSIM, 'String', num2str(ssim_value));




guidata(hObject, handles);
set(handles.text1, 'String', ...
    '基于RETINEX理论的图像去雾');

% --------------------------------------------------------------------
function FileOpen_Callback(hObject, eventdata, handles)
% hObject    handle to FileOpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 载入图像
warning off all;
[FileName,PathName,FilterIndex] = uigetfile({'*.jpg;*.tif;*.png;*.gif;*.bmp', ...
    '所有图像文件';...
    '*.*','所有文件' },'载入图像',...
    '.\images');
if isequal(FileName, 0) || isequal(PathName, 0) %判断是否载入成功
    return;
end
Reset_figure(hObject, handles); %初试化图像界面
Image1 = imread(fullfile(PathName, FileName));
axes(handles.axes1);
imshow(Image1, []);
handles.Image1 = Image1;
handles.Image2 = 0;
handles.FileName = FileName;
handles.PathName = PathName;



set(handles.XXS, 'String', '');
set(handles.KJB, 'String',  '');
set(handles.PSNR, 'String',  '');
set(handles.SSIM, 'String',  '');
guidata(hObject, handles);

% --------------------------------------------------------------------
function Snap_Callback(hObject, eventdata, handles)
% hObject    handle to Snap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Snap();

% --------------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isequal(handles.Image2, 0)
    msgbox('未进行去雾操作！', '提示信息');
    return;
end
Save(handles.Image2);


% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close();


% --------------------------------------------------------------------
function Dark_Callback(hObject, eventdata, handles)
% hObject    handle to Dark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isequal(handles.Image1, 0)
    msgbox('未载入图像！', '提示信息');
    return;
end
Image2 = Antongd_1(handles.Image1, 0);
axes(handles.axes2); imshow(Image2, []);
handles.Image2 = Image2;

%原始直方图

axes(handles.axes3);histogram(rgb2gray(handles.Image1));
h_line=get(handles.axes3,'Children');
ydata=get(h_line,'Values');
a = max(ydata);
% 

axes(handles.axes4);histogram(rgb2gray(Image2));
h_line=get(handles.axes4,'Children');
ydata=get(h_line,'Values');
b = max(ydata);

if a>b
    h_line1=get(handles.axes3,'YLim');
    set(handles.axes4,'YLim',h_line1);
%     h_line2=get(handles.axes4,'YTick')
else
    h_line1=get(handles.axes4,'YLim');
    set(handles.axes3,'YLim',h_line1);
%     h_lin1e=get(handles.axes3,'YTick');
%     set(handles.axes3,'YTick',h_lin1e);
end

I=im2uint8(handles.Image1);
F=im2uint8(Image2);

e = entropy(F);


[ee, g, sigma] = compute_image_quality_metrics(Image2, 0.1);


[psnr_value] = compute_psnr(I, F, 'psnr');
[ssim_value] = cal_ssim(I, F,0,0);


set(handles.XXS, 'String', num2str(e));
set(handles.KJB, 'String', num2str(ee));
set(handles.PSNR, 'String', num2str(psnr_value));
set(handles.SSIM, 'String', num2str(ssim_value));
guidata(hObject, handles);
set(handles.text1, 'String', ...
    '暗通道实现图像去雾算法。');


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------


% --------------------------------------------------------------------
function Newway_Callback(hObject, eventdata, handles)
% hObject    handle to Newway (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isequal(handles.Image1, 0)
    msgbox('请载入图像！', '提示信息');
    return;
end

set(handles.text1, 'String', ...
    '本文的去雾算法。');

foggy_image = handles.Image1; %%加载一张有雾图像
foggy_image = im2double(foggy_image);%%将有雾图像由uint8类型转换为double类型，方便后续处理


Igray = rgb2gray(foggy_image);%将`foggy_image`变量中的RGB图像转换为灰度图像，并将结果存储在`Igray`变量中


clahe_processed_image = adapthisteq(Igray,'clipLimit',0.01,'Distribution','rayleigh');%使用自适应直方图均衡化（CLAHE）算法对灰度图像进行增强处理;`clipLimit`参数是控制对比度的截断阈值，`'Distribution','rayleigh'`指定直方图均衡化的分布类型
guided = guided_filter(clahe_processed_image, clahe_processed_image, 3, 0.16);%使用`guided_filter`函数对经过CLAHE增强处理后的图像进行平滑，提取细节信息


patch_size = 15;%%运用暗通道先验求解方法，求出输入的gamma_corrected_image图像的暗通道;定义块大小
dark_channel = get_dark_channel(foggy_image, patch_size);%求解输入的图像的暗通道
A = estimate_atmosphere(foggy_image, dark_channel);
%%估算大气光，根据暗通道和原始图像，计算出大气光向量A

omega = 0.95;%%估算透射率，根据原始图像、大气光向量A、参数omega和暗通道先验方法，计算出透射率t
t = estimate_transmission(foggy_image, A, omega, patch_size);
%估算透射率，根据原始图像、大气光向量A、参数omega和暗通道先验方法，计算出透射率t
% 物理模型求解
J = dehaze(foggy_image, t, A);%%调用了一个函数dehaze，根据物理模型求解，将估算的透射率t和大气光向量A应用于原始图像gamma_corrected_image，得到去雾图像J
gamma = 0.6;%%进行伽马校正，将图像的亮度调整到合适的范围
gamma_corrected_image = imadjust(J, [], [], gamma);%函数`imadjust`是一个用于图像增强和颜色校正的MATLAB函数
I=gamma_corrected_image;
low_in = 0.1;
high_in = 0.9;

% 设定输出图像亮度范围
low_out = 0;
high_out = 1;

% 进行直方图拉伸
I_adj = imadjust(I, [low_in high_in], [low_out high_out]);
alpha =0.6;%%将去雾图像J和CLAHE处理后的图像clahe_processed_image进行线性融合，得到最终的去雾图像fused_image
fused_image = alpha * I_adj + (1 - alpha) * guided;

% 展示去雾图
axes(handles.axes2); imshow(fused_image, []);
handles.Image2 = fused_image;
Image1 = handles.Image1;
Image2 = fused_image;

%原始直方图
axes(handles.axes3);histogram(rgb2gray(handles.Image1));
h_line=get(handles.axes3,'Children');
ydata=get(h_line,'Values');
a = max(ydata);
% 

axes(handles.axes4);histogram(rgb2gray(Image2));
h_line=get(handles.axes4,'Children');
ydata=get(h_line,'Values');
b = max(ydata);

if a>b
    h_line1=get(handles.axes3,'YLim');
    set(handles.axes4,'YLim',h_line1);
%     h_line2=get(handles.axes4,'YTick')
else
    h_line1=get(handles.axes4,'YLim');
    set(handles.axes3,'YLim',h_line1);
%     h_lin1e=get(handles.axes3,'YTick');
%     set(handles.axes3,'YTick',h_lin1e);
end



I=im2uint8(handles.Image1);
F=im2uint8(Image2);
e = entropy(F);


[ee, g, sigma] = compute_image_quality_metrics(Image2, 0.1);

[psnr_value] = compute_psnr(I, F, 'psnr');
[ssim_value] = cal_ssim(I, F,0,0);


set(handles.XXS, 'String', num2str(e));
set(handles.KJB, 'String', num2str(ee));
set(handles.PSNR, 'String', num2str(psnr_value));
set(handles.SSIM, 'String', num2str(ssim_value));


guidata(hObject, handles);


% --------------------------------------------------------------------
function Multi_Retinex_CR_Callback(hObject, eventdata, handles)
% hObject    handle to Multi_Retinex_CR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isequal(handles.Image1, 0)
    msgbox('请载入图像！', '提示信息');
    return;
end
Image2 = Retinex_2(handles.Image1, 0);
axes(handles.axes2); imshow(Image2, []);
handles.Image2 = Image2;

%原始直方图

axes(handles.axes3);histogram(rgb2gray(handles.Image1));
h_line=get(handles.axes3,'Children');
ydata=get(h_line,'Values');
a = max(ydata);
% 

axes(handles.axes4);histogram(rgb2gray(Image2));
h_line=get(handles.axes4,'Children');
ydata=get(h_line,'Values');
b = max(ydata);

if a>b
    h_line1=get(handles.axes3,'YLim');
    set(handles.axes4,'YLim',h_line1);
%     h_line2=get(handles.axes4,'YTick')
else
    h_line1=get(handles.axes4,'YLim');
    set(handles.axes3,'YLim',h_line1);
%     h_lin1e=get(handles.axes3,'YTick');
%     set(handles.axes3,'YTick',h_lin1e);
end


I=im2uint8(handles.Image1);
F=im2uint8(Image2);
e = entropy(F);


[ee, g, sigma] = compute_image_quality_metrics(Image2, 0.1);
[psnr_value] = compute_psnr(I, F, 'psnr');
[ssim_value] = cal_ssim(I, F,0,0);


set(handles.XXS, 'String', num2str(e));
set(handles.KJB, 'String', num2str(ee));
set(handles.PSNR, 'String', num2str(psnr_value));
set(handles.SSIM, 'String', num2str(ssim_value));



guidata(hObject, handles);
set(handles.text1, 'String', ...
    '基于带色彩恢复的多尺度RETINEX理论的图像去雾');


% --------------------------------------------------------------------
function FuYUAN_Callback(hObject, eventdata, handles)
% hObject    handle to FuYUAN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function our_Callback(hObject, eventdata, handles)
% hObject    handle to our (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function MSR_Callback(hObject, eventdata, handles)
% hObject    handle to MSR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isequal(handles.Image1, 0)
    msgbox('请载入图像！', '提示信息');
    return;
end
Image2 = Retinex_3(handles.Image1, 0);
axes(handles.axes2); imshow(Image2, []);
handles.Image2 = Image2;

%原始直方图

axes(handles.axes3);histogram(rgb2gray(handles.Image1));
h_line=get(handles.axes3,'Children');
ydata=get(h_line,'Values');
a = max(ydata);
% 

axes(handles.axes4);histogram(rgb2gray(Image2));
h_line=get(handles.axes4,'Children');
ydata=get(h_line,'Values');
b = max(ydata);

if a>b
    h_line1=get(handles.axes3,'YLim');
    set(handles.axes4,'YLim',h_line1);
%     h_line2=get(handles.axes4,'YTick')
else
    h_line1=get(handles.axes4,'YLim');
    set(handles.axes3,'YLim',h_line1);
%     h_lin1e=get(handles.axes3,'YTick');
%     set(handles.axes3,'YTick',h_lin1e);
end


I=im2uint8(handles.Image1);
F=im2uint8(Image2);
e = entropy(F);


[ee, g, sigma] = compute_image_quality_metrics(Image2, 0.1);


[psnr_value] = compute_psnr(I, F, 'psnr');
[ssim_value] = cal_ssim(I, F,0,0);


set(handles.XXS, 'String', num2str(e));
set(handles.KJB, 'String', num2str(ee));
set(handles.PSNR, 'String', num2str(psnr_value));
set(handles.SSIM, 'String', num2str(ssim_value));



guidata(hObject, handles);
set(handles.text1, 'String', ...
    '基于多尺度RETINEX理论的图像去雾');


% --------------------------------------------------------------------
function DehazeNet_Callback(hObject, eventdata, handles)
% hObject    handle to DehazeNet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 用到的文件：
% boxfilter.m convConst.cpp convConest.mexw64 convMax.m convloution.m
% dehaze.mat guidedfilter.m run_cnn.m sse.hpp wrappers.hpp

if isequal(handles.Image1, 0)
    msgbox('请载入图像！', '提示信息');
    return;
end

haze = handles.Image1;
% ./可用于两个矩阵的中的每一个元素相除，
%matlab中数值一般采用double型（64位）存储和运算,取值0~1。所以要先将图像转为double格式的才能运算,
%为了统一，都要转换到0~1的范围，所以要除255
haze=double(haze)./255;
dehaze=run_cnn(haze);


axes(handles.axes2); imshow(dehaze, []);
handles.Image2 = dehaze;

Image2 = dehaze;

%原始直方图

axes(handles.axes3);histogram(rgb2gray(handles.Image1));
h_line=get(handles.axes3,'Children');
ydata=get(h_line,'Values');
a = max(ydata);
% 

axes(handles.axes4);histogram(rgb2gray(Image2));
h_line=get(handles.axes4,'Children');
ydata=get(h_line,'Values');
b = max(ydata);

if a>b
    h_line1=get(handles.axes3,'YLim');
    set(handles.axes4,'YLim',h_line1);
%     h_line2=get(handles.axes4,'YTick')
else
    h_line1=get(handles.axes4,'YLim');
    set(handles.axes3,'YLim',h_line1);
%     h_lin1e=get(handles.axes3,'YTick');
%     set(handles.axes3,'YTick',h_lin1e);
end


I=im2uint8(handles.Image1);
F=im2uint8(Image2);
e = entropy(F);


[ee, g, sigma] = compute_image_quality_metrics(Image2, 0.1);


[psnr_value] = compute_psnr(I, F, 'psnr');
[ssim_value] = cal_ssim(I, F,0,0);


set(handles.XXS, 'String', num2str(e));
set(handles.KJB, 'String', num2str(ee));
set(handles.PSNR, 'String', num2str(psnr_value));
set(handles.SSIM, 'String', num2str(ssim_value));

guidata(hObject, handles);
set(handles.text1, 'String', ...
    '基于DehazeNet的图像去雾');




% --------------------------------------------------------------------
function MSCNN_Callback(hObject, eventdata, handles)
% hObject    handle to MSCNN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 用到的文件：
% dehazing_code matlab

if isequal(handles.Image1, 0)
    msgbox('请载入图像！', '提示信息');
    return;
end

haze = handles.Image1;
FileName = handles.FileName ;
PathName = handles.PathName ;

addpath(genpath('.'));

% This MatConvNet is compiled under Win7, you can also compile MatConvNet
% under Linux, Mac, and Windows, then run our "demo_MSCNNdehazing.m".

run(fullfile(fileparts(mfilename('fullpath')), './matlab/vl_setupnn.m')) ;
% hazy_path = './testimgs/';
% img = 'NYU2_1439_7_2.jpg'; 
gamma = 0.8;
% img = 'newyork.png'; gamma = 1.0;
% img = 'IMG_0752.png'; gamma = 1.3;
% img = 'canyon.png'; gamma = 1.3;
imagename = [PathName FileName];


dehazedImageRGB = mscnndehazing(imagename, gamma);

axes(handles.axes2); imshow(dehazedImageRGB, []);
handles.Image2 = dehazedImageRGB;

Image2 = dehazedImageRGB;

%原始直方图

axes(handles.axes3);histogram(rgb2gray(handles.Image1));
h_line=get(handles.axes3,'Children');
ydata=get(h_line,'Values');
a = max(ydata);
% 

axes(handles.axes4);histogram(rgb2gray(Image2));
h_line=get(handles.axes4,'Children');
ydata=get(h_line,'Values');
b = max(ydata);

if a>b
    h_line1=get(handles.axes3,'YLim');
    set(handles.axes4,'YLim',h_line1);
%     h_line2=get(handles.axes4,'YTick')
else
    h_line1=get(handles.axes4,'YLim');
    set(handles.axes3,'YLim',h_line1);
%     h_lin1e=get(handles.axes3,'YTick');
%     set(handles.axes3,'YTick',h_lin1e);
end


I=im2uint8(handles.Image1);
F=im2uint8(Image2);
e = entropy(F);


[ee, g, sigma] = compute_image_quality_metrics(Image2, 0.1);


[psnr_value] = compute_psnr(I, F, 'psnr');
[ssim_value] = cal_ssim(I, F,0,0);


set(handles.XXS, 'String', num2str(e));
set(handles.KJB, 'String', num2str(ee));
set(handles.PSNR, 'String', num2str(psnr_value));
set(handles.SSIM, 'String', num2str(ssim_value));

guidata(hObject, handles);
set(handles.text1, 'String', ...
    '基于MSCNN的图像去雾');
