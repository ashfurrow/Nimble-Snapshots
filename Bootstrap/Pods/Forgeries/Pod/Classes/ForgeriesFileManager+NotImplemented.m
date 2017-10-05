#import "ForgeriesFileManager.h"
#import "Forgeries-Macros.h"

@interface ForgeriesFileManager(NotImplemented)
@end

@implementation ForgeriesFileManager (NotImplemented)

- (nullable NSArray<NSURL *> *)mountedVolumeURLsIncludingResourceValuesForKeys:(nullable NSArray<NSString *> *)propertyKeys options:(NSVolumeEnumerationOptions)options { NotYetImplmented; }

- (void)unmountVolumeAtURL:(NSURL *)url options:(NSFileManagerUnmountOptions)mask completionHandler:(void (^)(NSError * __nullable errorOrNil))completionHandler { NotYetImplmented; };

- (nullable NSArray<NSURL *> *)contentsOfDirectoryAtURL:(NSURL *)url includingPropertiesForKeys:(nullable NSArray<NSString *> *)keys options:(NSDirectoryEnumerationOptions)mask error:(NSError **)error { NotYetImplmented; };


- (nullable NSURL *)URLForDirectory:(NSSearchPathDirectory)directory inDomain:(NSSearchPathDomainMask)domain appropriateForURL:(nullable NSURL *)url create:(BOOL)shouldCreate error:(NSError **)error { NotYetImplmented; }

- (BOOL)getRelationship:(NSURLRelationship *)outRelationship ofDirectoryAtURL:(NSURL *)directoryURL toItemAtURL:(NSURL *)otherURL error:(NSError **)error { NotYetImplmented; }

- (BOOL)getRelationship:(NSURLRelationship *)outRelationship ofDirectory:(NSSearchPathDirectory)directory inDomain:(NSSearchPathDomainMask)domainMask toItemAtURL:(NSURL *)url error:(NSError **)error { NotYetImplmented; }

- (BOOL)createDirectoryAtURL:(NSURL *)url withIntermediateDirectories:(BOOL)createIntermediates attributes:(nullable NSDictionary<NSString *, id> *)attributes error:(NSError **)error { NotYetImplmented; }

- (BOOL)createSymbolicLinkAtURL:(NSURL *)url withDestinationURL:(NSURL *)destURL error:(NSError **)error { NotYetImplmented; }

- (BOOL)setAttributes:(NSDictionary<NSString *, id> *)attributes ofItemAtPath:(NSString *)path error:(NSError **)error { NotYetImplmented; }

- (BOOL)createDirectoryAtPath:(NSString *)path withIntermediateDirectories:(BOOL)createIntermediates attributes:(nullable NSDictionary<NSString *, id> *)attributes error:(NSError **)error { NotYetImplmented; }

- (nullable NSArray<NSString *> *)contentsOfDirectoryAtPath:(NSString *)path error:(NSError **)error { NotYetImplmented; }

- (nullable NSArray<NSString *> *)subpathsOfDirectoryAtPath:(NSString *)path error:(NSError **)error { NotYetImplmented; }

- (nullable NSDictionary<NSString *, id> *)attributesOfItemAtPath:(NSString *)path error:(NSError **)error { NotYetImplmented; }

- (nullable NSDictionary<NSString *, id> *)attributesOfFileSystemForPath:(NSString *)path error:(NSError **)error { NotYetImplmented; }


- (BOOL)createSymbolicLinkAtPath:(NSString *)path withDestinationPath:(NSString *)destPath error:(NSError **)error { NotYetImplmented; }

- (nullable NSString *)destinationOfSymbolicLinkAtPath:(NSString *)path error:(NSError **)error { NotYetImplmented; }

