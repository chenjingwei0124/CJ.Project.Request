//
//  MacroUtility.h
//  CJ.Project.Request
//
//  Created by 陈警卫 on 2017/9/6.
//  Copyright © 2017年 陈警卫. All rights reserved.
//

#ifndef MacroUtility_h
#define MacroUtility_h


/*** DLOG */
#if DEBUG
#ifndef DLog
#define DLog(format, args...) \
NSLog(@"[%s:%d]: " format "\n", strrchr(__FILE__, '/') + 1, __LINE__, ## args);
#endif
#else
#ifndef DLog
#define DLog(format, args...) do {} while(0)
#endif
#endif

#endif /* MacroUtility_h */
