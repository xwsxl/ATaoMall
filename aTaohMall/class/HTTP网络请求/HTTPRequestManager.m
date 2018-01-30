//
//  HTTPRequestManager.m
//  aTaohMall
//
//  Created by JMSHT on 2016/12/20.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "HTTPRequestManager.h"

#import "AFNetworking.h"

//加密
#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"


@implementation HTTPRequestManager

{
    
    AFHTTPRequestOperationManager *manager;
    
}

+(HTTPRequestManager *)sharedManager
{
    
    static HTTPRequestManager *instance=nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,^{
        
        instance = [[HTTPRequestManager alloc] init];
                    
    });
    
    return instance;
    
}

-(void)DataWithURL:(NSString *)interface Success:(SuccessBlock)success failure:(FailureBlock)failure
{
    
    
    manager=[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //    NSDictionary *dict=@{@"exchange_id":@""};
    NSDictionary *dict=nil;
    
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,interface];
    
    [manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            
            if (success) {
                
                success(dic);
                
            }
            
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        
        if (failure) {
            
            failure(error);
            
            
        }
    }];
    
    
}

+(void)POST:(NSString *)interface NSDictWithString:(NSDictionary *)string parameters:(id)parameters result:(ResultBlock)result
{
    

    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    NSDictionary *dict=string;
    
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,interface];
    
    [manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            
            if (result) {
                
                result(dic,nil);
                
                
            }
            
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        
        if (result) {
            
            result(nil, error);
            
        }
    }];
    
    
    
}


@end
