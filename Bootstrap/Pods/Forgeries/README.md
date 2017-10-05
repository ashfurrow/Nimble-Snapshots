# Forgeries

[![Circle CI](https://circleci.com/gh/ashfurrow/Forgeries.svg?style=svg)](https://circleci.com/gh/ashfurrow/Forgeries)
![Forgeries Logo](https://cloud.githubusercontent.com/assets/49038/12582759/f6a2c294-c436-11e5-9ee1-aea3e7256240.jpg)

Forgeries is a library that makes unit testing iOS applications easier. UIKit has lots of limitations
that make sense in production code, but make testing difficult. Forgeries fixes that problem.

## Usage

Currently, the library provides testing replacements for:

- [Standard gesture recognizers](#gesture-recognizers)
- [NSUserDefaults](#user-defaults)
- [NSFileManager](#file-manager)
- [View trait collections](#trait-collections)
- [UIApplication](#uiapplication)


These can be used with [Dependency Injection](#dependency-injection), or by using OCMock to replace global singletons.

### Gesture Recognizers

The following are Forgeries' subclasses for gesture recognizers.

- ForgeryTapGestureRecognizer
- ForgeryPinchGestureRecognizer
- ForgeryRotationGestureRecognizer
- ForgerySwipeGestureRecognizer
- ForgeryPanGestureRecognizer
- ForgeryScreenEdgeGestureRecognizer
- ForgeryLongPressGestureRecognizer

These subclasses keep track of the number of times they've invoked their targets' actions; a handy interface to `UIGestureRecognizer` is provided:

```objc
@interface UIGestureRecognizer (Forgeries)

- (void)invoke;

@end
```

### User Defaults

`ForgeriesUserDefaults` is a class which is API compatible with NSUserDefaults. It has a few extra tools that make it useful for testing:

- A quick API `[ForgeriesUserDefaults defaults:@{}]` for setting up defaults from a dictionary
- APIs for inspecting the `lastSetKey`, `lastRequestedKey` and whether it has been synchronised via `hasSyncronised`
- Offers a subscripting interface so you can easily edit the defaults instance
- Can replace `[NSUserDefaults standardUserDefaults]` when OCMock is available in the test target

_Note this class isn't yet a subclass of NSUserDefaults, and so cannot be DI'd in to Swift classes._

### File Manager

`ForgeriesFileManager` is still new, so it's API is relatively limited as we find more use cases for it.

- A quick API for setting up defaults from a dictionary
  ``` objc
    ForgeriesFileManager *fm = [ForgeriesFileManager withFileStringMap:@{
         @"/docs/EchoTest.json" : @{ @"updated_at" : @"2001-01-23" },
         @"/app/EchoTest.json": @{ @"updated_at" : @"1985-01-23" },
		 @"/docs/VERSION" : @"1.0.1"
    }];
  ```

- This API will automatically convert dictionaries to raw JSON data, or let you create files with text
- Uses an in-memory store for file lookup, and accessing data. Faster, and won't change per-developer
- Is a subclass of NSFileManager, with functions it doesn't support raising exceptions. Help us add more functions.
- Can replace `[NSFileManager defaultManager]` when OCMock is available in the test target

### Trait Collections

You can stub the trait collections for `UIView` and `UIViewController`, the two `UITraitEnvironments` that we currently support.

```objc
[subject stubHorizontalSizeClass:UIUserInterfaceSizeClassRegular];
```

### UIApplication

Nothing to out of the normal here, you can create a `ForgeriesApplication` which is a UIApplication subclass for DI-ing a test. 

### Dependency Injection

The trick is to use Forgeries in _testing only_. A great way to do this is via _Dependency Injection_. This means injecting a dependency into an instance, instead of having that instance create the dependency itself, or access shared state. Let's take a look at an example.

Say you're testing `MyViewController`, you'd use lazy loading for your recognizer.

```objc
@interface MyViewController ()

@property (nonatomic, strong) UITapGestureRecognizer *recognizer;

@end

@implementation MyViewController

...

- (UITapGestureRecognizer *)recognizer {
	if (_recognizer == nil) {
		_recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureRecognizer:)];
	}

	return _recognizer;
}

...
```

What we need to do is set that property before it is lazily loaded. Here's our testing code:

```objc
MyViewController *subject = /* Instantiate somehow */
ForgeryTapGestureRecognizer *recognizer = [[ForgeryTapGestureRecognizer alloc] initWithTarget:subject action:@selector(handleGestureRecognizer:)];
subject.recognizer = recognizer;

/* Optionally, set the testing_location and testing_velocity properties on recognizer. */

[recognizer invoke];

expect(subject).to( /* have done something, whatever it is you're testing for */ );
```

If you're interested in dependency injection, we strongly recommend watching this [talk from Jon Reid](http://qualitycoding.org/dependency-injection/)

## Requirements

Requires iOS 7 or higher.

## Installation

Forgeries is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile under the _unit testing_ target:

```ruby
target 'MyApp_Tests' do
  inherit! :search_paths

  pod 'Forgeries'
  ...
end
```

That will import the core functionality, not including mock stuff. If you want to use Forgeries with OCMock, use the following instead:

```ruby
pod 'Forgeries/Mocks'
```

Now import the library in your unit tests.

```swift
import Forgeries
```

```objc
@import Forgeries;
// or #import <Forgeries/Forgeries.h>
```

## Authors

- Ash Furrow, ash@ashfurrow.com
- Orta Therox, orta.therox@gmail.com

## License

Forgeries is available under the MIT license. See the LICENSE file for more info.
