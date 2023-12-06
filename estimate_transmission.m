

% 估计透射率函数
function t = estimate_transmission(I, A, omega, patch_size)%%定义一个函数，用于估算透射率。这个函数的输入是一张图像I，一个大气光向量A，参数omega，块大小patch_size，输出是估算的透射率t
    [h, w, ~] = size(I);%%对图像I进行填充，并初始化大小为(h, w)的透射率矩阵t，其所有元素均为1
    t = ones(h, w);
    pad_size = floor(patch_size / 2);%计算需要填充的大小
    padded_I = padarray(I, [pad_size pad_size], 'symmetric');%%对图像I进行填充
    for i = 1:h%%通过循环遍历图像I中的每个像素，求解每个像素所在的patch (size=patch_size x patch_size)，并计算patch中的归一化反射率值，最后根据参数omega和大气光向量A求解出透射率t
        for j = 1:w
            patch = padded_I(i:i+2*pad_size, j:j+2*pad_size, :);
            t(i, j) = 1 - omega * min(min(mean(mean(patch(:,:,:))) ./ A(:)));
        end
    end
end
