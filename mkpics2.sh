#!/bin/sh

# Variable to hold whether or not a column number is being passed in
colCheck=`echo $1 | grep -E ^[0-9]*$`

# Output the head, body, and create doctype tags
echo "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">"
echo "<html>"
echo "  <head>"
echo "    <title>Pictures</title>"
echo "  <head>"
echo "  <body>"
echo "    <h1>Pictures</h1>"
counter=0
# Check and make sure the directory is valid
if [ -d "$2"  -a ! -z "$colCheck" ];
then

# Var to hold column number
columnNum=$1

# Run a loop to go though each year directory 
for year in $2/*;
do	
	# Variable to hold whether or not a year directory
	yearChecker=`echo "$(basename "$year")" | grep -E ^[0-9]*$`
	# Run the loop if its year
	if [ ! -z "$yearChecker" ];
	then

	# Output the header with the year
	echo "<h2>$(basename "$year")</h2>"
	echo "<table>"
	# Run another loop to go through the months in each year directory
	for month in $year/*;
	do

		# Variable to hold whether or not a month directory
       		monthChecker=`echo "$(basename "$month")" | grep -E ^[0-9]*$`
       		# Run the loop if its month
       		if ! [ -z "$monthChecker" ];
	        then

		# Run another loop to go though each picture in the month directory
		for file in $month/*;
		do
		# If at the start of a column output "<tr>" tag
		if [ $counter -eq 0 ];
		then
		echo "  <tr>"
		fi
		# output the picture
		echo "    <td><img src=\""$file"\" height=100></td>"
		# Need an if statement that will check counter to determine the number of columns being created
                if [ $counter -eq `expr $columnNum - 1` ];
                then
			# End the column when reached desired number and reset the column var
                	echo "  </tr>"
			counter=0
		else
			# Else keep incrimenting the counter
			counter=`expr $counter + 1`
		fi
		done
		# Closing for month checker
		fi
	done
	# Check whether or not the closing tag is needed if there not enough pics to fill the column
                if [ $counter -ne 0 ];
                then
                echo "  </tr>"
                counter=0
                fi
        # Output closing tag for table
        echo "</table>"

	# Closing for year checker
	fi

# Outer Loop
done
fi

# Output if there isnt a valid directory being passed in
if [ -z "$colCheck" ];
then
	>&2 echo "\""$1"\" : is not a valid integer value for column numbers!"
# Output if there isnt a valid columnnumber being passed in
elif ! [ -d "$2" ];
then
	>&2 echo "\""$2"\" : is not a valid directory!"
fi

# Output the closing tags
echo "</body>"
echo "</html>"

