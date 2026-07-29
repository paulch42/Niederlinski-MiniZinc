% use COIN-BC solver

int: num_books;
set of int: BOOK = 1..num_books;
int: max_production;
type book = record(int: demand, int: variable_cost, int: sales_price, int: fixed_cost);

array[BOOK] of book: book_info;

int: max_demand = max([book_info[b].demand | b in BOOK]);

constraint(forall(b in BOOK)(assert(book_info[b].demand >= 0, "Demand for book \(b) is negative")));
constraint(forall(b in BOOK)(assert(book_info[b].variable_cost >= 0, "Variable cost for book \(b) is negative")));
constraint(forall(b in BOOK)(assert(book_info[b].sales_price >= 0, "Sales price for book \(b) is negative")));
constraint(forall(b in BOOK)(assert(book_info[b].fixed_cost >= 0, "Fixed cost for book \(b) is negative")));

array[BOOK] of var 0..max_demand: produce;

constraint forall(b in BOOK)(produce[b] <= book_info[b].demand);
constraint sum(produce) <= max_production;

var int: profit = sum(b in BOOK)(produce[b] * (book_info[b].sales_price - book_info[b].variable_cost) - ((produce[b] > 0) * book_info[b].fixed_cost * 1000));

constraint profit >= 0;

solve maximize profit;