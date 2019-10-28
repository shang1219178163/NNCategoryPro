//
//Created by ESJsonFormatForMac on 18/09/18.
//

#import "NNRootAppInfoModel.h"

@implementation NNRootAppInfoModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"results": [NNResultsAppInfoModel class]};
}

@end

@implementation NNResultsAppInfoModel

//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"desc": @[@"description",]
             };
}

@end


