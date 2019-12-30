//
//  MMMacro.h
//  Bob
//
//  Created by ripper on 2019/11/12.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#define mm_weakify(...) @weakify(__VA_ARGS__)
#define mm_strongify(...) @strongify(__VA_ARGS__)

#define mm_ignoreUnusedVariableWarning(var) (void)(var);

#define mm_singleton_h +(instancetype)shared;

#define mm_singleton_m \
static id _instance; \
\
+(instancetype)shared { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
+(id)copy { \
return _instance; \
}
