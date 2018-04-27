//
//  GameConsoleInterface.m
//  ObjC_Cards(v.3)
//
//  Created by Георгий Зубков on 23.04.2018.
//  Copyright © 2018 Георгий Зубков. All rights reserved.
//

#import "GameConsoleInterface.h"

@implementation GameConsoleInterface
- (void) printCards{
    Cards *cards = [Cards sharedInstance];
    NSUInteger width;
    if([cards height]<[[cards map]count])
        width = [[cards map]count] / [cards height];
    else return;
    if(cards!=nil){
        if([cards map]!=nil)
        {
            int index=0;
            printf("----------\n");
            for(int i=0;i<[[cards map]count]/width;i++){
                for(int j=0;j<width;j++){
                    [self printOpenCardToConsole:
                     [cards getMapElementWithIndext:index]];
                    index++;
                }
                printf("\n");
            }
        }
        else NSLog(@"Карта еще не создана");
    }
    else NSLog(@"Ишра еще не создана");
}
- (void) printOpenCardToConsole:(Card*)card{
    //♠ ♣ ♥ ♦
    CardValue value=[card value];
    CardSuit suit=[card suit];
    if(![card open]){
        [self printClosedCardToConsole];
        return;
    }
    switch (value) {
        case CardValueAce:
            printf(" |A");
            break;
        case CardValueKing:
            printf(" |K");
            break;
        case CardValueQueen:
            printf(" |Q");
            break;
        case CardValueJack:
            printf(" |J");
            break;
        default:
            printf(" |%d",value);
            break;
    }
    switch (suit) {
        case CardSuitClubs:
            printf("♣| ");
            break;
        case CardSuitHeards:
            printf("♥| ");
            break;
        case CardSuitSpades:
            printf("♠| ");
            break;
        case CardSuitDiamonds:
            printf("♣| ");
            break;
    }
}
- (void) printClosedCardToConsole{
    printf(" |?&| ");
}
@end
