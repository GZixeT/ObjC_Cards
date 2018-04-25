//
//  Card.h
//  ObjC_Cards(v.3)
//
//  Created by Георгий Зубков on 19.04.2018.
//  Copyright © 2018 Георгий Зубков. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CardValueTwo,
    CardValueThree,
    CardValueFour,
    CardValueFive,
    CardValueSix,
    CardValueSeven,
    CardValueEight,
    CardValueNine,
    CardValueJack,    //валет
    CardValueQueen,   //королева
    CardValueKing,    //король
    CardValueAce      //туз
}CardValue;

typedef enum{
    CardSuitDiamonds,   //бубны
    CardSuitHeards,     //червы
    CardSuitSpades,     //пики
    CardSuitClubs       //трефы
}CardSuit;

@interface Card: NSObject
@property CardValue value;
@property CardSuit suit;
@property BOOL open;
+ (id) createRandomCard;
- (id) copy;
- (BOOL) isEqual:(id)object;
- (NSMutableArray*) getRandomArray:(NSInteger)count;
@end
