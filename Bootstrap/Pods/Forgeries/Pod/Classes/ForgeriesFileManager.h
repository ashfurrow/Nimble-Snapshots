NS_ASSUME_NONNULL_BEGIN

@interface ForgeryFile : NSObject
@property (nonatomic, copy) NSString *path;
@property (nonatomic, strong) NSData *data;
@end

/// Provides a NSFileManager compatible API but allows you to have an
/// in-memory lookup store with a simple dictionary based file system API

@interface ForgeriesFileManager : NSFileManager

/// This will generate a file mapping where it will generate the `ForgeryFile`s for you
/// based on the mapping dict you provide. Values can be NSString or NSDictionaries.

/// The filemap supports shortcuts, to make it easier to deal with paths:
/// - App Bundle     : @"/app/thing.txt"
/// - User Documents : @"/docs/thing.txt"
///
+ (instancetype)withFileStringMap:(NSDictionary <NSString *, id>*)dictionary;

/// Just offering up the full dictionary of the underlying file mapping data,
/// as this is for testing, more introspective power is a priority
@property (nonatomic, strong) NSMutableDictionary<NSString *, ForgeryFile *> *fileMap;

@end

NS_ASSUME_NONNULL_END
