CPATH='.:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar'
CPATH2=".;../lib/hamcrest-core-1.3.jar;../lib/junit-4.13.2.jar"
rm -rf student-submission
git clone $1 student-submission 2>> git_clone.txt
echo 'Finished cloning'

cd student-submission
cp ../TestListExamples.java ./

if [[ ! -f ListExamples.java ]]
then
    echo "ListExamples.java does not exist"
    exit
fi

javac -cp $CPATH2 *.java 2>error.txt

if [[ $? != 0 ]]
then
    echo "Compilation failed"
    cat error.txt
    exit
fi

java -cp $CPATH2 org.junit.runner.JUnitCore TestListExamples > test_results.txt

tail -n 2 test_results.txt > last_line.txt
cut -d " " -f 3,6 last_line.txt > last_line_shorter.txt
TESTS_RUN=`cut -d "," -f 1 last_line_shorter.txt`
TESTS_FAILED=`cut -d "," -f 2 last_line_shorter.txt`
TESTS_PASSED=$(( $TESTS_RUN - $TESTS_FAILED ))

echo "You passed" $TESTS_PASSED / $TESTS_RUN "tests"
