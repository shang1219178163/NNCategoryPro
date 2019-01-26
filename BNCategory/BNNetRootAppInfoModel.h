//
//Created by ESJsonFormatForMac on 18/09/18.
//

#import <Foundation/Foundation.h>

@class BNNetResultsAppInfoModel;
@interface BNNetRootAppInfoModel : NSObject

@property (nonatomic, strong) NSArray<BNNetResultsAppInfoModel *> *results;
@property (nonatomic, assign) NSInteger resultCount;

@end
@interface BNNetResultsAppInfoModel : NSObject

@property (nonatomic, strong) NSArray<NSString *> *advisories;

@property (nonatomic, strong) NSArray *appletvScreenshotUrls;

@property (nonatomic, assign) NSInteger artistId;
@property (nonatomic, copy) NSString *artistName;

@property (nonatomic, copy) NSString *artworkUrl60;
@property (nonatomic, copy) NSString *artworkUrl100;
@property (nonatomic, copy) NSString *artworkUrl512;
@property (nonatomic, copy) NSString *artistViewUrl;

@property (nonatomic, copy) NSString *bundleId;

@property (nonatomic, copy) NSString *currency;
@property (nonatomic, copy) NSString *contentAdvisoryRating;
@property (nonatomic, copy) NSString *currentVersionReleaseDate;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, strong) NSArray *features;
@property (nonatomic, copy) NSString *fileSizeBytes;
@property (nonatomic, copy) NSString *formattedPrice;

@property (nonatomic, strong) NSArray *ipadScreenshotUrls;
@property (nonatomic, assign) BOOL isGameCenterEnabled;
@property (nonatomic, assign) BOOL isVppDeviceBasedLicensingEnabled;

@property (nonatomic, strong) NSArray<NSString *> *genreIds;
@property (nonatomic, strong) NSArray<NSString *> *genres;

@property (nonatomic, copy) NSString *kind;

@property (nonatomic, strong) NSArray<NSString *> *languageCodesISO2A;

@property (nonatomic, copy) NSString *minimumOsVersion;

@property (nonatomic, copy) NSString *releaseDate;
@property (nonatomic, copy) NSString *releaseNotes;//取更新日志信息

@property (nonatomic, copy) NSString *sellerName;
@property (nonatomic, copy) NSString *sellerUrl;
@property (nonatomic, strong) NSArray<NSString *> *screenshotUrls;
@property (nonatomic, strong) NSArray<NSString *> *supportedDevices;

@property (nonatomic, assign) NSInteger trackId;
@property (nonatomic, copy) NSString *trackName;
@property (nonatomic, copy) NSString *trackContentRating;
@property (nonatomic, copy) NSString *trackCensoredName;
@property (nonatomic, copy) NSString *trackViewUrl;// app store 跳转版本链接

@property (nonatomic, assign) NSInteger price;
@property (nonatomic, copy) NSString *primaryGenreName;
@property (nonatomic, assign) NSInteger primaryGenreId;

@property (nonatomic, copy) NSString *version;// app store 最新版本号

@property (nonatomic, copy) NSString *wrapperType;

@end

