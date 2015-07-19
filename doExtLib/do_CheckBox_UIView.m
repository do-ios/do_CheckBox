//
//  do_CheckBox_View.m
//  DoExt_UI
//
//  Created by @userName on @time.
//  Copyright (c) 2015年 DoExt. All rights reserved.
//

#import "do_CheckBox_UIView.h"

#import "doInvokeResult.h"
#import "doUIModuleHelper.h"
#import "doScriptEngineHelper.h"
#import "doIScriptEngine.h"
#import "doTextHelper.h"

static NSString *img_on = @"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";

static NSString *img_off = @"iVBORw0KGgoAAAANSUhEUgAAABYAAAAWCAYAAADEtGw7AAAAAXNSR0IArs4c6QAAABxpRE9UAAAAAgAAAAAAAAALAAAAKAAAAAsAAAALAAACB9dQ++IAAAHTSURBVEgNlFLJTgJBEJ2D/pbLWRQUEDf0AzQhKho1xMDBizFGoxBlG2DUuKEDA56MRA/ggsvX6LGsVz1tDIkHDy/VXcurV9VtNBrUdduI7983F6n5EqVWe5Ge3pcFz+8r9PKxSo9vS4QzoGPif41S83WF6xa4bokeWlG6u48n2+12t1E8nfVadvgzdeGh7LWPclU/FZ0xKtXGGZNk1cJicTdrISqIX8XgQ262MkIZe5jSZQ+V7Jkv62TOZ2zs9c8fXg5SjgMAEo9uwowZ1+KsUKxPkVWf/hVXOdK0Mir1qTMPJXZ65421zZ7IwfkgmRwoVENCbDEByEAEe+w20VY3RRPkgjjPtRAGkbGtvogR2+qJZK68Qpx3ApStsnJeB6zJFudOmNWg6wsSanJ8x6QgPigPUWLXJVar8FPBUaqhHAo6of0g1jE9Je5mJUDpSy+tsVhjfbtPFOf5AfBYJYdH+weKzoTUoQEUgxicsgqtGCOJGlauxsXICqKQ/aLMzdP5yEWDnO13d8yKsWO8JMaQVWAd/0ZAPaAdFOIfxWleOLrp/6vGwx/lMXktsJ3QfvwInPHAsmPmglgDi06eDwgx9qSBJvphcNb3v+LwQ1ym7BPibwAAAP//3wh7owAAAeRJREFUpVFLTxNhFP12rl21P6A74x6TSkho+i4iQpGfwGrSBQk2hIQ0UcBpHaalUNrpA8rLgKXgf+H7N9dzrozMxo1Ocue+zj338Zktd9Y5uV2QwbQspz/X/llGDx8luHsv3R/vZKcx7xj+6JxMFqX/UBYChtD9+1XVQ+qojVw0T1xY0wPH8feSbDfmHLPtzjl02G0wXZbgfkX14En/9ssSYCNuRT8U4sOa/nRJOdrXReEVzMZu0vEv89KbLGkhAQRTR+UPyd0HEDxLiGG+M1mQFriUuLo76zQvi3KMO3PqqLBZ1A9trhza1CGOJ21dFKSKK+jE3jgnzauCHp7J7u3isx31/xbnG2EwnsE7zwuvYCq1N05jmNFOR7h156akgM4NGjwVsOgI8RYKtTHixDHO96GwltN6o7zwCmbzy9tKvZ8R7xRTo5vKRU4OcZ5DbNG+KqnNd2gyjhgbHADLTYkL676NsuIGaanUZipmq5Ze/9rLyV43pUEmfRS4g6w288cFOTjLI1ZQqSPPIRirD3NquxisAfx+Ny3k2thJrZtkMvny0+dM2w2yj/tB2qKjBbkF0PrjosVqaoPIgtCCxPqIecgTQ2HNXi9lQfxYBRc5Db9EIvEiHo+/isVir/9HyEEucv4C2kidCQj5FesAAAAASUVORK5CYII=";

#define FONT_OBLIQUITY 15.0

