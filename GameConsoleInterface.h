//
//  GameConsoleInterface.h
//  ObjC_Cards(v.3)
//
//  Created by Георгий Зубков on 23.04.2018.
//  Copyright © 2018 Георгий Зубков. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cards.h"

@interface GameConsoleInterface : NSObject
- (void) printCards:(Cards*)cards;
- (void) printOpenCardToConsole:(Card*)card;
- (void) printClosedCardToConsole;
@end
