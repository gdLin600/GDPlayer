//
//  GDDefine.h
//  GDPlayerExample
//
//  Created by 林广德 on 16/5/23.
//  Copyright © 2016年 林广德. All rights reserved.
//

#ifndef GDDefine_h
#define GDDefine_h

#define kWeakSelf(name) __unsafe_unretained typeof(self) name = self;

/** 打印日志 */
#ifdef DEBUG
#define GDLog(fmt, ...) NSLog((@"\n类名:%@ \n方法:%s \n行数:%d \n打印:" fmt),NSStringFromClass([self class]), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define GDLog(fmt, ...)
#endif





#endif /* GDDefine_h */
