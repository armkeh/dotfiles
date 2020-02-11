
# Folder shortcuts
alias   cdh='cd ~'
alias  cddb='cd ~/Dropbox'
alias  cdmm='cd ~/Dropbox/McMaster'
alias  cd3m='cd ~/Dropbox/McMaster/3mi3'
alias  cd3e='cd ~/Dropbox/McMaster/3ea3'
alias  cdth='cd ~/Dropbox/McMaster/Agda/thesis'
alias cdorg='cd ~/Dropbox/Organisation'



# "Temporary" shortcuts
alias cdadev='cd ~/Dropbox/McMaster/3ea3/assignment-development/'
alias cdapub='cd ~/Dropbox/McMaster/3ea3/assignment-development/published'
alias cdadist='cd ~/Dropbox/McMaster/3ea3/assignment-distribution/'
alias 3e-assign-fetch='python3.5 clone.py 3ea3-winter2019 --token-file .gitlab-token --clone-dir ../student-repos/ --students kandeeps,horsmane,anderj12 --url-type http-save'
alias 3e-assign-fetch-date='python3.5 clone.py 3ea3-winter2019 --token-file .gitlab-token --clone-dir ../student-repos/ --students kandeeps,horsmane,anderj12 --url-type http-save --revert-date'


# Commands

# Dropbox (with filesystem fix)
alias dbstart='/opt/dropbox-filesystem-fix/dropbox_start.py &> /dev/null'
alias dbstatus='python ~/Dropbox/Organisation/scripts/dropbox.py status'
alias dbstop='python ~/Dropbox/Organisation/scripts/dropbox.py stop'

# Git
alias gadd='git add'
alias gmv='git mv'
alias gcomm='git commit'
alias gpull='git pull'
alias gpush='git push -u origin master'

# Latex
alias lagda2pdf='echo "Make me..."'
