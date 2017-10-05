#import "ForgeriesUserDefaults.h"

@interface ForgeriesUserDefaults ()
// This is used by QLPreviewController for something.
@property (nonatomic, assign) BOOL QLDisableQuicklookd;
@end


@implementation ForgeriesUserDefaults

+ (instancetype)defaults:(NSDictionary *)dictionary
{
    ForgeriesUserDefaults *defaults = [[ForgeriesUserDefaults alloc] init];
    defaults.defaults = [dictionary mutableCopy];
    return defaults;
}

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;

    _defaults = [NSMutableDictionary dictionary];

    return self;
}

- (void)setBool:(BOOL)value forKey:(id<NSCopying>)key
{
    [self setObject:@(value) forKey:key];
}

- (void)setObject:(id<NSCopying>)object forKey:(id<NSCopying>)key
{
    self.lastSetKey = key;
    self.defaults[key] = object;
}

- (BOOL)boolForKey:(id<NSCopying>)key
{
    self.lastRequestedKey = key;
    BOOL value = [[self objectForKey:key] boolValue];
    return value;
}

- (id)objectForKey:(id<NSCopying>)key
{
    self.lastRequestedKey = key;
    return self.defaults[key];
}

- (NSString *)stringForKey:(id<NSCopying>)key
{
    id object = [self objectForKey:key];
    return [object isKindOfClass:NSString.class] ? object : nil;
}

- (NSArray *)arrayForKey:(id<NSCopying>)key
{
    id object = [self objectForKey:key];
    return [object isKindOfClass:NSArray.class] ? object : nil;
}

- (NSInteger)integerForKey:(NSString *)defaultName
{
    id object = [self objectForKey:defaultName];
    return [object isKindOfClass:NSNumber.class] ? [object integerValue] : 0;
}

- (NSArray *)stringArrayForKey:(id<NSCopying>)key
{
    id object = [self objectForKey:key];
    return [object isKindOfClass:NSArray.class] ? object : nil;
}

- (id)objectForKeyedSubscript:(id<NSCopying>)key
{
    return [self objectForKey:key];
}

- (void)setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key
{
    [self setObject:obj forKey:key];
}

- (void)synchronize
{
    self.hasSyncronised = YES;
}

- (void)registerDefaults:(NSDictionary *)dictionary
{
    [_defaults addEntriesFromDictionary:dictionary];
}

- (void)removeObjectForKey:(id<NSCopying>)key
{
    [self.defaults removeObjectForKey:key];
}

- (NSDictionary *)persistentDomainForName:(NSString *)domainName
{
    return _defaults;
}

- (NSDictionary *)dictionaryRepresentation
{
    return _defaults.copy;
}

@end
