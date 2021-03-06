//
//  ChartDocsCandlestick.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "ChartDocsCandlestick.h"

@implementation ChartDocsCandlestick
{
    TKChart *chart;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    chart.delegate = self;
    // >> chart-candlestick
    NSArray *openPrices = @[@100, @125, @69, @99, @140, @125];
    NSArray *closePrices = @[@85, @65, @135, @120, @80, @136];
    NSArray *lowPrices = @[@50, @60, @65, @55, @75, @90];
    NSArray *highPrices = @[@129, @142, @141, @123, @150, @161];
    NSDate *dateNow = [NSDate date];
    NSMutableArray *financialDataPoints = [[NSMutableArray alloc] init];
    for (int i = 0; i < openPrices.count; i++) {
        NSDate *date = [dateNow dateByAddingTimeInterval:60 * 60 * 24 * i];
        TKChartFinancialDataPoint *dataPoint = [TKChartFinancialDataPoint dataPointWithX:date open:openPrices[i] high:highPrices[i] low:lowPrices[i] close:closePrices[i]];
        [financialDataPoints addObject:dataPoint];
    }
    
    TKChartCandlestickSeries *candlestickSeries = [[TKChartCandlestickSeries alloc] initWithItems:financialDataPoints];
    [chart addSeries:candlestickSeries];
    TKChartDateTimeAxis *xAxis = (TKChartDateTimeAxis *)chart.xAxis;
    xAxis.minorTickIntervalUnit = TKChartDateTimeAxisIntervalUnitDays;
    xAxis.plotMode = TKChartAxisPlotModeBetweenTicks;
    xAxis.majorTickInterval = 1;
    // << chart-candlestick
}

// >> chart-candlestick-visual
- (TKChartPaletteItem *)chart:(TKChart *)chart paletteItemForSeries:(TKChartSeries *)series atIndex:(NSInteger)index
{
    id<TKChartData> dataPoint = [series dataPointAtIndex:index];
    TKStroke *stroke = [TKStroke strokeWithColor:[UIColor blackColor]];
    TKSolidFill *fill;
    if ([dataPoint.close doubleValue] < [dataPoint.open doubleValue]) {
        fill = [TKSolidFill solidFillWithColor:[UIColor redColor]];
    } else {
        fill = [TKSolidFill solidFillWithColor:[UIColor greenColor]];
    }
    
    TKChartPaletteItem *paletteItem = [TKChartPaletteItem paletteItemWithStroke:stroke andFill:fill];
    return paletteItem;
}
// << chart-candlestick-visual

@end
