#!/bin/sh

# Variable to check if the first argument is not a integer
colCheck=`echo $1 | grep -E ^[0-9]*$`


# Output the head, body, and create doctype tags
echo "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">"
echo "<html>"
echo "  <head>"
echo "    <title>Pictures</title>"
echo "  <head>"
echo "  <body>"
echo "    <h1>Pictures</h1>"
echo "<table>"

# If statememt to make sure that the script doesn't start the loop if there isn't a valid column parameter 
if [ -n "$colCheck" ];
then

# Var to hold column number
columnNum=$1

# Run a nested loop to create the table
# Will run so long as their is still a paramter and the last parameter is a jpg
while [ ! -z "$2" ]
do
	echo "  <tr>"
	# Inside loop to get the columns
	j=0
	# Will run so long as their are more columns to fill and pics left to place
	while [ $j -lt $columnNum -a ! -z "$2" ]
	do
		# Only use them if its a jpg or jpeg
		if [ `file -b "$2" | cut -f 1 -d ' '` = "JPEG" ];
		then
			echo "      <td><img src=\""$2"\" height=100></td>"
		else
			>&2 echo "      \""$2"\" : Is not a JPEG File!"
		fi
	j=`expr $j + 1`
	# Shift the arguments so we can get the next one
	shift
	done
# Outer Loop
echo "  </tr>"
done

# When there isn't a valid column number given output the error
else
	>&2 echo "\""$1"\" : is not a valid integer value for column numbers!"
fi

# Output the closing tags
echo "</table>"
echo "</body>"
echo "</html>"


