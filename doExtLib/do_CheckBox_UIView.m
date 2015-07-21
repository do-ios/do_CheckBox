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
    _imgStatus = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"do_CheckBox_UI.bundle/check_on"]];
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
    _imgStatus.frame = CGRectMake(5, (CGRectGetHeight(r)-30)/2, 30, 30);
    _text.frame = CGRectMake(CGRectGetMinX(_imgStatus.frame)+CGRectGetWidth(_imgStatus.frame)+5,2,CGRectGetWidth(r)-CGRectGetWidth(_imgStatus.frame)-15,CGRectGetHeight(r)-4);
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
    if ([newValue boolValue]) {
        _imgStatus.image = [UIImage imageNamed:@"do_CheckBox_UI.bundle/check_on"];
    }
    else
    {
        _imgStatus.image = [UIImage imageNamed:@"do_CheckBox_UI.bundle/check_off"];
    }
    doInvokeResult * _invokeResult = [[doInvokeResult alloc]init:_model.UniqueKey];
    [_invokeResult SetResultBoolean:_isChecked];
    [_model.EventCenter FireEvent:@"checkChanged":_invokeResult];
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
    [_model SetProperties:[NSMutableDictionary dictionaryWithObject:[@(!_isChecked) stringValue] forKey:@"checked"]];
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
