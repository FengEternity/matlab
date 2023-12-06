
function [e, g, sigma] = compute_image_quality_metrics(img, threshold)
    % 转换为灰度图像
    gray_img = rgb2gray(img);

    % 计算梯度图像
    [Gx, Gy] = imgradientxy(gray_img);
    Gmag = sqrt(Gx.^2 + Gy.^2);

    % 计算可见边比指标
    E = sum(sum(Gmag > 0));
    A = numel(gray_img);
    e = E / A;

    % 计算可见边的规模化梯度均值指标
    mean_g = sum(sum(Gmag .* (Gmag > 0))) / E;
    g = mean_g / max(max(Gmag));

    % 计算饱和黑白像素点百分比指标
    if nargin < 2
        threshold = 0.1;
    end
    hsv_img = rgb2hsv(img);
    saturation = hsv_img(:,:,2);
    saturation = saturation(saturation <= threshold);
    sigma = numel(saturation) / ((size(img,1)*size(img,2)) / 2);
end