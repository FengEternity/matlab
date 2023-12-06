
% 暗通道先验求解函数
function dark_channel = get_dark_channel(I, patch_size)%%输入是一张图像I和一个块大小patch_size，输出是该图像的暗通道
    [h, w, ~] = size(I);%%求出图像I的大小(h, w, ~)
    pad_size = floor(patch_size / 2);%%根据patch_size计算出对应的图像边缘需要填充的大小pad_size
    padded_I = padarray(I, [pad_size pad_size], 'symmetric');%%对图像I进行填充，并初始化dark_channel暗通道矩阵
    dark_channel = zeros(h, w);%%初始化暗通道矩阵
    for i = 1:h
        for j = 1:w
            patch = padded_I(i:i+2*pad_size, j:j+2*pad_size, :);%%通过循环遍历图像I中的每个像素，求解每个像素所在的patch (size=patch_size x patch_size)，
            dark_channel(i, j) = min(patch(:));%%计算patch中的像素最小值，保存在dark_channel暗通道矩阵中
        end
    end
end