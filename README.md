# CoreAnimation-笔记
1.图层：
UIView:iOS中所有可视化视图的父类，对子视图的管理、响应事件和做动画。
CALay:可以包含一些内容，做动画，和UIView最大的不同是不能响应事件。
每一个UIView都有一个默认的CALayer实例，它们是平行的层级关系，视图的职责是创建并管理这个图层，真正在屏幕上显示和做动画的是这些背后关联的图层，UIView仅仅是对它的一层封装，提供一些具体的功能（处理触摸），以及Core Animation底层方法的高级接口。

2.寄宿图

contents属性：CALayer 有一个属性叫做contents，这个属性的类型被定义为id
layer.contents = (__bridge id)image.CGImage;
contentGravity:和UIView的contentMode对应
contentRect:CALayer的contentsRect属性允许我们在图层边框里显示寄宿图的一个子域。
contentsCenter:是一个CGRect,它定义了一个固定的边框和一个在图层上可拉伸的区域。
layer.contentsCenter = rect;

3.图层几何学

布局：改变视图的frame，实际是改变位于视图下方图层的frame，对视图或图层做变换时（eg.旋转），覆盖旋转之后的整个轴对齐的矩形区域，即frame和bounds可能不一致。

锚点（anchorPoint）：anchorPoint是相对于自身layer，anchorPoint点(锚点)的值是用相对bounds的比例值来确定的，iOS坐标系中(0,0), (1,1)分别表示左上角、右下角.图层的anchorPoint通过position来控制它的frame的位置，你可以认为anchorPoint是用来移动图层的把柄。
改变了anchorPoint，position属性保持固定的值并没有发生改变，但是frame却移动了。

图层的zPosition: 除了做变换之外，zPosition最实用的功能就是改变图层的显示顺序了。

Hit Testing:
CALayer并不关心任何响应链事件，所以不能直接处理触摸事件或者手势。但是它有一系列的方法帮你处理事件：-containsPoint:和-hitTest:。
-containsPoint:接受一个在本图层坐标系下的CGPoint，如果这个点在图层frame范围内就返回YES。
-hitTest:它返回图层本身，或者包含这个坐标点的叶子节点图层。

图层不能自动调整和自动布局

4.视觉效果

图层边框：边框是绘制在图层边界里面的(borderWidth,borderColor)
阴影（shadowOpacity）:图层的阴影继承自图层的内容，会将寄宿图（子视图）考虑在内
shadowPath:可指定阴影形状

图层蒙板(mask)：定义了父图层的可见区域，只有在mask图层里面的内容才会展示，除此之外的都会被隐藏

拉伸过滤：
minificationFilter（缩小）和magnificationFilter（放大）属性

5.变换
透视投影：CATransform3D的透视效果通过矩阵中的m34元素来控制。sublayerTransform属性，对图层的容器做变换，可影响其上的所有子图层。

6.专用图层
CAShapeLayer:定义各种形状的图层（硬件加速，快速渲染、高效使用内存、不会被图层边界剪裁掉和不会出现像素化）。
CATextLayer:比UILabel渲染快很多。UILabel的替代品：创建一个UILabel的子类，重写+layerClass用CATextLayer替换子类里的默认CALayer,重写UILabel的setter方法。
CATransformLayer:3D变换图层
CAGradientLayer:渐变层；startPoint和endPoint，决定了渐变方向，以单位坐标系进行定义，（0，0）代表左上角，（1，1）代表右下角。
CAReplicatorLayer:生成相似的图层
CAScrollLayer:图层滑动

7.隐式动画
事务：Core Animation在每个runloop周期自动开始一次新的事务，即使不显式调用开始一次事务，任何一次run loop循环中属性的改变都会被集中起来，然后做一次0.25秒的动画。任何Core Animation动画都有一个事务来管理，在子线程起一个新事务也可以刷新UI。
完成块：在动画结束后提供一个完成的动作（setCompletionBlock:）。
图层行为：
1.UIView关联的图层禁用了隐式动画。
2.对于单独存在的图层，我们可以通过实现图层的-actionForLayer: forKey:委托方法，或者提供一个action字典来控制隐式动画。
呈现与模型：
Core Animation 扮演了一个控制器的角色，负责根据图层行为和事务设置去不断更新视图的这些属性在屏幕的状态
CALayer行为，存储了试图如何显示和动画的数据模型
CALayer，连接用户界面（view）虚构的类
呈现图层，每个图层都有一个呈现图层，它的属性值代表了任何指定时刻当前外观效果。
应用场景：
1.同步动画
2.处理用户交互

