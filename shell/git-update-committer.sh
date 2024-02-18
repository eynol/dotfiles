git filter-branch --env-filter ' 
OLD_EMAIL="kyle.tk@umbrellacorp.com" 
NEW_EMAIL="625608852@qq.com" 
NEW_NAME="eynol" 
if test "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" 
then 
	GIT_AUTHOR_EMAIL=$NEW_EMAIL 
	GIT_AUTHOR_NAME=$NEW_NAME
fi 

if test "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" 
then 
	GIT_COMMITTER_EMAIL=$NEW_EMAIL 
	GIT_COMMITTER_NAME=$NEW_NAME 
fi' -- --all