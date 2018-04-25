//
//  Map.m
//  ObjC_Cards(v.3)
//
//  Created by Георгий Зубков on 19.04.2018.
//  Copyright © 2018 Георгий Зубков. All rights reserved.
//

#import "Map.h"

@implementation Map
@synthesize width;
@synthesize height;
- (NSInteger) getPerimeter{
    return width*height;
}
- (void) addMapElement:(id)element{
    if(_map!=nil){
        if([_map count]<[self getPerimeter])
            [_map addObject:element];
        else NSLog(@"Ошибка.Переполнение карты!");
    }
    else{
        if([self getPerimeter]>0)
            _map = [_map initWithObjects:element, nil];
        else NSLog(@"Не заполнены параметры карты");
    }
}
- (id) getMapElementWithIndext:(NSInteger)index{
    if(_map==nil){
        NSLog(@"Карта еще не создана");
        return false;
    }
    return [_map objectAtIndex:index];
}
- (NSMutableArray*) getMap{
    if(_map==nil){
        NSLog(@"Карта еще не создана");
        return false;
    }
    return _map;
}
-(void) addArray:(NSMutableArray *)array{
    if(array!=nil)
    {
        if(_map!=nil){
            [_map addObjectsFromArray:[array copy]];
        }
        else
            _map = [[NSMutableArray alloc]initWithArray:[array copy]];
    }else
        NSLog(@"Массив элементов пуст");
}
- (void) shuffleElements{
    if(_map!=nil){
        int index=0;
        id tmp;
        for(int i=0;i<[self getPerimeter];i++){
            index= (int)(arc4random() % (int) ([self getPerimeter]-i) + i);
            tmp=[self getMapElementWithIndext:i];
            [_map replaceObjectAtIndex:i withObject:[self getMapElementWithIndext:index]];
            [_map replaceObjectAtIndex:index withObject:tmp];
        }
    }
    else NSLog(@"Карта еще не создана");
}
@end
