//
//  LLFileManager.h
//  LLFileManager
//
//  Created by 骆亮 on 2018/1/30.
//  Copyright © 2018年 LOLITA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLFileManager : NSObject

/// 获取文件目录
+(NSString*)getDirPath:(NSSearchPathDirectory)directory;
+(NSString*)getTmpDirPath;

///创建文件夹
+(BOOL)creatDir:(NSString*)path;

/// 创建文件
+(BOOL)creatFile:(NSString*)filePath;

/// 写数据
+(BOOL)writeToFile:(NSString*)filePath contents:(NSData*)data;
/// 追加写数据
+(BOOL)appendData:(NSData*)data withPath:(NSString *)filePath;

/// 读文件数据
+(NSData*)readFileData:(NSString*)filePath;

/// 获取文件夹下所有的文件列表
+(NSArray*)getFileList:(NSString*)path;

/// 获取文件夹下所有文件(深度遍历)
+(NSArray*)getAllFileList:(NSString*)path;

/// 移动文件
+(BOOL)moveFile:(NSString *)fromPath toPath:(NSString *)toPath toPathIsDir:(BOOL)dir;

/// 删除文件
+(BOOL)removeFile:(NSString*)filePath;

/// 删除文件夹
+(BOOL)removeDir:(NSString*)path;

/// 删除某些后缀的文件
+(void)removeFileSuffixList:(NSArray<NSString*>*)suffixList filePath:(NSString*)path deep:(BOOL)deep;

/// 获取文件大小
+(long long)getFileSize:(NSString*)path;

/// 获取文件的信息
+(NSDictionary*)getFileInfo:(NSString*)path;


@end
