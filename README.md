# ios-driving-range 
个人的 iOS 练习场，平时看到有意思的东西或者自己项目中用到的小东西，都放在这里做一个归纳和备忘。



# 介绍

### TransitionButton

![TransitionButton 动画](http://ol972cch2.bkt.clouddn.com/TransitionButton.gif)

`TransitionButton` 是利用 `PaintCode` 软件把一些图形的路径转换成代码，然后再把这个路径代码赋值给 `CAShapeLayer` 的 `path` 属性。再通过 `CoreAnimation` 动画的修改 `strokeStart` `strokeEnd` 属性来实现上图中的效果。看似复杂的动画，其实并不需要写多少行代码。主要的精力花在了 `PaintCode` 画图形路径上。

