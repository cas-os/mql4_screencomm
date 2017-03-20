//+------------------------------------------------------------------+
//|                                                   screencomm.mqh |
//|                                                               KO |
//+------------------------------------------------------------------+
#property copyright "Kazimierz Osinski"
#property description "kazimierz.osinski@gmail.com"
#property strict
#property version "1.00"

//---
//---


extern double myRiskAllowedPrcnt=1;
extern double myRisk=0;
extern double myReward=0;

//--- Zmienne kursora funkcji printComm() i printCommXY()
//--- 0,0 =  górny lewy narożnik
int commX=5;
int commY=15;
int commXYStep=18;
//--- Zmienne formatowania tekstu w funkcjach serii printComm...()
//---
int commFontSize=13;
string commFontName="Consolas";
int commFontColor=clrYellow;
int commClrPositive=clrGreen;
int commClrNegative=clrRed;
int commClrChange=clrYellow;


//---
//--- funkcja dashboard.
//---


void marketInfoDashboard()
   {
   double marketAsk, marketBid=0.0, marketSpread=0.0;
   string marketSymbol="Currency symbol...";
   string marketTimePeriod="Time Period...";
   double marketPips, marketSwap, marketMinLot, marketLotStep=0.0;
   double myBalance, myEquity, myProfit=0.0;
   
   double myRiskAllowedUSD=0;
   double myRiskAllowedPips=0;
   double marketDailyHigh, marketDailyLow=0.0;
   datetime marketLocalTime;
   
   
   
   marketPips = MarketInfo(Symbol(),MODE_TICKVALUE);
   marketDailyHigh=MarketInfo(Symbol(), MODE_HIGH);
   marketDailyLow=MarketInfo(Symbol(), MODE_LOW);
   marketLocalTime=TimeLocal();
   marketAsk=SymbolInfoDouble(Symbol(),SYMBOL_ASK);
   marketBid=SymbolInfoDouble(Symbol(),SYMBOL_BID);
   marketSpread=SymbolInfoInteger(Symbol(),SYMBOL_SPREAD);
   marketSymbol=SymbolInfoString(Symbol(),SYMBOL_DESCRIPTION);
   marketTimePeriod=IntegerToString(_Period);
   myBalance=AccountBalance();
   myEquity=AccountEquity();
   myProfit=AccountProfit();
   myRiskAllowedUSD=myRiskAllowedPrcnt*(myEquity/100);
   myRiskAllowedPips=myRiskAllowedUSD/marketPips;
   
   
   if (myProfit>=0)
      commClrChange=clrGreen;
   else
      commClrChange=clrRed;
   
//TextSetFont("Courier", 14, FW_BOLD, 0);

   printCommFt("marketLocalTime",   "Local time: "+TimeToString(marketLocalTime,TIME_DATE|TIME_SECONDS)+"   "+nameDayOfWeek(DayOfWeek()), 18, "Consolas", clrCyan);
   printCommClr("speratorDot0",   "__________________________________________________________", clrBlue);
   printCommClr("speratorEmpty0", "                                                          ", clrBlue);   
//   printCommClr("separatorDot1",        "..........................", clrBlue);   

   printCommFt("marketSymbol",marketSymbol+" :: "+marketTimePeriod, 18, "Consolas", clrOrange);
   
   printCommClr("separatorDot2",        "__________________________", clrBlue);
   printCommClr("speratorEmpty1",       "                          ", clrBlue);   
   printComm("marketAsk",           "Market ASK  :    "+DoubleToString(marketAsk, 5));
   printComm("marketSpread",        "    SPREAD  : "+DoubleToString(marketSpread, 2));
   printComm("marketBid",           "Market BID  :    "+DoubleToString(marketBid, 5));
   printComm("marketPips",          "USD/Pips    :  "+DoubleToString(marketPips, 2));
   printCommClr("seperatorDot3",         "__________________________", clrBlue);
   printCommClr("speratorEmpty2",        "                          ", clrBlue);   
   printCommClr("myBalance",         "Balance     : "+DoubleToString(myBalance,2), clrWhite);
   printCommClr("myEquity",          "Equity      : "+DoubleToString(myEquity,2), clrWhite);
   printCommClr("myProfit",          "Profit      : "+DoubleToString(myProfit,2), commClrChange);
   printCommClr("myRiskmyReward",    "R:R         : "+DoubleToString(myRisk,2)+"/"+DoubleToString(myReward,2), clrWhite);
   printCommClr("myRiskAllowedPrct", "Risk %      : "+DoubleToString(myRiskAllowedPrcnt,2) ,clrWhite);
   printCommClr("myRiskAllowedUSD",  "Risk $      : "+DoubleToString(myRiskAllowedUSD,2), clrWhite);
   printCommClr("myRiskAllowedPips", "Risk Pips   : "+DoubleToString(myRiskAllowedPips,2), clrWhite);
   printCommClr("myTakeProfit",      "Reward $    : "+DoubleToString(myReward*myRiskAllowedUSD,2), clrWhite);
   
   printCommClr("seperatorDot4",         "__________________________", clrBlue);   
   printCommClr("speratorEmpty3",        "                          ", clrBlue);   
   printComm("marketDayHigh",        "Daily High :  "+DoubleToString(marketDailyHigh, 5));   
   printComm("marketDayLow",         "Daily Low  :  "+DoubleToString(marketDailyLow, 5));   
   printCommClr("seperatorDot5",         "__________________________", clrBlue);      
   printCommClr("speratorEmpty4",        "                          ", clrBlue);   
     
   }

