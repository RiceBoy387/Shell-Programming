#!/bin/sh

# Add pathway for the exiftime to path variable 
PATH=$PATH:/courses/courses/cscb09s18/bin

# Check if the given directory is valid or not
if [ -d $1 ];
then
# Use a loop to go through the years in the given  directory 
for file in $1/*;
do
	# Check if the file is a jpeg file
	if [ `file -b "$file" | cut -f 1 -d ' '` = "JPEG" ];
        then
	# Need to get the year of the picture
	year=`exiftime -tg "$file" | cut -d" " -f 3 | cut -d ":" -f 1` 2> /dev/null
	# Need to get the month of the picture
        month=`exiftime -tg "$file" | cut -d" " -f 3 | cut -d ":" -f 2` 2> /dev/null
		# Check if ther is a time stamp or not
		chars=`echo $year | wc -m`
		if  [ $chars -eq 5 ];
		then
  			# Need to check if there is an already existing directory for the year
			directory=`pwd`
			# If the current directory doesnt exist create it and move the picture
			if ! [ -d ${directory}/$year ];
			then
				# Create the year directory
				mkdir $directory/$year
				# Get the new directory which has the year
				new_directory=$directory/$year
				# Create the month directory
				mkdir $new_directory/$month
				# Move the picture into the new directory
				mv "$file" "$directory/$year/$month"
			else
				# Get the new directory which has the year
                                new_directory=$directory/$year
				# Check whether or not the month directory already exists
				if ! [ -d ${new_directory}/$month ];
				then
				# If the month directory doesn't exist create it and move the picture
                                mkdir $new_directory/$month
                                # Move the picture into the new directory
                                mv "$file" "$directory/$year/$month"
				# If the month directory already exists just move the picture
				else
				mv "$file" "$new_directory/$month"
				fi
			fi
		# Case when the file does not have a time stamp output an error
		else
			>&2 echo "\"$(basename "$file")\" : does not have a timestamp!"
		fi
	# Output an error when the file in
	else
		>&2 echo "\"$(basename "$file")\" : is not a JPEG file!" 
	fi
done
# Output if the given directory is not valid
else
	>&2 echo "\""$1"\" : is not a valid directory!"

fi
