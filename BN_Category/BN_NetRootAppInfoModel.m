//
//Created by ESJsonFormatForMac on 18/09/18.
//

#import "BN_NetRootAppInfoModel.h"
@implementation BN_NetRootAppInfoModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"results" : [BN_NetResultsAppInfoModel class]};
}

@end

@implementation BN_NetResultsAppInfoModel

//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"desc" : @[@"description",]
             };
}

@end


