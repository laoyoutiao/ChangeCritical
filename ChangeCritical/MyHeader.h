//
//  MyHeader.h
//  ChangeCritical
//
//  Created by 玉文辉 on 15/9/7.
//  Copyright (c) 2015年 yuwenhui. All rights reserved.
//

#ifndef ChangeCritical_MyHeader_h
#define ChangeCritical_MyHeader_h

#define ScreenSize [UIScreen mainScreen].bounds.size

#define NSLogStr(x) NSLog(@"%@",x);

#define NSLogInt(x) NSLog(@"%d",x);

#define NSLogInteger(x) NSLog(@"%ld",x);

#define NSLogFloat(x) NSLog(@"%f",x);

#define NSLogCGFloat(x) NSLog(@"%lf",x);

#define NSLogBool(x) NSLog(@"%u",x);

#define NSLogArray(format, ...) do {                                        \
fprintf(stderr, "<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
        __LINE__, __func__);                                                \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "-------\n");                                               \
} while (0)

#endif
