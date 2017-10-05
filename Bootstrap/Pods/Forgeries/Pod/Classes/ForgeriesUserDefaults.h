/// Provides a NSUserDefault compatible API but is
/// much simpler, and allows for easier introspection

@interface ForgeriesUserDefaults : NSObject

/// Returns a defaults based on a dictionary.
+ (instancetype)defaults:(NSDictionary *)dictionary;

/// Sets a bool on the underlying mutable dictionary
- (void)setBool:(BOOL)value forKey:(id<NSCopying>)key;

/// Sets an object to the underlying mutable dictionary
- (void)setObject:(id<NSCopying>)object forKey:(id<NSCopying>)key;

/// Returns a bool value from the underlying mutable dictionary
- (BOOL)boolForKey:(id<NSCopying>)key;

/// Returns a string array from the underlying mutable dictionary
/// presumably someone uses this under the hood, 'cause I
/// didn't know it existed.
- (NSArray *)stringArrayForKey:(id<NSCopying>)key;

/// Returns a string value from the underlying mutable dictionary
- (NSString *)stringForKey:(id<NSCopying>)key;

/// Returns a value from the underlying mutable dictionary
- (id)objectForKey:(id<NSCopying>)key;

/// Returns a integer value from the underlying mutable dictionary
- (NSInteger)integerForKey:(NSString *)defaultName;

/// Removes a value from the underlying mutable dictionary
- (void)removeObjectForKey:(id<NSCopying>)key;

/// Find out the last key that was set on the defaults
@property (nonatomic, copy) id<NSCopying> lastSetKey;

/// Find out the last key that was requested on the default
@property (nonatomic, copy) id<NSCopying> lastRequestedKey;

/// Just offering up the full dictionary of the underlying data,
/// as this is for testing, more introspective power is a priority
@property (nonatomic, strong) NSMutableDictionary *defaults;

/// Sets `hasSyncronised` to true, basically a NO-OP for compatability
- (void)synchronize;

/// Set to false by default, so you can verify you've called it
@property (nonatomic, assign) BOOL hasSyncronised;

/// Easier introspection, basically forwards to `defaults`
- (id)objectForKeyedSubscript:(id<NSCopying>)key;

/// Alias'd to `setObject:forKey:`.
- (void)setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key;

@end
