//
//  HttpRequestServices.m
//  OLinPiKe
//
//  Created by  on 16/6/1.
//  Copyright © 2016年 alta. All rights reserved.
//

#import "HttpRequestServices.h"
#import "AFHTTPSessionManager.h"

#import "AFNetworkReachabilityManager.h"

#import <CommonCrypto/CommonDigest.h>

@interface HttpRequestServices ()
@property (strong, nonatomic)AFHTTPSessionManager *afnManager;
@end

static HttpRequestServices *service ;
@implementation HttpRequestServices
+(HttpRequestServices*)sharedInstance
{
    @synchronized(self) {
        if (!service) {
            service = [[HttpRequestServices alloc] init];
            service.afnManager = [AFHTTPSessionManager manager];
            service.afnManager.securityPolicy.allowInvalidCertificates = YES;
            service.afnManager.requestSerializer.timeoutInterval = 2;
            service.afnManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json", @"text/json", @"text/javascript",@"text/css", @"application/javascript",@"application/json", @"application/x-www-form-urlencoded", nil];
        }
        return service;
    }
}
+ (void)deleteSharedInstance {
    if (service) {
        service = nil;
    }
}
/**
 网络队列
 */
- (NSOperationQueue *)getNetworkQueue
{
    return self.afnManager.operationQueue;
}

/**
 * 取消请求
 */
-(void)cancel
{
    [self.afnManager.operationQueue cancelAllOperations];
}
/**
 队列开始请求
 */
- (void)go
{
    [self.afnManager.operationQueue setSuspended:NO];
}

//检测网络是否可用
+ (BOOL)isExistenceNetwork
{
    BOOL isExistenceNetwork = FALSE;

    switch ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus) {
        case AFNetworkReachabilityStatusNotReachable:
            isExistenceNetwork=FALSE;
            break;
        default:
            isExistenceNetwork=TRUE;
            break;
    }
    return isExistenceNetwork;
}
#pragma mark - get请求
-(void)AFGETRequestHeaderUrl:(NSString*)header appending:(NSString*)appending withParameters:(NSDictionary *)parameters{
    NSString * url = header;
    if (appending.length>0) {
        url = [url stringByAppendingString:appending];
    }
    
    NSDictionary *confirmDic = [self confirmParam:parameters];
    
    NSLog(@"url:%@",url);
    [self.afnManager GET:url parameters:confirmDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responsObject:%@",responseObject);
        
        NSDictionary *dic = responseObject;
        
        if ([dic.allKeys containsObject:@"data"]) {
            if ([responseObject[@"data"] isKindOfClass:NSString.class]) {
                NSString *str = [responseObject objectForKey:@"data"];
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                if ([dict.allKeys containsObject:@"data"]) {
                    if ([dict[@"data"] isKindOfClass:NSDictionary.class]) {
                        if ([[dict[@"data"] allKeys] containsObject:@"sid"]) {
                            self.userSid = [dict[@"data"] objectForKey:@"sid"];
                        }
                    }
                }
            }
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
}

-(NSDictionary *)confirmParam:(NSDictionary*)paramet
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self getCommondParames]];
    [dic setValuesForKeysWithDictionary:paramet];
    
    //从字典中抽取key和value
//    @"123456access_keystcol#safe#1appIdcom.actionsoft.apps.estockcentercmdportal.session.createformatjsonsig_methodHmacMD5timestamp1540776983375";//
    //timestamp=1542246491680&uid=admin&sig_method=HmacMD5&cmd=portal.session.create&pwd=123&access_key=32e07a6c-cec4-41ac-8c3c-3e2b0255ade0&format=json
    NSString *firstStr = [self stringWithDict:dic];
    //生成HMacMD5
    NSLog(@"%@",[self MD5ForUpper32Bate:firstStr]);
    NSString *HmacMD5 = [self hmac_MD5:firstStr withKey:@"123456"];
    NSLog(@"%@",HmacMD5);
    [dic setObject:HmacMD5 forKey:@"sig"];
    
    return dic;
}
-(NSString*)stringWithDict:(NSDictionary*)dict{
    
    NSArray*keys = [dict allKeys];
    
    NSArray*sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2) {
        return[obj1 compare:obj2 options:NSNumericSearch];//正序
    }];
    
    NSString*str =@"123456";
    
    for(NSString*categoryId in sortedArray) {
        
        id value = [dict objectForKey:categoryId];
        
        if([value isKindOfClass:[NSDictionary class]]) {
            
            value = [self stringWithDict:value];
            
        }
        
        if([str length] !=0) {
            
//            str = [str stringByAppendingString:@","];
            
        }
        
        str = [str stringByAppendingFormat:@"%@%@",categoryId,value];
        
    }
    NSLog(@"str:%@",str);
    return str;
}

