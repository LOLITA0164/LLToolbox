# LLToolbox

[![CI Status](https://img.shields.io/travis/LOLITA0164/LLToolbox.svg?style=flat)](https://travis-ci.org/LOLITA0164/LLToolbox)
[![Version](https://img.shields.io/cocoapods/v/LLToolbox.svg?style=flat)](https://cocoapods.org/pods/LLToolbox)
[![License](https://img.shields.io/cocoapods/l/LLToolbox.svg?style=flat)](https://cocoapods.org/pods/LLToolbox)
[![Platform](https://img.shields.io/cocoapods/p/LLToolbox.svg?style=flat)](https://cocoapods.org/pods/LLToolbox)


## 安装

通过 `CocoaPods` 进行安装。在你的 Podfile 文件中添加以下内容


```ruby
pod 'LLToolbox'
```

执行 

```
pod install
```

## 作者

LOLITA0164, 476512340@qq.com

## 实例

**模型转换工具**

```
// 字典 -> 数据模型
LLPerson* pp = [LLPerson objectWithModelDic:@{
    @"name":@"luoliang"
}];
// 现有数据模型追加数据
[pp appendFromDic:@{
    @"age":@(27)
}];
// 数据模型 -> 字典
NSDictionary* dic = pp.dictionary;
// 输出当前数据模型信息
[pp print];
```

**KVO工具**

```
self.handle = [LLKVO addObserverTo:self.AView forKey:@"backgroundColor" block:^(NSDictionary *changes) {
	NSLog(@"%@", changes);
}];
```

高内聚地形式实现对某个属性变化的监听，帮你自动完成监听的移除（移除的时机即`handle`的释放）。

**定时器工具**

```
// 创建定时器
self.timer  = [LLTimer timeInertval:2.0 target:self selector:@selector(doSomething) userInfo:nil];
// 暂停定时器
[self.timer pause];
// 恢复定时器
[self.timer resume];
[self.timer resumeAfterTimeInterval:10.0];
```

该定时器拥有和 `self` 相同的生命周期，不必担心可能存在的循环引用问题。



## License

LLToolbox is available under the MIT license. See the LICENSE file for more info.
