//
//  Map.h
//  ObjC_Cards(v.3)
//
//  Created by Георгий Зубков on 19.04.2018.
//  Copyright © 2018 Георгий Зубков. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Map : NSObject{
    NSMutableArray *_map;
}
@property NSInteger width;
@property NSInteger height;
- (NSInteger) getPerimeter;
- (void) addMapElement:(id)element;
- (id) getMapElementWithIndext:(NSInteger)index;
- (NSMutableArray*) getMap;
- (void) addArray:(NSMutableArray*)array;
- (void) shuffleElements;
@end