8.显示动画
属性动画(CAPropertyAnimation)：是虚类继承于CAAnimation，它有两个子实类，CABasicAnimation和CAKeyframeAnimation。
动画组(CAAnimationGroup)：是实类继承于CAAnimation。
过渡动画(CATransition)：是实类继承于CAAnimation。对图层树的动画一般是添加到被影响图层的superlayer

9.图层时间

10.缓冲

11.基于定时器的动画
每个线程都管理一个NSRunloop（通过一个循环来完成一些任务列表）,主线程处理的任务列表有：
1.处理触摸事件
2.发送和接受网络数据包
3.执行使用gcd的代码
4.处理计时器行为
5.屏幕重绘
run loop mode 
NSDefaultRunLoopMode -标准优先级
NSRunLoopCommonModes -高优先级
NSTrackingRunLoopMode -用于UIScrollView和别的控件的动画
NSTimer: ——>NSRunLoopCommonModes
CADisplayLink:——>同时加入 NSDefaultRunLoopMode和NSTrackingRunLoopMode
物理模拟：

12.性能调优
动画和屏幕上组合的图层是被一个单独的进程（BackBoard）管理（渲染服务），而不是你的应用程序。

运行动画过程中涉及的六个阶段：
1.布局—准备视图/图层的层级关系，以及设置图层属性的阶段。
2.显示—图层的寄宿图片被绘制的阶段，涉及-drawRect:和-drawLayer:incontext:的方法调用。
3.准备— CA发送动画数据到渲染服务的阶段。
4.提交— CA打包所有图层和动画属性，通过IPC（内部处理信号）发送渲染服务进行显示。

5.对所有的图层属性计算中间值，设置OpenGL几何形状（纹理化的三角形）来执行渲染。
6.在屏幕上渲染可见的三角形。

会降低（基于GPU）图层绘制的事情：
	·太多的几何结构
	·重绘
	·离屏绘制
	·过大的图片

延迟动画的开始时间的CPU操作：
	·布局计算
	·视图懒加载
	·Core Graphics绘制
	·解压图片

13.高效绘图
软件绘图：通常由Core Graphics框架来完成，相比Core Animation和OpenGL，Core Graphics要慢很多。
CALayer只需要一些与自己相关的内存，只有它的寄宿图绘消耗一定的内存空间，即便直接赋值给contents属性一张图片，也不需要增加额外的照片存储大小。如果相同的一张图片被多个图层作为contents属性，它们将会共用同一块内存，而不是复制内存块。
矢量图形：
Core Graphics绘图：由CPU协助的绘图；每次移动手指的时候都会重绘，而重绘需要重新抹掉内存，然后重新分配。
CAShapeLayer:由GPU协助的绘图,由硬件提供支持；避免创建一个寄宿图。

14.图像IO
加载和潜伏：大图的加载有两种方式，后台线程和CATiledLayer
缓存：
+imageNamed:方法
1.仅适用于程序资源束目录下的图片，对网络或者用户相机中获取的图片没发用。
2.对于大图系统可能会移除这些图片来节省内存。
3.缓存机制不公开。
自定义缓存：1)提前缓存。2）缓存失效。3）缓存回收
NSCache :和NSDictionary类似，可以通过setObject:forKey:和-objectForKey方法来插入和检索，和字典不同的是NSCache在系统低内存的时候自动丢弃存储的对象。

15.图层性能
离屏渲染：
1.圆角（当和maskToBounds一起使用时）
2.图层蒙板
3.阴影
减少图层数量：
1.随着视图滚动动态实例化图层。
2.对象回收，创建一个相似对象池。
