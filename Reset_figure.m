function Reset_figure(hObject,handles)

% 初始化图像界面
clc;
axes(handles.axes1); 
cla reset; axis on; box on; % 设置图像边框 展示图像坐标轴
set(gca, 'XTickLabel', '', 'YTickLabel', '', 'Color', [1 1 1 ]); % 去掉xy标签 设置颜色
axes(handles.axes2); cla reset; axis on; box on;
set(gca, 'XTickLabel', '', 'YTickLabel', '', 'Color', [1 1 1]);


axes(handles.axes3); 
cla reset; axis on; box on; % 设置图像边框 展示图像坐标轴
set(gca, 'XTickLabel', '', 'YTickLabel', '', 'Color', [1 1 1 ]); % 去掉xy标签 设置颜色
axes(handles.axes4); cla reset; axis on; box on;
set(gca, 'XTickLabel', '', 'YTickLabel', '', 'Color', [1 1 1]);

set(handles.text1, 'String', ...
    '图像去雾系统使用流程：主菜单载入图像>-->选择去雾算法');