- (BOOL)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error { NotYetImplmented; }
- (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error { NotYetImplmented; }
- (BOOL)linkItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error { NotYetImplmented; }
- (BOOL)removeItemAtPath:(NSString *)path error:(NSError **)error { NotYetImplmented; }

- (BOOL)copyItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL error:(NSError **)error { NotYetImplmented; }
- (BOOL)moveItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL error:(NSError **)error { NotYetImplmented; }
- (BOOL)linkItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL error:(NSError **)error { NotYetImplmented; }
- (BOOL)removeItemAtURL:(NSURL *)URL error:(NSError **)error { NotYetImplmented; }


- (BOOL)trashItemAtURL:(NSURL *)url resultingItemURL:(NSURL * __nullable * __nullable)outResultingURL error:(NSError **)error { NotYetImplmented; }


- (BOOL)changeCurrentDirectoryPath:(NSString *)path { NotYetImplmented; }


- (BOOL)fileExistsAtPath:(NSString *)path isDirectory:(nullable BOOL *)isDirectory { NotYetImplmented; }
- (BOOL)isReadableFileAtPath:(NSString *)path { NotYetImplmented; }
- (BOOL)isWritableFileAtPath:(NSString *)path { NotYetImplmented; }
- (BOOL)isExecutableFileAtPath:(NSString *)path { NotYetImplmented; }
- (BOOL)isDeletableFileAtPath:(NSString *)path { NotYetImplmented; }

- (BOOL)contentsEqualAtPath:(NSString *)path1 andPath:(NSString *)path2 { NotYetImplmented; }

- (NSString *)displayNameAtPath:(NSString *)path { NotYetImplmented; }

- (nullable NSArray<NSString *> *)componentsToDisplayForPath:(NSString *)path { NotYetImplmented; }

- (nullable NSDirectoryEnumerator<NSString *> *)enumeratorAtPath:(NSString *)path { NotYetImplmented; }

- (nullable NSDirectoryEnumerator<NSURL *> *)enumeratorAtURL:(NSURL *)url includingPropertiesForKeys:(nullable NSArray<NSString *> *)keys options:(NSDirectoryEnumerationOptions)mask errorHandler:(nullable BOOL (^)(NSURL *url, NSError *error))handler { NotYetImplmented; }

- (nullable NSArray<NSString *> *)subpathsAtPath:(NSString *)path { NotYetImplmented; }

- (BOOL)createFileAtPath:(NSString *)path contents:(nullable NSData *)data attributes:(nullable NSDictionary<NSString *, id> *)attr { NotYetImplmented; }

- (const char *)fileSystemRepresentationWithPath:(NSString *)path { NotYetImplmented; }

- (NSString *)stringWithFileSystemRepresentation:(const char *)str length:(NSUInteger)len { NotYetImplmented; }


- (BOOL)replaceItemAtURL:(NSURL *)originalItemURL withItemAtURL:(NSURL *)newItemURL backupItemName:(nullable NSString *)backupItemName options:(NSFileManagerItemReplacementOptions)options resultingItemURL:(NSURL * __nullable * __nullable)resultingURL error:(NSError **)error { NotYetImplmented; }

- (BOOL)setUbiquitous:(BOOL)flag itemAtURL:(NSURL *)url destinationURL:(NSURL *)destinationURL error:(NSError **)error { NotYetImplmented; }

- (BOOL)isUbiquitousItemAtURL:(NSURL *)url { NotYetImplmented; }

- (BOOL)startDownloadingUbiquitousItemAtURL:(NSURL *)url error:(NSError **)error { NotYetImplmented; }

- (BOOL)evictUbiquitousItemAtURL:(NSURL *)url error:(NSError **)error { NotYetImplmented; }

- (nullable NSURL *)URLForUbiquityContainerIdentifier:(nullable NSString *)containerIdentifier { NotYetImplmented; }

- (nullable NSURL *)URLForPublishingUbiquitousItemAtURL:(NSURL *)url expirationDate:(NSDate * __nullable * __nullable)outDate error:(NSError **)error { NotYetImplmented; }


- (nullable NSURL *)containerURLForSecurityApplicationGroupIdentifier:(NSString *)groupIdentifier { NotYetImplmented; }



@end
