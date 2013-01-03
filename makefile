all :
	yacc -v -d -t projet.y
	flex projet.l
	gcc *.c -lfl -o main
clean : 
	rm y.*
	rm lex.*
	rm main
