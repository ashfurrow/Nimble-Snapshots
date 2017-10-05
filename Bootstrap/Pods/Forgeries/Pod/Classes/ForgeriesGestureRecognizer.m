#import "ForgeriesGestureRecognizer.h"
#import <objc/runtime.h>

void *ForgeryGestureRecognizerTargetActionsKey = &ForgeryGestureRecognizerTargetActionsKey;

@interface TargetAction : NSObject

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL action;

- (instancetype)initWithTarget:(id)target action:(SEL)action;

@end

@implementation TargetAction

- (instancetype)initWithTarget:(id)target action:(SEL)action {
    self = [super init];
    if (self == nil) return nil;

    self.target = target;
    self.action = action;

    return self;
}

@end

@implementation UIGestureRecognizer (Forgeries)

- (NSMutableArray *)targetActionArray {
    NSMutableArray *array = objc_getAssociatedObject(self, ForgeryGestureRecognizerTargetActionsKey);

    if (array == nil) {
        array = [NSMutableArray array];

        objc_setAssociatedObject(self, ForgeryGestureRecognizerTargetActionsKey, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    return array;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
- (void)invoke {
    for (TargetAction *pair in self.targetActionArray) {
        if ([NSStringFromSelector(pair.action) hasSuffix:@":"]) {
            [pair.target performSelector:pair.action withObject:self];
        } else {
            [pair.target performSelector:pair.action];
        }
    }
}
#pragma clang diagnostic pop

- (void)addTestingTarget:(id)target action:(SEL)action {
    [self.targetActionArray addObject:[[TargetAction alloc] initWithTarget:target action:action]];
}

- (void)removeTestingTarget:(id)target action:(SEL)action {
    if (target == nil || action == nil) {
        [self.targetActionArray removeAllObjects];
    } else {
        NSArray *pairsToRemove = [self.targetActionArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(TargetAction *pair, NSDictionary *bindings) {
            return pair.target == target && pair.action == action;
        }]];

        [self.targetActionArray removeObjectsInArray:pairsToRemove];
    }
}

@end

#define ForgeryUIGestureRecognizerSubclassImplementation(name) \
@implementation name \
@synthesize state; \
- (instancetype)initWithTarget:(id)target action:(SEL)action { \
    self = [super initWithTarget:target action:action]; \
    if (self != nil) { \
        [self addTestingTarget:target action:action]; \
    } \
    return self; \
} \
- (void)addTarget:(id)target action:(SEL)action { \
    [super addTarget:target action:action]; \
    [self addTestingTarget:target action:action]; \
 \
} \
- (void)removeTarget:(id)target action:(SEL)action { \
    [super removeTarget:target action:action]; \
    [self removeTestingTarget:target action:action]; \
} \
- (CGPoint)locationInView:(UIView *)view { \
    return self.testing_location; \
} \
- (CGPoint)velocityInView:(UIView *)view { \
    return self.testing_velocity; \
} \
- (CGPoint)translationInView:(UIView *)view { \
    return self.testing_translation; \
} \
- (UIGestureRecognizerState)state {\
    return self.testing_state; \
} \
@end

ForgeryUIGestureRecognizerSubclassImplementation(ForgeryTapGestureRecognizer)
ForgeryUIGestureRecognizerSubclassImplementation(ForgeryPinchGestureRecognizer)
ForgeryUIGestureRecognizerSubclassImplementation(ForgeryRotationGestureRecognizer)
ForgeryUIGestureRecognizerSubclassImplementation(ForgerySwipeGestureRecognizer)
ForgeryUIGestureRecognizerSubclassImplementation(ForgeryPanGestureRecognizer)
ForgeryUIGestureRecognizerSubclassImplementation(ForgeryScreenEdgeGestureRecognizer)
ForgeryUIGestureRecognizerSubclassImplementation(ForgeryLongPressGestureRecognizer)
