#!/bin/bash

#Aim    : To get count of Mantra
#Author : Sakthy Vel Thirumurthy kumar
#Editor: Sakthy Vel Thirumurthy kumar
#Change: 
#Version: 1.0
#DoC    : 05-06-2024

# Configuration
DIRECTORY="/a02/informa_shared/sourcefile/Mantra_Prod/output/processed/"
RECIPIENTS="geetha.arularasu@external.merckgroup.com,nivedha.rajendiran@external.merckgroup.com, sakthy-vel.thirumurthy-kumar@external.merckgroup.com, vijayalakshmi.munnaluru@external.merckgroup.com, vignesh.ravi@external.merckgroup.com, ravali.puppala@external.merckgroup.com, matrs.automatedbot@merckgroup.com, sarath-babu.elaiyappan@external.merckgroup.com, R109507@merckgroup.com"
LOGFILE="/var/LMS/logfile.log"
RECIPIENTS1="R109576@merckgroup.com, R109567@merckgroup.com, geetha.arularasu@external.merckgroup.com,nivedha.rajendiran@external.merckgroup.com, sakthy-vel.thirumurthy-kumar@external.merckgroup.com, vijayalakshmi.munnaluru@external.merckgroup.com, vignesh.ravi@external.merckgroup.com, matrs.automatedbot@merckgroup.com"
SUBJECT="LMS Mantra Report"
SUBJECT1="LMS Mantra Report Issue"
TEMPFILE=$(mktemp)

# Find new files created today
#Find "$DIRECTORY" -type f -newermt "$(date +'%Y-%m-%d')" ! -newermt "$(date -d tomorrow +'%Y-%m-%d')" -print > "$TEMPFILE"
find "$DIRECTORY" -type f -newermt "$(date +'%Y-%m-%d')" ! -newermt "$(date -d tomorrow +'%Y-%m-%d')" -printf "%T+ %p\n" | sort -r | head -n 1 > "$TEMPFILE"

if [ -s "$TEMPFILE" ]; then
{
echo "Hi Everyone,"
echo ""
echo "Good day!"
echo ""
while IFS= read -r FILEINFO; do
FILE=$(echo $FILEINFO | awk '{print $2}')
WORDCOUNT=$(wc -l < "$FILE")
echo "Today's count in Mantra-HR4YOU workflow in the File: $FILE - Word Count: $WORDCOUNT"
done < "$TEMPFILE"
echo ""
echo "Please reach us INT_RRD_Cognizant(R109576@merckgroup.com), if you have any concern"
echo ""
echo ""
echo "Thanks"
echo "MATRS."
echo ""
echo "! This is automated email from MATRS BOT. Please don't respond back."
} > "$LOGFILE"

# Send email
mail -s "$SUBJECT" -c "$RECIPIENTS" "R109576@merckgroup.com" "R109567@merckgroup.com"  < "$LOGFILE"
# Send email to alternative
else
{
echo "Hi Team,"
echo ""
echo "No new files found in the directory '$DIRECTORY' today."
echo ""
echo "Please check on the issue and kindly inform the update to INT_RRD_Cognizant - R109576@merckgroup.com."
echo ""
echo "Thanks"
echo "MATRS."
echo ""
echo ""
echo "! This is automated email from MATRS BOT. Please don't respond back."
} > "$LOGFILE"
mail -s "$SUBJECT1" -c "$RECIPIENTS1" "ravali.puppala@external.merckgroup.com, sarath-babu.elaiyappan@external.merckgroup.com" "R109507@merckgroup.com" < "$LOGFILE"
fi


# Cleanup
rm "$TEMPFILE"
