#property copyright "y"
#property link      ""
#property version   "1.00"
#property strict

//--- input parameters
input int tp = 50;
input int sl = 25;

int OnInit() { return(INIT_SUCCEEDED); }
void OnDeinit(const int reason){}
void OnTick() {
   for(int i = OrdersTotal() - 1; i >= 0; i--){
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES) == true) {
         if(OrderSymbol() != Symbol()) continue;
         double tp_price, sl_price;
         tp_price = NormalizeDouble(OrderOpenPrice() + (OrderType() == OP_BUY? tp : -tp) * _Point, _Digits);
         sl_price = NormalizeDouble(OrderOpenPrice() + (OrderType() == OP_BUY? -sl : sl) * _Point, _Digits);
         if(OrderTakeProfit() != tp_price || OrderStopLoss() != sl_price) {
            long ticket = OrderTicket();
            OrderModify(ticket, _Symbol, sl_price, tp_price, 0, clrNONE);
         }
      }
   }
}
