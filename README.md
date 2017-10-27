# ios-driving-range 
个人的 iOS 练习场，平时看到有意思的东西或者自己项目中用到的小东西，都放在这里做一个归纳和备忘。



# 介绍

### TransitionButton

![TransitionButton 动画](http://ol972cch2.bkt.clouddn.com/TransitionButton.gif)

`TransitionButton` 是利用 `PaintCode` 软件把图形的路径转换成 iOS 代码，然后再把这个路径代码赋值给 `CAShapeLayer` 的 `path` 属性。通过 `CoreAnimation` 动画修改路径的 `strokeStart` `strokeEnd` 属性来实现上图中的效果。看似复杂的动画，其实并不需要写多少行代码。主要的精力花在了 `PaintCode` 画图形路径上，这是这个例子的 [PaintCode 设计稿](https://raw.githubusercontent.com/taooba/ios-driving-range/master/ios-driving-range/TransitionButton/button_icons.pcvd) ，我使用的是 `PaintCode 2.4.2 `。这个例子的实现受教于[[译] 用 Swift 制作一个漂亮的汉堡按钮过渡动画](https://itony.me/714.html)一文，原文中的例子更加简单易懂，这是它的[项目地址](https://github.com/robb/hamburger-button)。

