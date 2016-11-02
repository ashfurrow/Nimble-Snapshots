#import "NBSMockedApplication.h"
#import <OCMock/OCMock.h>

@interface NBSMockedApplication ()

@property (nonatomic, strong) id applicationMock;
@property (nonatomic, strong) id fontMock;

@end

@implementation NBSMockedApplication

/* On iOS 9, +[UIFont preferredFontForTextStyle:] uses -[UIApplication preferredContentSizeCategory]
    to get the content size category. However, this changed on iOS 10. While I haven't found what UIFont uses to get
    the current category, swizzling preferredFontForTextStyle: to use +[UIFont preferredFontForTextStyle: compatibleWithTraitCollection:]
    (only available on iOS >= 10), passing an UITraitCollection with the desired contentSizeCategory.
 */

- (void)mockPrefferedContentSizeCategory:(UIContentSizeCategory)category {
    [self stopMockingPrefferedContentSizeCategory];

    self.applicationMock = OCMPartialMock([UIApplication sharedApplication]);
    OCMStub([self.applicationMock sharedApplication]).andReturn(self.applicationMock);
    OCMStub([self.applicationMock preferredContentSizeCategory]).andReturn(category);

    if ([UITraitCollection instancesRespondToSelector:@selector(preferredContentSizeCategory)]) {
        self.fontMock = OCMClassMock([UIFont class]);
        OCMStub([self.fontMock preferredFontForTextStyle:[OCMArg any]]).andCall(self, @selector(preferredFontForTextStyle:));
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:UIContentSizeCategoryDidChangeNotification
                                                        object:[UIApplication sharedApplication]
                                                      userInfo:@{UIContentSizeCategoryNewValueKey: category}];
}

- (UIFont *)preferredFontForTextStyle:(UIFontTextStyle)style {
    UIContentSizeCategory category = [self.applicationMock preferredContentSizeCategory];
    UITraitCollection *categoryTrait = [UITraitCollection traitCollectionWithPreferredContentSizeCategory:category];
    return [UIFont preferredFontForTextStyle:style compatibleWithTraitCollection:categoryTrait];
}

- (void)stopMockingPrefferedContentSizeCategory {
    [self.applicationMock stopMocking];
    self.applicationMock = nil;

    [self.fontMock stopMocking];
    self.fontMock = nil;
}

@end
