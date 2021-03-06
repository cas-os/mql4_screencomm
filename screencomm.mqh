//+------------------------------------------------------------------+
//|                                                   screencomm.mqh |
//|                                                               KO |
//|                                       kazimierz.osinski@gmail.com|
//|                                                 mql4dev@gmail.com|
//+------------------------------------------------------------------+
#property copyright "Kazimierz Osinski"
#property description "kazimierz.osinski@gmail.com"
#property strict
#property version "1.00"

//---
//---
//--- Zmienne kursora funkcji printComm() i printCommXY()
//--- 0,0 =  górny lewy narożnik
int commX=5;
int commY=15;
int commXYStep=18;
//--- Zmienne formatowania tekstu w funkcjach serii printComm...()
//---
int commFontSize=9;
string commFontName="Consolas";
int commFontColor=clrBlue;
int commClrPositive=clrGreen;
int commClrNegative=clrRed;
int commClrChange=clrYellow;




//-----------------------------------------------------------------------------------------------------------------
//--- funkcje wyświetlania komunikatów
//-----------------------------------------------------------------------------------------------------------------

void screenCommInit()
   {
   commX=5;
   commY=15;
   commXYStep=18;   
   }

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
   
