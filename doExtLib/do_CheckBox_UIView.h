//
//  do_CheckBox_View.h
//  DoExt_UI
//
//  Created by @userName on @time.
//  Copyright (c) 2015年 DoExt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "do_CheckBox_IView.h"
#import "do_CheckBox_UIModel.h"
#import "doIUIModuleView.h"

@interface do_CheckBox_UIView : UIView<do_CheckBox_IView, doIUIModuleView>
//可根据具体实现替换UIView
{
	@private
		__weak do_CheckBox_UIModel *_model;
}

@end