//-----------------------------------------------------------------------------------------------------------------
//--- funkcje wyświetlania komunikatów
//-----------------------------------------------------------------------------------------------------------------

//---
//--- printComm : wyświetla komunikat, lewy górny narożnik, czcionka = 10, odstęp Y = 15
//--- używa globalnego kursora i ustawień czcionki, koloru etc
//---
void printComm(string commLabel, string commMessage)
   {
   printCommFt(commLabel, commMessage, commFontSize, commFontName, commFontColor);
   }
//---
//--- printCommClr : formatowanie koloru
//---
void printCommClr(string commLabel, string commMessage, int commFontColorFt)
   {
   printCommFt(commLabel, commMessage, commFontSize, commFontName, commFontColorFt);
   }
//---
//--- printCommFt : formatowanie tekstu : font size, font name, color
//---
void printCommFt(string commLabel, string commMessage, int commFontSizeFt, string commFontNameFt, int commFontColorFt)
   {
   if(ObjectFind(commLabel)<0) //Obiekt nie został znaleziony
     {
      ObjectCreate(commLabel, OBJ_LABEL, 0, 0, 0 );
      ObjectSet(commLabel, OBJPROP_CORNER, 1);
      ObjectSet(commLabel, OBJPROP_XDISTANCE, commX);
      ObjectSet(commLabel, OBJPROP_YDISTANCE, commY+=15);
      ObjectSetInteger(0, commLabel, OBJPROP_BACK, false);
      ObjectSetText(commLabel, commMessage, commFontSizeFt, commFontNameFt, commFontColorFt);
     }
   else //Obiekt został znaleziony, aktualizacja ObjLabel
     {
      ObjectSetText(commLabel, commMessage, commFontSizeFt, commFontNameFt, commFontColorFt);   
     }
   }


//---
//--- Do przetestowania ustawienia obiektyu OBJ_TEXT
//---

void printCommText(string commLabel, string commMessage)
   {
   if(ObjectFind(commLabel)<0) //Obiekt nie został znaleziony
     {
      ObjectCreate(commLabel, OBJ_TEXT, 0, 0, 0 );
      ObjectSet(commLabel, OBJPROP_CORNER, 0);
      ObjectSet(commLabel, OBJPROP_XDISTANCE, commX);
      ObjectSet(commLabel, OBJPROP_YDISTANCE, commY+=commXYStep);
      ObjectSetInteger(0, commLabel, OBJPROP_BACK, false);
      ObjectSetText(commLabel, commMessage, commFontSize, commFontName, commFontColor);
     }
   else //Obiekt został znaleziony, aktualizacja ObjLabel
     {
      ObjectSetText(commLabel, commMessage, commFontSize, commFontName, commFontColor);   
     }
   }
   
string nameDayOfWeek(int myDayOfWeek)
   {
   switch(myDayOfWeek)
     {
      case 1:
         return("Monday");
         break;
      case 2:
         return("Tuesday");                  
         break;
      case 3:
         return("Wednesday");                  
         break;
      case 4:
         return("Thursday");                  
         break;
      case 5:
         return("Friday");                  
         break;
      case 6:
         return("Saturday");                  
         break;
      case 7:
         return("Sunday");                  
         break;
      default: 
         return("Holly Day!");
         break;
     }
     }     