@implementation do_CheckBox_UIView
{
    UIImageView *_imgStatus;
    UILabel *_text;
    
    NSString *_myFontStyle;
    NSString *_myFontFlag;
    BOOL _isChecked;
}
#pragma mark - doIUIModuleView协议方法（必须）
//引用Model对象
- (void) LoadView: (doUIModule *) _doUIModule
{
    _model = (typeof(_model)) _doUIModule;
    
    NSData *i = [[NSData alloc] initWithBase64EncodedString:img_on options:NSDataBase64DecodingIgnoreUnknownCharacters];
    _imgStatus = [[UIImageView alloc] initWithImage:[UIImage imageWithData:i]];
    _text = [UILabel new];
    _text.textAlignment = NSTextAlignmentLeft;
    _text.numberOfLines = 1;
    
    [self change_checked:[_model GetProperty:@"checked"].DefaultValue];
    [self change_enabled:[_model GetProperty:@"enabled"].DefaultValue];
    [self change_fontColor:[_model GetProperty:@"fontColor"].DefaultValue];
    [self change_fontSize:[_model GetProperty:@"fontSize"].DefaultValue];
    
    [self addSubview:_imgStatus];
    [self addSubview:_text];
}
//销毁所有的全局对象
- (void) OnDispose
{
    //自定义的全局属性,view-model(UIModel)类销毁时会递归调用<子view-model(UIModel)>的该方法，将上层的引用切断。所以如果self类有非原生扩展，需主动调用view-model(UIModel)的该方法。(App || Page)-->强引用-->view-model(UIModel)-->强引用-->view
    _myFontStyle = nil;
    _imgStatus = nil;
    _text = nil;
}
//实现布局
- (void) OnRedraw
{
    //实现布局相关的修改,如果添加了非原生的view需要主动调用该view的OnRedraw，递归完成布局。view(OnRedraw)<显示布局>-->调用-->view-model(UIModel)<OnRedraw>
    //重新调整视图的x,y,w,h
    [doUIModuleHelper OnRedraw:_model];
    CGRect r = self.frame;
    _imgStatus.frame = CGRectMake(2, 2, CGRectGetHeight(r)-4, CGRectGetHeight(r)-4);
    _text.frame = CGRectMake(CGRectGetMinX(_imgStatus.frame)+CGRectGetWidth(_imgStatus.frame)+5,CGRectGetMinY(_imgStatus.frame),CGRectGetWidth(r)-CGRectGetWidth(_imgStatus.frame)-9,CGRectGetHeight(_imgStatus.frame));
}

#pragma mark - TYPEID_IView协议方法（必须）
#pragma mark - Changed_属性
/*
 如果在Model及父类中注册过 "属性"，可用这种方法获取
 NSString *属性名 = [(doUIModule *)_model GetPropertyValue:@"属性名"];
 
 获取属性最初的默认值
 NSString *属性名 = [(doUIModule *)_model GetProperty:@"属性名"].DefaultValue;
 */
