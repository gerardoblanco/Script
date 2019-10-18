echo "1.Access a Repository"
echo "2.Create a new Repository"
echo "3.View Log file"
echo "4.Exit"
function moveToDir {

	int=0
	while [ $int=0 ]
	do
		echo $(pwd)
		echo "Is this the directory in which you want to work in?"
		echo "For Yes- 1"
		echo "For No- 0"
		echo $'\n'
		read int
		
		if [ $int -eq 1 ]
		then
		break

		elif [ $int -eq 0 ]
		then
	    echo "To travel up a directory- 1"
		echo "To travel down a directory- 0"
		read int
			if [ $int -eq 1 ]
			then
			cd ..
			int=0
			elif [ $int -eq 0 ]
			then
			ls -d */
			echo "Please enter the repository from the list you would like to access"
			read repoInput
			cd $repoInput
			int=0	
			echo $'\n'
			fi
		fi
	done
}
function accessRepository {
	ls -d */
	echo "Please enter the repository from the list you would like to access"
	read repoInput
	cd $repoInput
	echo "The current files in this repository are:"
	ls 
	accessRepoOptions
	
}
function logFile {
		echo "Select the file you would like to log without including any file extensions"
		ls
		read fileName
		filePath=$(pwd)
		echo "Select the repo you would like to log the file into"
		moveToDir		
		dirPath=$(pwd)	
		ls -d */
		read repoName
		mv $filePath"/"$fileName.txt $repoName
		accessRepoOptions
}
function viewBackups {
		find . -name "*backUp*" -print
		echo "Please enter the name of the file from the list that you would like to view without including any file extensions"
		read backupFilename
		vi $backupFilename.txt
		accessRepoOptions
}
function editFile {
	ls
	echo "Please enter the name of the file you wish to edit without including any file extensions"
	read fileToEdit
	cp -a  $fileToEdit backUp$fileToEdit.txt
	vi $fileToEdit.txt
	accessRepoOptions
}
function createNewfile {
    echo "Please enter a file name without incuding any file extensions "
	read newFileName
	touch $newFileName.txt
	echo "$newFileName.txt created!"
	accessRepoOptions

}
function zipunzip {
        echo "press 1 if you want to zip"
        echo "press 2 if you want to unzip"
        read choice
        if [ $choice -eq 1 ]
        then
            echo "Enter the name of the directory you want to zip"
            ls -d */
            read folderToZip
            zip $folderToZip.zip -r $folderToZip
        elif [ $choice -eq 2 ]
        then
            echo "Enter the name of the zipfile you want to unzip"
            ls
            read folderToUnzip
            mkdir $folderToUnzip.unzipped
            unzip $folderToUnzip -d /
        fi   
    accessRepoOptions 
}

function compile {
	echo -e "\nThis are the files within the directory:\n"
	ls | cat
	echo -e "\nPlease enter the name of the file you want to compile: "
	read fileToCompile
	gcc $fileToCompile -o $fileToCompile.compiled
	echo "The file $fileToCompile.compiled has been compiled succefully"
	accessRepoOptions
}
function delete {
	ls
	echo "Please enter the name of the file you wish to delete"
	read fileToDelete
	rm $fileToDelete
	accessRepoOptions
}
function accessRepoOptions {
	echo $'\n'
	moveToDir
	echo $'\n'
	echo "1:Would you like to Create a new file:"
	echo "2:Edit an exisiting file "
	echo "3:View backups"
	echo "4:Log a file into the repo"
	echo "5:zipunzip"
	echo "6:compile"
	echo "7:delete"
	echo $'\n'
	read repoMenuInput
	if [ $repoMenuInput -eq 1 ]
	then
		createNewfile
	elif [ $repoMenuInput -eq 2 ]
	then
		editFile
    elif [ $repoMenuInput -eq 3 ]
	then
		viewBackups
    elif [ $repoMenuInput -eq 4 ]
	then
		logFile
    elif [ $repoMenuInput -eq 5 ]
	then
        zipunzip
	elif [ $repoMenuInput -eq 6 ]
	then
        compile
    elif [ $repoMenuInput -eq 6 ]
	then
        delete
fi
}
function newRepo {
	echo "Please enter the name of the new repository"
	read newRepoName
	mkdir $newRepoName
	ls
}
read -p "Please enter a number: " menuInput 
if [ $menuInput -eq 1 ]
	then
	       	accessRepository 
	elif [ $menuInput -eq 2 ]
then 
	newRepo


	else
	        echo "it hasnt 😞"	
	fi