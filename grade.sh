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

head -n 2 test_results.txt > first.txt
tail -n 1 first.txt > line.txt
TESTS_RUN=`grep -c "." line.txt`
TESTS_FAILED=`grep -c "E" line.txt`
TESTS_PASSED=$(( $TESTS_RUN - $TESTS_FAILED ))

echo "You passed" $TESTS_PASSED / $TESTS_RUN "tests"
