#import "Forgeries-Macros.h"
#import "ForgeriesFileManager.h"

@implementation ForgeryFile

- (NSURL *)urlRepresentation
{
    return [NSURL fileURLWithPath:self.path];
}

@end

@implementation ForgeriesFileManager

+ (instancetype)withFileStringMap:(NSDictionary <NSString *, id>*)dictionary
{
    ForgeriesFileManager *fileManager = [[ForgeriesFileManager alloc] init];

    NSMutableDictionary *fileMap = [NSMutableDictionary dictionary];
    for (NSString *key in dictionary.allKeys) {
        ForgeryFile *file = [[ForgeryFile alloc] init];
        file.path = key;
        id object = dictionary[key];

        if ([object isKindOfClass:NSString.class]) {
            file.data = [object dataUsingEncoding:NSUTF8StringEncoding];
        } else if ([object isKindOfClass:NSDictionary.class]) {
            file.data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
        }

        fileMap[key] = file;
    }
    fileManager.fileMap = fileMap;
    return fileManager;
}

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;

    _fileMap = [NSMutableDictionary dictionary];

    return self;
}

# pragma mark - Some Mapping functions

- (NSArray<ForgeryFile *> *)filesMatchingPath:(NSString *)string
{
    NSMutableArray<ForgeryFile *> *files = [NSMutableArray array];
    for (NSString *path in self.fileMap.allKeys) {
        if ([path hasPrefix:[self shorthandForFilePath:string]]) {
            [files addObject:self.fileMap[path]];
        }
    }
    return files;
}

- (NSArray<NSURL *> *)urlsForFiles:(NSArray<ForgeryFile *> *)files
{
    NSMutableArray<NSURL *> *urls = [NSMutableArray array];
    for (ForgeryFile *file in files) {
        [urls addObject:file.urlRepresentation];
    }
    return urls;
}

# pragma mark - Shorthand support

- (NSString *)shorthandForFilePath:(NSString *)filepath
{
    NSString *appPath = [[NSBundle mainBundle] bundlePath];
    filepath = [filepath stringByReplacingOccurrencesOfString:appPath withString:@"/app"];
    return filepath;
}

- (NSString *)shorthandForSearchPathDirectory:(NSSearchPathDirectory)directory
{
    switch (directory) {
        case NSDocumentDirectory:
            return @"/docs/";
        default:
            NotYetImplmented;
    }
}

#pragma mark - Custom NSFileManager Overrides

- (NSArray<NSURL *> *)URLsForDirectory:(NSSearchPathDirectory)directory inDomains:(NSSearchPathDomainMask)domainMask
{
    NSString *path = [self shorthandForSearchPathDirectory:directory];
    return @[[NSURL fileURLWithPath:path]];
}

- (BOOL)fileExistsAtPath:(NSString *)path
{
    return [self filesMatchingPath:path].count > 0;
}

- (nullable NSData *)contentsAtPath:(NSString *)path
{
    ForgeryFile *file = [self filesMatchingPath:path].firstObject;
    return  [file data];
}
@end