//@"32e07a6c-cec4-41ac-8c3c-3e2b0255ade0",
-(NSDictionary *)getCommondParames
{
    NSDictionary *dic = @{@"access_key":@"32e07a6c-cec4-41ac-8c3c-3e2b0255ade0",
                          @"appId" : [self bunldID],
                          @"format" : @"json",
                          @"timestamp" : [self currentTimeStr],
                          @"sig_method" : @"HmacMD5"
                          };
    
    return dic;
}


//获取当前时间戳有两种方法(以毫秒秒为单位)
- (NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

-(NSString *)bunldID
{
    return [[NSBundle mainBundle] bundleIdentifier] ;
}


- (NSString *)hmac_MD5:(NSString *)plaintext withKey:(NSString *)key
{
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [plaintext cStringUsingEncoding:NSUTF8StringEncoding];
    const unsigned int blockSize =64;   //散列函数的分割数据长度为64
    char ipad[blockSize];
    char opad[blockSize];
    char keypad[blockSize];
    
    unsigned int keyLen = strlen(cKey); //密钥的长度
    CC_MD5_CTX ctxt;
    if (keyLen > blockSize) {  //密钥长度大于分割数据长度，则先进行md5运算，运算结果拷贝到keypad中
        CC_MD5_Init(&ctxt);
        CC_MD5_Update(&ctxt, cKey, keyLen);
        CC_MD5_Final((unsigned char *)keypad, &ctxt);
        keyLen = CC_MD5_DIGEST_LENGTH;  //使keylength为16字节
    }
    else {
        memcpy(keypad, cKey, keyLen);  //否则直接拷贝到keypad字符串中
    }
    
    memset(ipad,0x36, blockSize);  //设置ipad为0x36
    memset(opad,0x5c, blockSize);  //设置opad为0x5c
    
    int i;
    for (i =0; i < keyLen; i++) {
        ipad[i] ^= keypad[i];   //keypad与ipad做异或运算
        opad[i] ^= keypad[i];   //可以pad与opad做异或运算
    }
    
    //将ipad加入到ctxt中，再将cdata加入到ctxt中，进行md5运算,结果放入md5字符串中
    CC_MD5_Init(&ctxt);
    CC_MD5_Update(&ctxt, ipad, blockSize);
    CC_MD5_Update(&ctxt, cData,strlen(cData));
    unsigned char md5[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(md5, &ctxt);
    
    //将opad加入到ctxt中，再将上一步的md5加入到ctxt中，进行md5运算，结果放入md5字符串中
    CC_MD5_Init(&ctxt);
    CC_MD5_Update(&ctxt, opad, blockSize);
    CC_MD5_Update(&ctxt, md5,CC_MD5_DIGEST_LENGTH);
    CC_MD5_Final(md5, &ctxt);
    
    //转成16进制
    const unsigned int hex_len =CC_MD5_DIGEST_LENGTH*2+2;
    char hex[hex_len];
    for(i =0; i < CC_MD5_DIGEST_LENGTH; i++) {
        snprintf(&hex[i*2], hex_len-i*2,"%02x", md5[i]);
    }
    
    NSData *HMAC = [[NSData alloc] initWithBytes:hex length:strlen(hex)];
    NSString *hash = [[NSString alloc] initWithData:HMAC  encoding:NSUTF8StringEncoding];
    
    return [hash uppercaseString];
}

#pragma mark - MD5加密 16位 大写
- (NSString *)MD5ForUpper16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForUpper32Bate:str];
    
    NSString *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}
#pragma mark - MD5加密 32位 大写
- (NSString *)MD5ForUpper32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}

@end













