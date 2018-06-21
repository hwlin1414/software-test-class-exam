all: exam

GCOVFLAGS += -fprofile-arcs -ftest-coverage

ASANFLAGS += -fsanitize=address

exam: main.cpp
	g++ $(ASANFLAGS) $(GCOVFLAGS) main.cpp -o exam

test: exam
	echo "abc" | ./exam

gcov:
	gcov main.cpp

exam-afl: main.cpp
	afl-g++ main.cpp -o exam-afl

fuzz: exam-afl
	afl-fuzz -i testcase/ -o fuzz_output/ ./exam-afl

clean:
	rm exam exam-afl *.gcov *.gcda *.gcno
