//
//  PopupDefine.h
//  EmptyDemo
//
//  Created by njw on 2018/10/17.
//  Copyright © 2018 njw. All rights reserved.
//

#ifndef PopupDefine_h
#define PopupDefine_h

#define PWeakify(o)        __weak   typeof(self) mmwo = o;
#define PStrongify(o)      __strong typeof(self) o = mmwo;
#define PHexColor(color)   [UIColor p_colorWithHex:color]
#define P_SPLIT_WIDTH      (1/[UIScreen mainScreen].scale)

#define P_VA_LIST      NSMutableArray *itemsArr = [NSMutableArray array];\
id tmpValue = items;\
int tmpCount = 0;\
va_list list;\
va_start(list,items);\
while(tmpValue != nil)\
{\
    ++tmpCount;\
    [itemsArr addObject:tmpValue];\
    tmpValue = va_arg(list,id);\
}\
va_end(list);\

#endif /* PopupDefine_h */
