//
//Created by ESJsonFormatForMac on 18/09/18.
//

#import "BNNetRootAppInfoModel.h"
@implementation BNNetRootAppInfoModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"results" : [BNNetResultsAppInfoModel class]};
}

@end

@implementation BNNetResultsAppInfoModel

//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"desc" : @[@"description",]
             };
}

@end


