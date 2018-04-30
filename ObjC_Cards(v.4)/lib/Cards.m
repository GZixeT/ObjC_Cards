//
//  Cards.m
//  ObjC_Cards(v.3)
//
//  Created by Георгий Зубков on 19.04.2018.
//  Copyright © 2018 Георгий Зубков. All rights reserved.
//

//Проба коммита 2
#import "Cards.h"

static Cards *uniqueInstance=nil;
@implementation Cards
@synthesize map;
@synthesize cardDeckNumber;
@synthesize height;
@synthesize firstCard;
+ (Cards*) sharedInstance{
    @synchronized(self)
    {
        if(uniqueInstance==nil)
            uniqueInstance=[[self alloc]init];
    }
    return uniqueInstance;
}
- (id) init{
    if(self=[super init])
    {
        map = [[NSMutableArray alloc]init];
        firstCard=-1;
    }
    else NSLog(@"Ошибка инициализации");
    return self;
}
- (BOOL) makeTaskWhithCardAtIndex:(NSInteger)index :(BOOL)isOpen
{
    if(index<[map count] && [map count]!=0)
    {
        Card *card= map[index];
        if([card open]!=isOpen){
            [card setOpen:isOpen];
            return true;
        }
        else NSLog(@"Действие над картой уже произведено");
    }
    else NSLog(@"Такой элемент не существует");
    return false;
}
- (NSMutableArray*) getOpenCards{
    NSMutableArray *openCards= [[NSMutableArray alloc]init];
    for(int i=0;i<[map count];i++){
        Card *card=[map objectAtIndex:i];
        if([card open])
            [openCards addObject:[NSNumber numberWithInteger:i]];
    }
    return openCards;
}
- (GameState) getGameState:(NSInteger)index{
    GameState state=GameStateFalse;
    if([[self getOpenCards]count]==[map count])
        return GameStateEnd;
    else if(firstCard!=-1)
    {
        if([map[firstCard] isEqual:map[index]])
            return GameStateTrue;
    }
    //добвить проверку на открытый элемент
    return state;
}
- (NSMutableArray*) copyArray:(NSMutableArray*)array
{
    NSMutableArray *copy=[[NSMutableArray alloc]init];
    for(int i=0;i<[array count];i++)
    {
        id tmp=[array objectAtIndex:i];
        [copy addObject:[tmp copy]];
    }
    return copy;
}
- (void) shuffleMapElements{ //private
    int index=0;
    id tmp;
    for(int i=0;i<[map count];i++)
    {
        index= (int)(arc4random() % (int) ([map count]-i) + i);
        tmp=map[i];
        [map replaceObjectAtIndex:i withObject:map[index]];
        [map replaceObjectAtIndex:index withObject:tmp];
    }
}
- (void) fillWithRandomCards{ //private
    for (int i = 0; i < cardDeckNumber; i++)
    {
        Card *randomCacrd = [Card createRandomCard];
        for (int j = 0; j < 2; j++)
            map[i*2+j] = [randomCacrd copy];
    }
    [self shuffleMapElements];
}
- (void)fillWithRandomCardsWithHeightAndNumber:(NSUInteger)height CardDeckNumber:(NSUInteger)number
{
    [self setHeight:height];
    [self setCardDeckNumber:number];
    [self fillWithRandomCards];
}
@end
