
function output = guided_filter(input, guidance, radius, eps)
% 输入参数：
% input：需要进行滤波的图像
% guidance：作为引导图像的参照
% radius：滤波对应的半径
% eps：平滑项的权重

% 将输入图像和引导图像转换为double类型
input = im2double(input);
guidance = im2double(guidance);%将`input`和`guidance`变量中的图像数据类型从`uint8`转换为`double`类型，以便进行后续的图像处理

% 用均值滤波对引导图像进行平滑
mean_I = imboxfilt(guidance, radius);

% 计算输入图像与引导图像的均值、协方差和方差等统计信息
mean_II = imboxfilt(input.*input, radius);
mean_Ip = imboxfilt(input.*guidance, radius);
cov_Ip = mean_Ip - mean_I.*input;
var_I = mean_II - mean_I.*mean_I;

% 根据计算得到的统计信息，对输入图像进行滤波处理
output = (cov_Ip + eps) ./ (var_I + eps) .* input + (mean_I - (cov_Ip + eps) ./ (var_I + eps) .* mean_I);

end