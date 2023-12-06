
% 估计大气光函数
function A = estimate_atmosphere(I, dark_channel)%%定义一个函数，用于估算大气光。这个函数的输入是一张图像I和该图像的暗通道dark_channel，输出是一个大气光向量A
    [h, w] = size(dark_channel);%%获取暗通道dark_channel大小，
    top_pixels = ceil(h * w * 0.001);%计算出top_pixels数目(占总像素点数0.1%)，并通过maxk函数计算top_pixels个最暗像素的索引max_indices
    [~, max_indices] = maxk(dark_channel(:), top_pixels);
    A = zeros(1, 1, 3);%%初始化一个大小为1x1x3的大气光向量A
    for k = 1:3
        channel = I(:, :, k);
        A(k) = max(channel(max_indices));%%对于每个通道，从原始图像I中提取top_pixels个最暗像素，并取其最大值作为大气光向量A(k)的第k个元素
    end
end