- (void)change_checked:(NSString *)newValue
{
    //自己的代码实现
    _isChecked = [newValue boolValue];
    NSString *string = [newValue boolValue]?img_on:img_off;
    NSData *i = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    _imgStatus.image = [UIImage imageWithData:i];
}
- (void)change_enabled:(NSString *)newValue
{
    //自己的代码实现
    self.userInteractionEnabled = [newValue boolValue];
}
- (void)change_fontColor:(NSString *)newValue
{
    //自己的代码实现
    UIColor *color = [doUIModuleHelper GetColorFromString:newValue :[UIColor blackColor]];
    [_text setTextColor:color];
}
- (void)change_fontSize:(NSString *)newValue
{
    //自己的代码实现
    int _intFontSize = [doUIModuleHelper GetDeviceFontSize:[[doTextHelper Instance] StrToInt:newValue :[[_model GetProperty:@"fontSize"].DefaultValue intValue]] :_model.XZoom :_model.YZoom];
    _text.font = [UIFont systemFontOfSize:_intFontSize];;
}
- (void)change_fontStyle:(NSString *)newValue
{
    //自己的代码实现
    _myFontStyle = [NSString stringWithFormat:@"%@",newValue];
    if (_text.text==nil || [_text.text isEqualToString:@""]) return;

    float fontSize = _text.font.pointSize;
    if([newValue isEqualToString:@"normal"])
        [_text setFont:[UIFont systemFontOfSize:fontSize]];
    else if([newValue isEqualToString:@"bold"])
        [_text setFont:[UIFont boldSystemFontOfSize:fontSize]];
    else if([newValue isEqualToString:@"italic"])
    {
        CGAffineTransform matrix =  CGAffineTransformMake(1, 0, tanf(FONT_OBLIQUITY * (CGFloat)M_PI / 180), 1, 0, 0);
        UIFontDescriptor *desc = [ UIFontDescriptor fontDescriptorWithName :[ UIFont systemFontOfSize :fontSize ]. fontName matrix :matrix];
        [_text setFont:[ UIFont fontWithDescriptor :desc size :fontSize]];
    }
    else if([newValue isEqualToString:@"bold_italic"]){}
    else
    {
        NSString *mesg = [NSString stringWithFormat:@"不支持字体:%@",newValue];
        [NSException raise:@"do_CheckBox" format:mesg,@""];
    }
}
- (void)change_text:(NSString *)newValue
{
    //自己的代码实现
    [_text setText:newValue];
    if(_myFontStyle)
        [self change_fontStyle:_myFontStyle];
    if (_myFontFlag)
        [self change_textFlag:_myFontFlag];
}
- (void)change_textFlag:(NSString *)newValue
{
    //自己的代码实现
    _myFontFlag = [NSString stringWithFormat:@"%@",newValue];
    if (_text.text==nil || [_text.text isEqualToString:@""]) return;

    NSMutableAttributedString *content = [_text.attributedText mutableCopy];
    [content beginEditing];
    NSRange contentRange = {0,[content length]};
    if ([newValue isEqualToString:@"normal" ]) {
        [content removeAttribute:NSUnderlineStyleAttributeName range:contentRange];
        [content removeAttribute:NSStrikethroughStyleAttributeName range:contentRange];
    }else if ([newValue isEqualToString:@"underline" ]) {
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    }else if ([newValue isEqualToString:@"strikethrough" ]) {
        [content addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    }
    _text.attributedText = content;
    [content endEditing];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.userInteractionEnabled) {
        return;
    }
    [self change_checked:[@(!_isChecked) stringValue]];
    doInvokeResult * _invokeResult;
    _invokeResult = [[doInvokeResult alloc]init:_model.UniqueKey];
    [_invokeResult SetResultBoolean:!_isChecked];
    [_model.EventCenter FireEvent:@"checkChanged":_invokeResult];
}

#pragma mark - doIUIModuleView协议方法（必须）<大部分情况不需修改>
- (BOOL) OnPropertiesChanging: (NSMutableDictionary *) _changedValues
{
    //属性改变时,返回NO，将不会执行Changed方法
    return YES;
}
- (void) OnPropertiesChanged: (NSMutableDictionary*) _changedValues
{
    //_model的属性进行修改，同时调用self的对应的属性方法，修改视图
    [doUIModuleHelper HandleViewProperChanged: self :_model : _changedValues ];
}
- (BOOL) InvokeSyncMethod: (NSString *) _methodName : (NSDictionary *)_dicParas :(id<doIScriptEngine>)_scriptEngine : (doInvokeResult *) _invokeResult
{
    //同步消息
    return [doScriptEngineHelper InvokeSyncSelector:self : _methodName :_dicParas :_scriptEngine :_invokeResult];
}
- (BOOL) InvokeAsyncMethod: (NSString *) _methodName : (NSDictionary *) _dicParas :(id<doIScriptEngine>) _scriptEngine : (NSString *) _callbackFuncName
{
    //异步消息
    return [doScriptEngineHelper InvokeASyncSelector:self : _methodName :_dicParas :_scriptEngine: _callbackFuncName];
}
- (doUIModule *) GetModel
{
    //获取model对象
    return _model;
}

@end
