#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MockedApplication : NSObject

- (void)mockPrefferedContentSizeCategory:(UIContentSizeCategory)category;
- (void)stopMockingPrefferedContentSizeCategory;

@end

NS_ASSUME_NONNULL_END
