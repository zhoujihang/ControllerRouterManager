//
//  Common.h
//  RouterManager
//
//  Created by 周际航 on 2017/8/14.
//  Copyright © 2017年 周际航. All rights reserved.
//

#ifndef Common_h
#define Common_h

#ifdef DEBUG
#define XZDebugLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define XZDebugLog(...)
#endif


#endif /* Common_h */
