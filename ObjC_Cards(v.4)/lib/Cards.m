//
//  Cards.m
//  ObjC_Cards(v.3)
//
//  Created by Георгий Зубков on 19.04.2018.
//  Copyright © 2018 Георгий Зубков. All rights reserved.
//

//Проба коммита 2
#import "Cards.h"

#define TABLE_NO_ONE_CARD_OPEN 0
#define TABLE_ONE_CARD_OPEN 1
#define TABLE_TWO_CARDS_OPEN 2


static Cards *uniqueInstance=nil;
@implementation Cards
@synthesize map;
@synthesize tableOfStates;
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
- (void) initTableOfStates{
    NSNumber *option = [NSNumber numberWithInteger:TableOptionDisable];
    tableOfStates=[[NSMutableArray alloc]init];
    for(int i=0;i<cardDeckNumber*2;i++){
        [tableOfStates addObject:option];
    }
}
- (BOOL) makeTaskWithCardAtIndexInTableOfStates:(NSInteger)index :(BOOL)isOpen{
    if(index<[map count] && [map count]!=0)
    {
        TableOption option=[tableOfStates[index] intValue];
        if(option!=TableOptionLock)
        {
            Card *card= map[index];
            if([card open]!=isOpen)
            {
                [card setOpen:isOpen];
                if(isOpen)tableOfStates[index]=[NSNumber numberWithInteger:TableOptionEnable];
                else tableOfStates[index]=[NSNumber numberWithInteger:TableOptionDisable];
                return true;
            }else NSLog(@"Действие над картой уже произведено");
        }else NSLog(@"Доступ к элементу закрыт");
    }
    else NSLog(@"Такой элемент не существует");
    return false;
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
- (NSMutableArray *) getTableCellsWithTableOption:(TableOption)tableOption{
    NSMutableArray *tableCells=[[NSMutableArray alloc]init];
    for(int i=0;i<[tableOfStates count];i++){
        if([tableOfStates[i] intValue]==tableOption)
            [tableCells addObject:[NSNumber numberWithInt:i]];
    }
    return tableCells;
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
- (GameState) getGameStateWithTable{
    GameState state=GameStateFalse;
    NSInteger gameEndCount=[[self getTableCellsWithTableOption:TableOptionDisable]count];
    if(gameEndCount!=0)
    {
        NSMutableArray *enableCells = [self getTableCellsWithTableOption:TableOptionEnable];
        switch ([enableCells count]) {
            case TABLE_NO_ONE_CARD_OPEN:
                state=GameStateTrue;
                break;
            case TABLE_ONE_CARD_OPEN:
                state=GameStateTrue;
                break;
            case TABLE_TWO_CARDS_OPEN:
            {
                int firstCell=[enableCells[0]intValue];
                int secondCell=[enableCells[1]intValue];
                Card *first=map[firstCell];
                Card *second=map[secondCell];
                if(![first isEqual:second])
                {
                    tableOfStates[firstCell]=[NSNumber numberWithInt:TableOptionDisable];
                    tableOfStates[secondCell]=[NSNumber numberWithInt:TableOptionDisable];
                    [first setOpen:false];
                    [second setOpen:false];
                    state=GameStateFalse;
                }
                else{
                    tableOfStates[firstCell]=[NSNumber numberWithInt:TableOptionLock];
                    tableOfStates[secondCell]=[NSNumber numberWithInt:TableOptionLock];
                    state=GameStateTrue;
                }
            }break;//case 2 cards open
                
            default:
                NSLog(@"Error GameState func");
                break;
        }
    }else state=GameStateEnd;
    return state;
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
