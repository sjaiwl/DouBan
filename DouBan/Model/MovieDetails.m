//
//  MovieDetails.m
//  DouBan
//
//  Created by lanou3g on 15/8/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MovieDetails.h"

@implementation MovieDetails

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@",_movieid,_rating,_genres,_runtime,_title,_poster,_rating_count,_plot_simple,_country,_release_date,_actors];
}
@end
