
crm : lex.yy.o y.tab.o data.o
	gcc -o $@ $^

lex.yy.o : lex.yy.c y.tab.h
	gcc -c -o $@ $<

y.tab.o : y.tab.c
	gcc -c -o $@ $^

data.o : data.c
	gcc -c -o $@ $^

lex.yy.c : flex_in.l
	flex $^

y.tab.c y.tab.h: yacc_in.y
	yacc -dv $^

.PHONY : clean test
clean :
	rm -fv -- y.tab.* y.output lex.yy.* data.o crm

test : crm
	./crm < tests/test_simple_substances
	./crm < tests/test_simple_compounds
	./crm < tests/test_hydrates
	./crm < tests/test_complex_compounds

