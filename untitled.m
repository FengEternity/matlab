% 给定数据
methods = {'Global', 'Local', 'Retinex', 'DCP', 'DCPNew', 'DehazeNet', 'MSCNN'};
entropy = [5.9865, 7.3161, 6.2128, 7.1483, 7.6359, 7.6463, 7.7125];
ver = [0.97443, 0.99779, 0.92993, 0.82714, 1, 0.99101, 1];
psnr = [21.1693, 18.2166, 9.2431, 19.5596, 23.2266, 21.765, 22.4335];
ssim = [0.85595, 0.73147, 0.50543, 0.85337, 0.86454, 0.89602, 0.93223];

% 绘制条形图
figure;
subplot(2, 2, 1);
bar(methods, entropy);
title('Entropy');

subplot(2, 2, 2);
bar(methods, ver);
title('VER');

subplot(2, 2, 3);
bar(methods, psnr);
title('PSNR');

subplot(2, 2, 4);
bar(methods, ssim);
title('SSIM');

% 添加标签和图例
for i = 1:length(methods)
    text(i, entropy(i), num2str(entropy(i), '%.4f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
    text(i, ver(i), num2str(ver(i), '%.4f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
    text(i, psnr(i), num2str(psnr(i), '%.4f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
    text(i, ssim(i), num2str(ssim(i), '%.4f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
end

legend('Global', 'Local', 'Retinex', 'DCP', 'DCPNew', 'DehazeNet', 'MSCNN', 'Location', 'Best');
