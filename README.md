# MEGATree
Objective-C AVLTree implementation

#### Use

```objective-c
  MEGATree *tree = [[MEGATree alloc] init];
  
  //insert key-value pairs - log(n) time
  [tree push:@"someKey" value:someValue];
  
  //perform lookups - log(n) time
  id value = [tree get:@"someKey"];
  
  //check for items  - log(n) time
  if([tree contains:@"someKey"]) NSLog(@"FOUND");
  //equivalent check [tree get:@"someKey"] != nil
  
  //remove items  - log(n) time
  [tree remove:@"someKey"];
  
  //sort data  - n time
  NSArray *sortedData = [tree orderedArray];
```

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like MEGATree in your projects. See the ["Getting Started" guide for more information](http://guides.cocoapods.org/using/getting-started.html).

#### Podfile

```ruby
platform :ios, '7.0'
pod "MEGATree", "~> 1.0"
```

#### Wiki
In computer science, an AVL tree (Georgy Adelson-Velsky and Evgenii Mikhailovich Landis' tree, named after the inventors) is a self-balancing binary search tree. It was the first such data structure to be invented. Read more on ["Wikipedia!](http://en.wikipedia.org/wiki/AVL_tree)

#### Keywords
MEGATree, AVLTree, Objective-C, Balanced Binary Search Tree, BST

#### Naming
The name AVLTree was taken (╯°□°）╯︵ ┻━┻). As AVLTree was, MEGATree is also named after it's original creators, Mikhailovich Evgenii and Georgy Adelson

