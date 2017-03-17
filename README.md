# MCCrashTerminator
iOS Crash Terminator 名字听起来比较中二~-~

###先来看下网易提供给我们参考的部分
>拦截调用就是，在找不到调用的方法程序崩溃之前，你有机会通过重写NSObject的四个方法来处理:
![Paste_Image.png](http://upload-images.jianshu.io/upload_images/3258209-6cde0ee70bb20743.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
拦截调用的整个流程即Objective-C的消息转发机制。其具体流程如下图：
![Paste_Image.png](http://upload-images.jianshu.io/upload_images/3258209-ab9f7967ee8d4bb5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
由上图可见，在一个函数找不到时，runtime提供了三种方式去补救：
调用resolveInstanceMethod给个机会让类添加这个实现这个函数
调用forwardingTargetForSelector让别的对象去执行这个函数
调用forwardInvocation（函数执行器）灵活的将目标函数以其他形式执行。
如果都不中，调用doesNotRecognizeSelector抛出异常。
这里我们选择了第二步forwardingTargetForSelector来做文章。原因如下：
resolveInstanceMethod需要在类的本身上动态添加它本身不存在的方法，这些方法对于该类本身来说冗余的
forwardInvocation可以通过NSInvocation的形式将消息转发给多个对象，但是其开销较大，需要创建新的NSInvocation对象，并且forwardInvocation的函数经常被使用者调用，来做多层消息转发选择机制，不适合多次重写
forwardingTargetForSelector可以将消息转发给一个对象，开销较小，并且被重写的概率较低，适合重写
选择了forwardingTargetForSelector之后，可以将NSObject的该方法重写，做以下几步的处理：
动态创建一个桩类
动态为桩类添加对应的Selector，用一个通用的返回0的函数来实现该SEL的IMP
将消息直接转发到这个桩类对象上。
![Paste_Image.png](http://upload-images.jianshu.io/upload_images/3258209-0e9f962f5777700c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

OK..肯定还是不知道怎么搞....可以参考这篇文章对这些函数的解释:http://www.cnblogs.com/biosli/p/NSObject_inherit_2.html


>![3258209-2867f43f77e29638.png](http://upload-images.jianshu.io/upload_images/3258209-fc34bebb14375f7c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

可以使用methodSignatureForSelector进行处理(我还不是很确定这样是否合理,实践结果看了是的确可以拦截本来,但有可能影响到性能)

通过判断aselector 是否能找到对应来生成NSMethodSignature方法标签,如果不存在生成一个新方法
```
- (void)forwardInvocation:(NSInvocation *)anInvocation {
NSLog(@"******* unrecognized selector -[%s %@]", object_getClassName(self),NSStringFromSelector([anInvocation selector]));
}
```
```
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
if ([self respondsToSelector:aSelector]) {
NSMethodSignature *methodSignature = [[self class] instanceMethodSignatureForSelector:aSelector];
return methodSignature;
}else {
SEL selector = NSSelectorFromString(@"empty");
class_addMethod([self class], selector,(IMP)empty,"v@:");
NSMethodSignature *methodSignature = [[self class] instanceMethodSignatureForSelector:selector];
return methodSignature;
}
}
```
```
void empty(){
NSLog(@"empty");
}
```
