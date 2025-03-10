alias h="heroku"
alias hs="heroku sudo"
alias hh="heroku help"

# You have to have sfdx installed for this to work, and must login to GUS via `sfdx login`
teamfor() {
  # Update MY_USER with your GUS email address (it should be your normal email, but @gus.com instead of @salesforce.com)
  MY_USER="joseph.wegner@gus.com"
  LOOKUP_USER="$1"
  sf data query -q "SELECT Scrum_Team_Name__c, Allocation__c FROM ADM_Scrum_Team_Member__c WHERE Internal_Email__c='$LOOKUP_USER'" -o '00DT0000000DpvcMAC' -r human
}

hotp() {
  op item get "SFDC Heroku" --otp
}
alias copy_hotp="hotp | tr '\n' ' '| pbcopy"
